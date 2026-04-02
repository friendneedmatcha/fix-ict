import {
  Injectable,
  NotFoundException,
  UnauthorizedException,
} from '@nestjs/common';
import { RegisterDto } from './dto/register.dto';
import { UserService } from '../user/user.service';
import { JwtService } from '@nestjs/jwt';
import * as bcrypt from 'bcrypt';
import { LoginDto } from './dto/login.dto';

@Injectable()
export class AuthService {
  constructor(
    private userService: UserService,
    private jwtService: JwtService,
  ) {}

  async login(data: LoginDto) {
    const email = await this.userService.findbyemail(data.email);
    if (!email) {
      throw new NotFoundException('notfound user');
    }
    if (email.password !== data.password) {
      throw new UnauthorizedException('password incorrect');
    }
    return this.generateToken(email);
  }

  async register(data: RegisterDto) {
    const user = await this.userService.create(data);

    return this.generateToken(user.result);
  }

  async generateToken(user: any) {
    const payload = {
      userid: user.id,
      email: user.email,
      role: user.role,
    };

    const refreshToken = this.jwtService.sign(payload, {
      secret: process.env.JWT_REFRESH,
      expiresIn: '7d',
    });

    const accessToken = this.jwtService.sign(payload, {
      secret: process.env.JWT_SECRET,
      expiresIn: '15m',
    });

    const hashToken = await bcrypt.hash(refreshToken, 10);
    await this.userService.updateRefreshToken(user.id, hashToken);
    return {
      accessToken,
      refreshToken,
    };
  }
}
