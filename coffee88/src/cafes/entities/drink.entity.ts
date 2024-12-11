import { Entity, Column, PrimaryGeneratedColumn, CreateDateColumn, UpdateDateColumn, ManyToOne, Index } from 'typeorm';
import { Cafe } from './cafe.entity';
import { DRINK_TYPE } from './enums';

@Entity('drinks')
export class Drink {
    @PrimaryGeneratedColumn()
    id: number;

    @ManyToOne(() => Cafe, cafe => cafe.drinks)
    @Index()
    cafe: Cafe;

    @Column({ length: 100 })
    name: string;

    @Column({ type: 'enum', enum: DRINK_TYPE, enumName: 'drink_type' })
    type: DRINK_TYPE;

    @Column({ type: 'decimal', precision: 10, scale: 2 })
    price: number;

    @Column('text', { nullable: true })
    description: string;

    @Column('text', { nullable: true })
    image_url: string;

    @Column({ type: 'boolean', default: true })
    is_available: boolean;

    @CreateDateColumn({ type: 'timestamp', default: () => 'CURRENT_TIMESTAMP' })
    created_at: Date;

    @UpdateDateColumn({ type: 'timestamp', default: () => 'CURRENT_TIMESTAMP' })
    updated_at: Date;
}