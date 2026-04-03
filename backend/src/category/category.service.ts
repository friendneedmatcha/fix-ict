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

  async findById(id: number) {
    return this.prisma.category.findFirst({
      where: {
        id: +id,
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

  async update(id: number, data: CreateCategoryDto) {
    const checkId = await this.findById(id);
    if (!checkId) throw new NotFoundException('not found');
    const update = await this.prisma.category.update({
      where: {
        id: +id,
      },
      data: {
        name: data.name,
      },
    });
    return update;
  }

  async remove(id: number) {
    const checkId = await this.findById(id);
    if (!checkId) throw new NotFoundException('not found');
    const delSt = await this.prisma.category.delete({
      where: {
        id: +id,
      },
    });
    return {
      message: 'delete successfully',
      delSt,
    };
  }
}
