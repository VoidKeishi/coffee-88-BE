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

    @Column('text', { array: true })
    image_urls: string[];

    @Column({ type: 'enum', enum: PRICE_RANGE })
    price_range: PRICE_RANGE;

    @Column({ type: 'enum', enum: CAFE_STYLE })
    style: CAFE_STYLE;

    @Column({ type: 'decimal', precision: 2, scale: 1 })
    google_rating: number;

    @Column('time')
    opening_time: string;

    @Column('time')
    closing_time: string;

    @Index()
    @Column({ type: 'decimal', precision: 5, scale: 2 })
    distance_from_sun: number;

    @CreateDateColumn({ type: 'timestamp', default: () => 'CURRENT_TIMESTAMP' })
    created_at: Date;

    @UpdateDateColumn({ type: 'timestamp', default: () => 'CURRENT_TIMESTAMP' })
    updated_at: Date;

    @OneToMany(() => Drink, drink => drink.cafe)
    drinks: Drink[];
}