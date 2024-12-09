import {
  Column,
  Entity,
  JoinColumn,
  OneToOne,
  PrimaryGeneratedColumn,
} from 'typeorm';
import { User } from './user.entity';
import { PRICE_RANGE } from './enums';

@Entity('user-preferences')
export class UserPreferences {
  @PrimaryGeneratedColumn()
  id: number;

  @OneToOne(() => User)
  @JoinColumn({ name: 'userId' })
  user: User;

  @Column({ type: 'boolean' })
  personalization: boolean;

  @Column({ type: 'enum', enum: PRICE_RANGE, name: 'priceRange' })
  price_range: PRICE_RANGE;
}

