import { Entity, Column, PrimaryGeneratedColumn, CreateDateColumn, UpdateDateColumn, Index, OneToMany } from 'typeorm';
import { Drink } from './drink.entity';
import { PRICE_RANGE, CAFE_STYLE } from './enums';

@Entity('cafes')
export class Cafe {
  @PrimaryGeneratedColumn()
  id: number;

  @Column({ length: 100 })
  name: string;

  @Column('text')
  address: string;

  @Column('text', { array: true, name: 'imageUrls' })
  image_urls: string[];

  @Column({ type: 'enum', enum: PRICE_RANGE, name: 'priceRange' })
  price_range: PRICE_RANGE;

  @Column({ type: 'enum', enum: CAFE_STYLE })
  style: CAFE_STYLE;

  @Column({ type: 'decimal', precision: 2, scale: 1, name: 'googleRating' })
  google_rating: number;

  @Column('time', { name: 'openingTime' })
  opening_time: string;

  @Column('time', { name: 'closingTime' })
  closing_time: string;

  @Index('idx_distanceFromSun')
  @Column({ type: 'decimal', precision: 5, scale: 2, name: 'distanceFromSun' })
  distance_from_sun: number;

  @CreateDateColumn({ type: 'timestamp', default: () => 'CURRENT_TIMESTAMP' })
  created_at: Date;

  @UpdateDateColumn({ type: 'timestamp', default: () => 'CURRENT_TIMESTAMP' })
  updated_at: Date;

  @OneToMany(() => Drink, drink => drink.cafe)
  drinks: Drink[];
}