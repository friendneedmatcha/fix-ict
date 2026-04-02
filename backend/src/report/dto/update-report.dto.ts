import { IsString, IsInt, IsEnum, IsOptional } from 'class-validator';
import { Status } from '../../../generated/prisma/client';

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
  updatedBy: number;
}
