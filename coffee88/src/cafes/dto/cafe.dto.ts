import { Drink } from '../entities/drink.entity';
import { PRICE_RANGE, CAFE_STYLE } from '../entities/enums';

export class CafeDto {
  id: number;
  name: string;
  address: string;
  image_urls: string[];
  price_range: PRICE_RANGE;
  style: CAFE_STYLE;
  google_rating: number;
  opening_time: string;
  closing_time: string;
  distance_from_sun: number;
}