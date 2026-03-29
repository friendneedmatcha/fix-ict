import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
} from '@nestjs/common';
import { TestapiService } from './testapi.service';
import { RegisterDto } from './dto/register.dto';

@Controller('testapi')
export class TestapiController {
  constructor(private readonly testapiService: TestapiService) {}

  @Post()
  create(@Body() xx: RegisterDto) {
    return this.testapiService.create(xx);
  }
}
