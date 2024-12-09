import { IsBoolean, IsEnum, IsInt } from 'class-validator';
import { PRICE_RANGE } from '../entities/enums';

export class UserPreferenceDto {
  @IsInt()
  userId: number;

  @IsBoolean()
  personalization: boolean;

  @IsEnum(PRICE_RANGE)
  priceRange: PRICE_RANGE;
}
