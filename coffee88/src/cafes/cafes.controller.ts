import { Controller, Get, Post, Body, Patch, Param, Delete } from '@nestjs/common';
import { CafesService } from './cafes.service';

@Controller('cafes')
export class CafesController {
  constructor(private readonly cafesService: CafesService) {}


  @Get()
  findAll() {
    return this.cafesService.findAll();
  }

  @Get('/detail/:id')
  findOne(@Param('id') id: string) {
    return this.cafesService.findOne(+id);
  }


}
