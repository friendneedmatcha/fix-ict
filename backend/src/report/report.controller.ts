import {
  Body,
  Controller,
  Delete,
  Get,
  Param,
  ParseIntPipe,
  Patch,
  Post,
} from '@nestjs/common';
import { ReportService } from './report.service';
import { UpdateReportDto } from './dto/update-report.dto';
import { CreateReportDto } from './dto/create-report.dto';

@Controller('report')
export class ReportController {
  constructor(private readonly reportService: ReportService) {}

  @Post()
  async createReport(@Body() data: CreateReportDto) {
    return await this.reportService.create(data);
  }

  @Get('top')
  gettopfive() {
    return this.reportService.gettopfive();
  }

  @Get()
  getAll() {
    return this.reportService.getAll();
  }

  @Get('user/:id')
  getbyuser(@Param('id', ParseIntPipe) id: number) {
    return this.reportService.getbyuser(id);
  }

  @Patch(':id')
  update(@Param('id', ParseIntPipe) id: number, @Body() data: UpdateReportDto) {
    return this.reportService.update(id, data);
  }

  @Get(':id')
  getbyid(@Param('id', ParseIntPipe) id: number) {
    return this.reportService.getbyid(id);
  }

  @Delete(':id')
  delete(@Param('id', ParseIntPipe) id: number) {
    return this.reportService.delete(id);
  }
}
