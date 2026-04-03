import {
  Body,
  Controller,
  Delete,
  Get,
  Param,
  Post,
  Put,
  UseGuards,
} from '@nestjs/common';
import { UserService } from './user.service';
import { UserDto } from './dto/user.dto';
import { UserCreateDto } from './dto/user-create.dto';
import { JwtAuthGuard } from 'src/auth/guards/jwt-auth.guard';
import { RolesGuard } from 'src/auth/guards/role.guard';
import { Roles } from 'src/auth/decorator/role.decorator';
import { Role } from 'generated/prisma/enums';

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
  update(@Param('id') id: string, @Body() data: UserDto) {
    return this.userService.update(id, data);
  }

  @Delete(':id')
  delete(@Param('id') id: string) {
    return this.userService.delete(id);
  }

  @Post()
  create(@Body() data: UserCreateDto) {
    return this.userService.create(data);
  }
}
