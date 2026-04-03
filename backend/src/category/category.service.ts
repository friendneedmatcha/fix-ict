import {
  ConflictException,
  Injectable,
  InternalServerErrorException,
  NotFoundException,
} from '@nestjs/common';
import { CreateCategoryDto } from './dto/create-category.dto';
import { PrismaService } from '../prisma/prisma.service';

@Injectable()
export class CategoryService {
  constructor(private prisma: PrismaService) {}
  async create(data: CreateCategoryDto) {
    try {
      const check = await this.findByName(data.name);
      if (check) {
        throw new ConflictException('dup');
      }

      const cat = await this.prisma.category.create({
        data: data,
      });
      return {
        message: 'success',
        cat,
      };
    } catch (err) {
      if (err instanceof ConflictException) {
        throw err;
      }

      throw new InternalServerErrorException();
    }
  }

  async findByName(xx: string) {
    return this.prisma.category.findFirst({
      where: {
        name: xx,
      },
    });
  }

  async findAll() {
    try {
      const user = await this.prisma.category.findMany();
      if (user.length == 0) {
        throw new NotFoundException('Not Found user');
      }

      return user;
    } catch (err) {
      if (err) {
        throw new NotFoundException('Not Found user');
      }
      throw new InternalServerErrorException('Server Error');
    }
  }

  async findOne(name: string) {
    return this.prisma.category.findFirst({
      where: {
        name: name,
      },
    });
  }

  update(id: number, data: CreateCategoryDto) {
    return `This action updates a #${id} category`;
  }

  remove(id: number) {
    return `This action removes a #${id} category`;
  }
}
