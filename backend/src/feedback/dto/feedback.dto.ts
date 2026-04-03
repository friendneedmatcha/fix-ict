import { IsInt, IsOptional, IsString } from 'class-validator';

export class FeedbackDto {
  @IsInt()
  rating: number;
  @IsString()
  @IsOptional()
  comment: string;
}
