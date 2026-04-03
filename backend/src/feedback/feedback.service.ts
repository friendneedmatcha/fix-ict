import { Injectable } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { FeedbackDto } from './dto/feedback.dto';
import { report } from 'process';

@Injectable()
export class FeedbackService {
  constructor(private prisma: PrismaService) {}

  async create(reportId: number, data: FeedbackDto, userId: number) {
    return this.prisma.feedback.create({
      data: {
        reportId: reportId,
        userId: userId,
        rating: data.rating,
        comment: data.comment,
      },
    });
  }
}
