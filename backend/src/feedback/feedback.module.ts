import { Module } from '@nestjs/common';
import { FeedbackService } from './feedback.service';
import { PrismaModule } from 'src/prisma/prisma.module';
import { PrismaService } from 'src/prisma/prisma.service';

@Module({
  imports: [PrismaModule],
  providers: [FeedbackService, PrismaService],
})
export class FeedbackModule {}
