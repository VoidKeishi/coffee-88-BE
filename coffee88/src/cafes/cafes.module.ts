import { Module } from '@nestjs/common';
import { CafesService } from './cafes.service';
import { CafesController } from './cafes.controller';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Cafe } from './entities/cafe.entity';
import { Drink } from './entities/drink.entity';

@Module({
  controllers: [CafesController],
  providers: [CafesService],
  imports: [TypeOrmModule.forFeature([
    Cafe,
    Drink
  ])],
})
export class CafesModule {}
