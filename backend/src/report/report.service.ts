import {
  Injectable,
  InternalServerErrorException,
  NotFoundException,
} from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { UpdateReportDto } from './dto/update-report.dto';
import { CreateReportDto } from './dto/create-report.dto';
@Injectable()
export class ReportService {
  constructor(private prisma: PrismaService) {}

  // async create(data: CreateReportDto) {
  //   try {
  //     return await this.prisma.report.create({ data });
  //   } catch {
  //     throw new InternalServerErrorException('Server Error');
  //   }
  // }

  async getAll() {
    try {
      const report = await this.prisma.report.findMany();
      return report;
    } catch {
      throw new InternalServerErrorException('Server Error');
    }
  }

  // async getbyuser(id: number) {
  //   try {
  //     return await this.prisma.report.findMany({ where: { userId: id } });
  //   } catch (err) {
  //     if (err instanceof NotFoundException) {
  //       throw err;
  //     }
  //     throw new InternalServerErrorException('Server Error');
  //   }
  // }

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
      if (err instanceof NotFoundException) {
        throw err;
      }
      throw new InternalServerErrorException('Server Error');
    }
  }

  async delete(id: number) {
    try {
      await this.getbyid(id);
      await this.prisma.report.delete({ where: { id } });
      return { message: 'Delete Success' };
    } catch (err) {
      if (err instanceof NotFoundException) {
        throw err;
      }
      throw new InternalServerErrorException('Server Error');
    }
  }

  async update(id: number, data: UpdateReportDto) {
    try {
      await this.getbyid(id);

      return await this.prisma.$transaction(async (tx) => {
        await tx.reportUpdate.create({
          data: {
            reportId: id,
            status: data.status,
            note: data.note,
            imageAfter: data.imageAfter,
            updatedBy: data.updatedBy,
          },
        });

        return await tx.report.update({
          where: { id: id },
          data: {
            status: data.status,
          },
        });
      });
    } catch (err) {
      if (err instanceof NotFoundException) {
        throw err;
      }
      console.log(err);
      throw new InternalServerErrorException('Server Error');
    }
  }

  async gettopfive() {
    try {
      return this.prisma.report.findMany({
        take: 5,
        orderBy: { createdAt: 'desc' },
      });
    } catch {
      throw new InternalServerErrorException('Server Error');
    }
  }
}
