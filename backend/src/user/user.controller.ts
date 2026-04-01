import {
  Body,
  Controller,
  Delete,
  Get,
  Param,
  Post,
  Put,
} from '@nestjs/common';
import { UserService } from './user.service';
import { UserDto } from './dto/user.dto';
import { UserCreateDto } from './dto/user-create.dto';

@Controller('user')
export class UserController {
  constructor(private readonly userService: UserService) {}

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
