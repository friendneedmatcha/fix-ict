import { Module } from '@nestjs/common';
import { TestapiService } from './testapi.service';
import { TestapiController } from './testapi.controller';
import { PrismaModule } from 'src/prisma/prisma.module';
import { PrismaService } from 'src/prisma/prisma.service';

@Module({
  imports: [PrismaModule],
  controllers: [TestapiController],
  providers: [TestapiService, PrismaService],
})
export class TestapiModule {}
