import { Exclude } from 'class-transformer';
import { IsString, IsOptional, IsEmail } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';

export class UserCreateDto {
  @IsString()
  @ApiProperty({ example: 'boat' })
  firstName?: string;
  @IsString()
  lastName?: string;
  @IsEmail()
  email?: string;
  // @Exclude()
  @IsString()
  password?: string;
  @IsString()
  tel?: string;
  @IsString()
  @IsOptional()
  profileImage?: string;
}
