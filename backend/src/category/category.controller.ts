import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
  Req,
} from '@nestjs/common';
import { CategoryService } from './category.service';
import { CreateCategoryDto } from './dto/create-category.dto';

@Controller('category')
export class CategoryController {
  constructor(private readonly categoryService: CategoryService) {}
  @Post()
  create(@Body() xx: CreateCategoryDto) {
    return this.categoryService.create(xx);
  }

  @Get()
  getall() {
    return this.categoryService.findAll();
  }

  @Get(':name')
  getOne(@Param('name') name: string) {
    console.log(name);
  }
}
