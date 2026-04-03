import { Module } from '@nestjs/common';
import { ReportService } from './report.service';
import { ReportController } from './report.controller';
import { FeedbackModule } from 'src/feedback/feedback.module';
import { FeedbackService } from 'src/feedback/feedback.service';

@Module({
  imports: [FeedbackModule],
  controllers: [ReportController],
  providers: [ReportService, FeedbackService],
})
export class ReportModule {}
