import { Injectable } from '@nestjs/common';
import { PrismaService } from 'src/prisma/prisma.service';
import { RegisterDto } from './dto/register.dto';

@Injectable()
export class TestapiService {
  constructor(private prisma: PrismaService) {}
  create(xx: RegisterDto) {
    return this.prisma.user.create({
      data: xx,
    });
  }
}
