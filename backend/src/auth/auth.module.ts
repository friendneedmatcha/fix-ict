import { Module } from '@nestjs/common';
import { AuthService } from './auth.service';
import { AuthController } from './auth.controller';
import { PassportModule } from '@nestjs/passport';
import { JwtModule, JwtService } from '@nestjs/jwt';
import { UserService } from 'src/user/user.service';
import { JwtStrategy } from './strategries/jwt.strategy';
import { JwtRefreshStrategy } from './strategries/jwt-refresh.strategy';
@Module({
  imports: [PassportModule, JwtModule],
  controllers: [AuthController],
  providers: [
    AuthService,
    JwtService,
    UserService,
    JwtStrategy,
    JwtRefreshStrategy,
  ],
})
export class AuthModule {}
