import {
  Controller,
  Get,
  Post,
  Body,
  Param,
  Delete,
  Put,
  Query,
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

  // @Get()
  // getall() {
  //   return this.categoryService.findAll();
  // }

  @Get()
  getOne(@Query('name') name?: string) {
    if (name) {
      console.log(name);
      return this.categoryService.findByName(name);
    }
    return this.categoryService.findAll();
  }

  @Put(':id')
  update(@Param('id') id: number, @Body() data: CreateCategoryDto) {
    return this.categoryService.update(id, data);
  }

  @Delete(':id')
  delete(@Param('id') id: number) {
    return this.categoryService.remove(+id);
  }
}
