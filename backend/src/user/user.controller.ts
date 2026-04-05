import {
  Body,
  Controller,
  Delete,
  Get,
  Param,
  Post,
  Put,
  UploadedFile,
  UseGuards,
  UseInterceptors,
} from '@nestjs/common';
import { UserService } from './user.service';
import { UserDto } from './dto/user.dto';
import { UserCreateDto } from './dto/user-create.dto';
import { JwtAuthGuard } from 'src/auth/guards/jwt-auth.guard';
import { RolesGuard } from 'src/auth/guards/role.guard';
import { Roles } from 'src/auth/decorator/role.decorator';
import { Role } from 'generated/prisma/enums';
import { FileInterceptor } from '@nestjs/platform-express';
import { multerConfig } from 'src/multer.config';

@Controller('user')
export class UserController {
  constructor(private readonly userService: UserService) {}

  @UseGuards(JwtAuthGuard, RolesGuard)
  @Roles(Role.ADMIN)
  @Get()
  getAll() {
    return this.userService.getAll();
  }

  @Get(':id')
  getbyID(@Param('id') id: string) {
    return this.userService.getbyid(id);
  }

  @Put(':id')
  @UseInterceptors(FileInterceptor('file', multerConfig))
  update(
    @Param('id') id: string,
    @Body() data: UserDto,
    @UploadedFile() file: Express.Multer.File,
  ) {
    return this.userService.update(id, data, file);
  }

  @Delete(':id')
  delete(@Param('id') id: string) {
    return this.userService.delete(id);
  }

  @UseGuards(JwtAuthGuard, RolesGuard)
  @Roles(Role.ADMIN)
  @Post()
  create(@Body() data: UserCreateDto) {
    return this.userService.create(data);
  }
}
