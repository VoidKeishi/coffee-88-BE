import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { UserPreferences } from '../entities/user.preference.entity';
import { User } from '../entities/user.entity';
import { Repository } from 'typeorm';
import { UserPreferenceDto } from '../dto/user-preference.dto';

@Injectable()
export class UserPreferenceRepository {
  constructor(
    @InjectRepository(UserPreferences)
    private readonly userPreferenceRepository: Repository<UserPreferences>,
  ) {}

  async createUserPreference(
    userPreferenceData: UserPreferenceDto,
    user: User,
  ) {
    const newUserPreference = new UserPreferences();
    newUserPreference.user = user;
    newUserPreference.personalization = userPreferenceData.personalization;
    newUserPreference.price_range = userPreferenceData.priceRange;
    const newUserPreferenceData =
      await this.userPreferenceRepository.save(newUserPreference);

    return newUserPreferenceData
  }

  async findOneUserPreference(user: User): Promise<UserPreferences | null> {
    return await this.userPreferenceRepository.findOne({
      where: { user: { id: user.id } },
    });
  }
}
