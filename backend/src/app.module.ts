import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { PrismaModule } from './prisma/prisma.module';
import { PrismaService } from './prisma/prisma.service';
import { TestapiModule } from './testapi/testapi.module';

@Module({
  imports: [PrismaModule, TestapiModule],
  controllers: [AppController],
  providers: [AppService, PrismaService],
})
export class AppModule {}
