import { Controller, Get, Param } from '@nestjs/common';
import { CafesService } from './cafes.service';
import { CafeDto } from './dto/cafe.dto';

@Controller('cafes')
export class CafesController {
  constructor(private readonly cafesService: CafesService) {}

  @Get()
  findAll(): Promise<CafeDto[]> {
    return this.cafesService.findAll();
  }

  @Get('/recommends')
  findRecomenndCafes() {
    return this.cafesService.findRecomenndCafes();
  }

  @Get('/detail/:id')
  findOne(@Param('id') id: string): Promise<CafeDto> {
    return this.cafesService.findOne(+id);
  }
}