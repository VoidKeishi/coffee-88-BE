import { Module } from '@nestjs/common';
import { UsersService } from './users.service';
import { UsersController } from './users.controller';
import { TypeOrmModule } from '@nestjs/typeorm';
import { User } from './entities/user.entity';
import { UserPreferences } from './entities/user.preference.entity';
import { UserRepository } from './repositories/user.repository';
import { UserPreferenceRepository } from './repositories/user-preference.repository';

@Module({
  imports: [TypeOrmModule.forFeature([User, UserPreferences])],
  controllers: [UsersController],
  providers: [UsersService, UserRepository, UserPreferenceRepository],
  exports: [UserRepository],
})
export class UsersModule {}
