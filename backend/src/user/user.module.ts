import { Module } from '@nestjs/common';
import { UserService } from './user.service';
import { UserController } from './user.controller';
import { AuthModule } from 'src/auth/auth.module';
import { RolesGuard } from 'src/auth/guards/role.guard';

@Module({
  imports: [AuthModule],
  controllers: [UserController],
  providers: [UserService, RolesGuard],
})
export class UserModule {}
