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

  async create(data: CreateReportDto, file: Express.Multer.File) {
    console.log(file);
    try {
      const result = await this.prisma.report.create({
        data: {
          title: data.title,
          description: data.description,
          location: data.location,
          priority: data.priority,
          imageBefore: file.filename,
          userId: +data.userId,
          categoryId: +data.categoryId,
        },
      });
      return {
        messsage: 'success',
        data: result,
      };
    } catch (err) {
      console.log(err);
      throw new InternalServerErrorException('Server Error');
    }
  }

  async getAll() {
    try {
      const report = await this.prisma.report.findMany({
        include: {
          updates: {
            where: { status: 'SUCCESS' },
          },
        },
      });
      return report;
    } catch {
      throw new InternalServerErrorException('Server Error');
    }
  }

  async getbyuser(id: number) {
    try {
      return await this.prisma.report.findMany({
        where: { userId: id },
        include: {
          updates: {
            where: { status: 'SUCCESS' },
          },
        },
      });
    } catch (err) {
      if (err instanceof NotFoundException) {
        throw err;
      }
      throw new InternalServerErrorException('Server Error');
    }
  }

  async getbyid(id: number) {
    try {
      const reportid = await this.prisma.report.findUnique({
        where: { id },
        include: {
          updates: {
            where: { status: 'SUCCESS' },
          },
        },
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

  async update(id: number, data: UpdateReportDto, file: Express.Multer.File) {
    try {
      await this.getbyid(id);
      return await this.prisma.$transaction(async (tx) => {
        const filename =
          data.status == 'SUCCESS' && file ? file.filename : null;
        await tx.reportUpdate.create({
          data: {
            reportId: id,
            status: data.status,
            note: data.note,
            imageAfter: filename,
            updatedBy: +data.updatedBy,
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
