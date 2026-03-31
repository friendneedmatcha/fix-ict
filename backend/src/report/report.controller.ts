import { Body, Controller, Get, Param, Patch } from '@nestjs/common';
import { ReportService } from './report.service';
import { UpdateReportDto } from './dto/update-report.dto';

@Controller('report')
export class ReportController {
  constructor(private readonly reportService: ReportService) {}

  @Patch(':id')
  update(@Param('id') id: number, @Body() data: UpdateReportDto) {
    return this.reportService.update(id, data);
  }

  @Get()
  getAll() {
    return this.reportService.getAll();
  }
}
