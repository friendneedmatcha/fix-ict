import { ConflictException, Injectable } from '@nestjs/common';
import { PrismaService } from 'src/prisma/prisma.service';
import { RegisterDto } from './dto/register.dto';

@Injectable()
export class TestapiService {
  constructor(private prisma: PrismaService) {}
  async create(xx: RegisterDto) {
    const email = await this.prisma.user.findUnique({
      where: { email: xx.email },
    });

    if (email) {
      throw new ConflictException('Email already exist');
    }
    const user = await this.prisma.user.create({
      data: xx,
    });
    return user;
  }
}
