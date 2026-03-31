import {
  Injectable,
  InternalServerErrorException,
  NotFoundException,
} from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { UpdateReportDto } from './dto/update-report.dto';
@Injectable()
export class ReportService {
  constructor(private prisma: PrismaService) {}

  async getAll() {
    try {
      const report = await this.prisma.report.findMany();
      return report;
    } catch {
      throw new InternalServerErrorException('Server Error');
    }
  }

  async getbyid(id: number) {
    try {
      const reportid = await this.prisma.report.findUnique({
        where: { id },
      });
      if (!reportid) {
        throw new NotFoundException(`Not Found report id: ${id}`);
      }
      return reportid;
    } catch (err) {
      if (err) {
        throw err;
      }
      throw new InternalServerErrorException('Server Error');
    }
  }

  async delete(id: number) {
    try {
      await this.getbyid(id);
      return await this.prisma.$transaction(async (a) => {
        await a.feedback.deleteMany({ where: { reportId: id } });

        await a.reportUpdate.deleteMany({ where: { reportId: id } });

        await a.report.delete({ where: { id } });

        return { message: 'Delete Success' };
      });
    } catch (err) {
      if (err) {
        throw err;
      }
      throw new InternalServerErrorException('Server Error');
    }
  }

  async update(id: number, data: UpdateReportDto) {
    try {
      await this.getbyid(id);

      return await this.prisma.report.update({
        where: { id },
        data,
      });
    } catch (err) {
      if (err) {
        throw err;
      }
      throw new InternalServerErrorException('Server Error');
    }
  }
}
