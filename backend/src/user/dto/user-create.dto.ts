import { Exclude } from 'class-transformer';
import { IsString, IsOptional, IsEmail, IsEnum } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';
import { Role } from 'generated/prisma/enums';

export class UserCreateDto {
  @IsString()
  @ApiProperty({ example: 'boat' })
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

  @IsEnum(Role)
  @IsOptional()
  role?: Role;
  @IsString()
  @IsOptional()
  profileImage?: string;
}
