import { ExtractJwt, Strategy } from 'passport-jwt';
import { PassportStrategy } from '@nestjs/passport';
import { Injectable } from '@nestjs/common';
import { Request } from 'express';
@Injectable()
export class JwtRefreshStrategy extends PassportStrategy(
  Strategy,
  'jwt-refresh',
) {
  constructor() {
    super({
      jwtFromRequest: ExtractJwt.fromBodyField('refreshToken'),
      // ignoreExpiration: false,
      secretOrKey: process.env.JWT_REFRESH as string,
      passReqToCallback: true,
    });
  }

  validate(req: Request, payload: any) {
    return {
      ...payload,
      refreshToken: req.body.refreshToken,
    };
  }
}
