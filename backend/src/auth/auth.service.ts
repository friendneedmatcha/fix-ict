import {
  ForbiddenException,
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
    const checkPass = await bcrypt.compare(data.password, email.password);
    if (!checkPass) {
      throw new UnauthorizedException('password incorrect');
    }
    const { password, ...result } = email;
    return {
      message: 'login success',
      data: {
        token: await this.generateToken(email),
        user: result,
      },
    };
  }

  async register(data: RegisterDto) {
    const user = await this.userService.create(data);

    return {
      message: 'register success',
      data: {
        token: await this.generateToken(user.result),
        user: user.result,
      },
    };
  }

  async logout(userId: number) {
    const user = await this.userService.updateRefreshToken(userId, null);
    return {
      message: 'logout success',
    };
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

  async refreshToken(email: string, rt: string) {
    const checkUser = await this.userService.findbyemail(email);
    if (!checkUser || !checkUser.refreshtoken) {
      throw new ForbiddenException();
    }
    const checkToken = await bcrypt.compare(rt, checkUser.refreshtoken);
    if (!checkToken) throw new ForbiddenException();

    return this.generateToken(checkUser);
  }
}
