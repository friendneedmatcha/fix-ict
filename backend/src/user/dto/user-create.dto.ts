import { Exclude } from 'class-transformer';
import { IsString } from 'class-validator';

export class UserCreateDto {
  @IsString()
  firstName: string;
  @IsString()
  lastName: string;
  @IsString()
  email: string;
  @Exclude()
  @IsString()
  password: string;
  @IsString()
  tel: string;
  @IsString()
  profileImage: string;
}
