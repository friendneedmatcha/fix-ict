import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { PrismaModule } from './prisma/prisma.module';
import { PrismaService } from './prisma/prisma.service';
import { TestapiModule } from './testapi/testapi.module';
import { UserModule } from './user/user.module';
import { ReportModule } from './report/report.module';

@Module({
  imports: [PrismaModule, TestapiModule, UserModule, ReportModule],
  controllers: [AppController],
  providers: [AppService, PrismaService],
})
export class AppModule {}
