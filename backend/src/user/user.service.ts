import {
  ConflictException,
  Injectable,
  InternalServerErrorException,
  NotFoundException,
} from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { UserDto } from './dto/user.dto';
import { UserCreateDto } from './dto/user-create.dto';
import * as bcrypt from 'bcrypt';
@Injectable()
export class UserService {
  constructor(private prisma: PrismaService) {}
  async getAll() {
    try {
      const user = await this.prisma.user.findMany();
      if (user.length == 0) {
        throw new NotFoundException('Not Found user');
      }

      return user.map((user) => {
        const { password, ...result } = user;
        return result;
      });
    } catch (err) {
      if (err) {
        throw new NotFoundException('Not Found user');
      }
      throw new InternalServerErrorException('Server Error');
    }
  }

  async getbyid(id: string) {
    try {
      const user = await this.prisma.user.findUnique({
        where: {
          id: +id,
        },
      });
      if (!user) {
        throw new NotFoundException(`Not found this id ${id}`);
      }
      const { password, ...result } = user;
      return result;
    } catch (err) {
      if (err instanceof NotFoundException) {
        throw err;
      }
      throw new InternalServerErrorException('Server Error');
    }
  }

  async update(id: string, data: UserDto) {
    const checkMail = await this.findbyemail(data.email);
    if (checkMail) throw new ConflictException('dup mail');
    const updateData = { ...data };

    if (updateData.password) {
      updateData.password = await bcrypt.hash(updateData.password, 10);
    }

    try {
      const update = await this.prisma.user.update({
        where: { id: +id },
        data: updateData,
      });

      return {
        message: 'Update Success',
        update,
      };
    } catch (err) {
      if (err instanceof NotFoundException) {
        throw err;
      }
      console.log(err);
      throw new InternalServerErrorException('Server Error');
    }
  }

  async delete(id: string) {
    try {
      await this.getbyid(id);

      await this.prisma.user.delete({ where: { id: +id } });
      return { message: 'Delete Success' };
    } catch (err) {
      if (err instanceof NotFoundException) {
        throw err;
      }
      throw new InternalServerErrorException('Server Error');
    }
  }

  async create(data: UserCreateDto) {
    try {
      const email = await this.findbyemail(data.email);
      // console.log('555');
      if (email) {
        throw new ConflictException('Email already exist');
      }

      const hashpassword = await bcrypt.hash(data.password, 10);

      const createuser = await this.prisma.user.create({
        data: {
          firstName: data.firstName,
          lastName: data.lastName,
          email: data.email,
          password: hashpassword,
          tel: data.tel,
          profileImage: data.profileImage,
        },
      });

      const { password, ...result } = createuser;

      return { message: 'create success', result };
    } catch (err) {
      if (err instanceof ConflictException) {
        throw err;
      }
      throw new InternalServerErrorException('Server Error');
    }
  }

  async findbyemail(email: string) {
    try {
      return await this.prisma.user.findUnique({
        where: { email: email },
      });
    } catch (err) {
      if (err instanceof NotFoundException) {
        throw err;
      }
      throw new InternalServerErrorException('Server Error');
    }
  }

  updateRefreshToken(userId: number, token: string | null) {
    // console.log(userId, token);
    return this.prisma.user.update({
      where: {
        id: +userId,
      },
      data: { refreshtoken: token },
    });
  }
}
