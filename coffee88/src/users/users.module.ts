import { Module } from '@nestjs/common';
import { UsersService } from './users.service';
import { UsersController } from './users.controller';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Cafe } from '../cafes/entities/cafe.entity';
import { User } from './entities/user.entity';
import { UserPreferences } from './entities/user.preference.entity';
import { UserRepository } from './repositories/user.repository';
import { UserPreferenceRepository } from './repositories/user-preference.repository';
import { CafesModule } from 'src/cafes/cafes.module';

@Module({
  imports: [
    TypeOrmModule.forFeature([User, UserPreferences, Cafe]),
    CafesModule,
  ],
  controllers: [UsersController],
  providers: [UsersService, UserRepository, UserPreferenceRepository],
  exports: [UserRepository],
})
export class UsersModule {}