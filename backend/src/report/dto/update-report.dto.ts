import { IsString, IsInt, IsEnum, IsOptional } from 'class-validator';
import { Status } from '../../../generated/prisma/client';
import { Type } from 'class-transformer';

export class UpdateReportDto {
  @IsEnum(Status)
  status: Status;

  @IsOptional()
  @IsString()
  note?: string;

  @IsOptional()
  @IsString()
  imageAfter?: string;

  @IsInt()
  @Type(() => Number)
  updatedBy: number;
}
