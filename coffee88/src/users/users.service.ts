import {
  BadRequestException,
  Injectable,
  NotFoundException,
} from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Cafe } from '../cafes/entities/cafe.entity';
import { UserPreferenceDto } from './dto/user-preference.dto';
import { UserRepository } from './repositories/user.repository';
import { UserPreferenceRepository } from './repositories/user-preference.repository';

@Injectable()
export class UsersService {
  constructor(
    private readonly userRepository: UserRepository,
    private readonly userPreferenceRepository: UserPreferenceRepository,
    @InjectRepository(Cafe)
    private readonly cafeRepository: Repository<Cafe>,
  ) {}

  async createNewUserPreference(newUserPreferece: UserPreferenceDto) {
    const foundUser = await this.userRepository.findUserById(
      newUserPreferece.userId,
    );
    if (!foundUser) throw new NotFoundException('No user found!');

    const existingPreference =
      await this.userPreferenceRepository.findOneUserPreference(foundUser);

    if (existingPreference)
      throw new BadRequestException('User preference already exist');

    return await this.userPreferenceRepository.createUserPreference(
      newUserPreferece,
      foundUser,
    );
  }

  async updateUserPreference(updatedUserPreference: {
    userId: number;
    newUserPreference: UserPreferenceDto;
  }) {
    const foundUser = await this.userRepository.findUserById(
      updatedUserPreference.userId,
    );
    if (!foundUser) throw new NotFoundException('No user found!');

    const existingPreference =
      await this.userPreferenceRepository.findOneUserPreference(foundUser);

    if (!existingPreference)
      throw new BadRequestException('User preference not found!');

    return await this.userPreferenceRepository.updateUserPreference(
      updatedUserPreference.newUserPreference,
      existingPreference,
    );
  }

  async getUserRecommendCafes(userId: number) {
    // Get user and preferences
    const user = await this.userRepository.findUserById(userId);
    if (!user) throw new NotFoundException('User not found');
  
    const userPreference = await this.userPreferenceRepository.findOneUserPreference(user);
    if (!userPreference) throw new BadRequestException('User preference not found');
  
    // If personalization is off, return top rated cafes
    if (!userPreference.personalization) {
      return await this.cafeRepository
        .createQueryBuilder('cafe')
        .orderBy('cafe.google_rating', 'DESC')
        .take(5)
        .getMany();
    }
  
    // Get user's favorite cafes data
    const favoriteCafes = await this.cafeRepository
      .createQueryBuilder('cafe')
      .leftJoinAndSelect('cafe.drinks', 'drinks')
      .where('cafe.id IN (:...ids)', { ids: userPreference.favouriteCafes })
      .getMany();
  
    // Extract preferences from favorite cafes
    const favoriteStyles = favoriteCafes.map(cafe => cafe.style);
    const favoriteDrinkTypes = favoriteCafes
      .flatMap(cafe => cafe.drinks)
      .map(drink => drink.type);
  
    // Find similar cafes
    return await this.cafeRepository
      .createQueryBuilder('cafe')
      .leftJoinAndSelect('cafe.drinks', 'drinks')
      .where('cafe.price_range = :priceRange', { priceRange: userPreference.price_range })
      .andWhere('cafe.style IN (:...styles)', { styles: favoriteStyles })
      .andWhere('drinks.type IN (:...types)', { types: favoriteDrinkTypes })
      .andWhere('cafe.id NOT IN (:...excludeIds)', { excludeIds: userPreference.favouriteCafes })
      .orderBy('cafe.google_rating', 'DESC')
      .addOrderBy('cafe.distance_from_sun', 'ASC')
      .distinct()
      .take(5)
      .getMany();
  }

  async addFavouriteCafe(favouriteCafe: { userId: number; cafeId: number }) {
    const foundUser = await this.userRepository.findUserById(favouriteCafe.userId);
    if (!foundUser) throw new NotFoundException('No user found!');

    return await this.userPreferenceRepository.addFavouriteCafe(favouriteCafe, foundUser);
  }

  async removeFavouriteCafe(favouriteCafe: { userId: number; cafeId: number }) {
    const foundUser = await this.userRepository.findUserById(favouriteCafe.userId);
    if (!foundUser) throw new NotFoundException('No user found!');

    return await this.userPreferenceRepository.removeFavouriteCafe(favouriteCafe, foundUser);
  }

  async getFavouriteCafes(userId: number) {
    const foundUser = await this.userRepository.findUserById(userId);
    if (!foundUser) throw new NotFoundException('No user found!');

    return await this.userPreferenceRepository.getUserFavouriteCafes(foundUser);
  }


}
