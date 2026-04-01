import { Exclude } from 'class-transformer';
import { IsString, IsOptional } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';

export class UserCreateDto {
  @IsString()
  @ApiProperty({ example: 'boat' })
  firstName: string;
  @IsString()
  lastName: string;
  @IsString()
  email: string;
  // @Exclude()
  @IsString()
  password: string;
  @IsString()
  tel: string;
  @IsString()
  @IsOptional()
  profileImage: string;
}
