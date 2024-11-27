import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Cafe } from './entities/cafe.entity';

@Injectable()
export class CafesService {
  constructor(
    @InjectRepository(Cafe)
    private cafesRepository: Repository<Cafe>,
  ) {}

  findAll(): Promise<Cafe[]> {
    return this.cafesRepository.find();
  }

  findOne(id: number): Promise<Cafe> {
    return this.cafesRepository.findOneBy({ id });
  }
}