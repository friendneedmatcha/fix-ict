import {
  Body,
  Controller,
  Delete,
  Get,
  Param,
  ParseIntPipe,
  Patch,
  Post,
  Req,
  UploadedFile,
  UseGuards,
  UseInterceptors,
} from '@nestjs/common';
import { ReportService } from './report.service';
import { UpdateReportDto } from './dto/update-report.dto';
import { CreateReportDto } from './dto/create-report.dto';
import { JwtAuthGuard } from 'src/auth/guards/jwt-auth.guard';
import { FeedbackDto } from '../feedback/dto/feedback.dto';
import { FeedbackService } from '../feedback/feedback.service';
import { FileInterceptor } from '@nestjs/platform-express';
import { multerConfig } from 'src/multer.config';

@Controller('report')
export class ReportController {
  constructor(
    private readonly reportService: ReportService,
    private feedbackService: FeedbackService,
  ) {}

  @Post()
  @UseInterceptors(FileInterceptor('file', multerConfig))
  async createReport(
    @Body() data: CreateReportDto,
    @UploadedFile() file: Express.Multer.File,
  ) {
    return await this.reportService.create(data, file);
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

  @UseGuards(JwtAuthGuard)
  @Post(':id/feedback')
  feedback(
    @Param('id', ParseIntPipe) reportId: number,
    @Req() req,
    @Body() data: FeedbackDto,
  ) {
    return this.feedbackService.create(reportId, data, req.user.userid);
  }
}
