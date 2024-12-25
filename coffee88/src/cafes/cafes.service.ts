import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Cafe } from './entities/cafe.entity';
import { CafeDto } from './dto/cafe.dto';

@Injectable()
export class CafesService {
  constructor(
    @InjectRepository(Cafe)
    private cafesRepository: Repository<Cafe>,
  ) {}

  async findAll(): Promise<CafeDto[]> {
    const cafes = await this.cafesRepository.find();
    return cafes.map((cafe) => this.toDto(cafe));
  }

  async findOne(id: number): Promise<CafeDto> {
    const cafe = await this.cafesRepository.findOne({
      where: { id },
      relations: ['drinks'],
    });
    return this.toDto(cafe);
  }

  async findRecomenndCafes(): Promise<CafeDto[]> {
    const recommendCafes = this.cafesRepository
      .createQueryBuilder()
      .from(Cafe, 'cafe')
      .addOrderBy('cafe.google_rating', 'DESC')
      .limit(4)
      .execute();
    return recommendCafes;
  }

  private toDto(cafe: Cafe): CafeDto {
    const { created_at, updated_at, ...dto } = cafe;
    return dto as CafeDto;
  }

  
}
