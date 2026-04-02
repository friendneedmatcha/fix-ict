import { Module } from '@nestjs/common';
import { AuthService } from './auth.service';
import { AuthController } from './auth.controller';
import { PassportModule } from '@nestjs/passport';
import { JwtModule, JwtService } from '@nestjs/jwt';
import { UserService } from 'src/user/user.service';
@Module({
  imports: [PassportModule, JwtModule],
  controllers: [AuthController],
  providers: [AuthService, JwtService, UserService],
})
export class AuthModule {}
