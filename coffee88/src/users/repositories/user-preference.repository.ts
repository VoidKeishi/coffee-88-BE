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

  async updateUserPreference(
    updatedUserPreference: UserPreferenceDto,
    existingPreference: UserPreferences,
  ) {
    existingPreference.personalization = updatedUserPreference.personalization;
    existingPreference.price_range = updatedUserPreference.priceRange;
    return await this.userPreferenceRepository.save(existingPreference);
  }

  async getUserFavouriteCafes(user: User) {
    const userPreference = await this.userPreferenceRepository.findOne({
      where: { user: { id: user.id } },
    });
    return userPreference.favouriteCafes;
  }

  async addFavouriteCafe(
    favouriteCafe: { userId: number; cafeId: number },
    foundUser: User
  ): Promise<UserPreferences> {
    const userPreference = await this.findOneUserPreference(foundUser);
    if (!userPreference.favouriteCafes.includes(favouriteCafe.cafeId)) {
      userPreference.favouriteCafes.push(favouriteCafe.cafeId);
    }
    return await this.userPreferenceRepository.save(userPreference);
  }
  
  async removeFavouriteCafe(
    favouriteCafe: { userId: number; cafeId: number },
    foundUser: User
  ): Promise<UserPreferences> {
    const userPreference = await this.findOneUserPreference(foundUser);
    userPreference.favouriteCafes = userPreference.favouriteCafes.filter(
      cafeId => cafeId !== favouriteCafe.cafeId
    );
    return await this.userPreferenceRepository.save(userPreference);
  }
  
}
