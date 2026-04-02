import { IsEmail, IsString } from 'class-validator';

export class RegisterDto {
  @IsString()
  firstName: string;
  @IsString()
  lastName: string;
  @IsEmail()
  email: string;
  // @Exclude()
  @IsString()
  password: string;
  @IsString()
  tel: string;
}
