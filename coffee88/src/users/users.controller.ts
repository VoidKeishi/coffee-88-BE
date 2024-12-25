import { Body, Controller, Post } from '@nestjs/common';
import { UsersService } from './users.service';
import { UserPreferenceDto } from './dto/user-preference.dto';

@Controller('users')
export class UsersController {
  constructor(private readonly usersService: UsersService) {}

  @Post('preference')
  async createNewUserPreference(@Body() newUserPreference: UserPreferenceDto) {
    return this.usersService.createNewUserPreference(newUserPreference);
  }

  @Post('preference/update')
  async updateUserPreference(@Body() updatedUserPreference: { userId: number; newUserPreference: UserPreferenceDto }) {
    return this.usersService.updateUserPreference(updatedUserPreference);
  }

  // Get user recommend cafes based on user preference
  @Post('preference/recommend')
  async getUserRecommendCafes(@Body() userId: { userId: number }) {
    return this.usersService.getUserRecommendCafes(userId.userId);
  }

  @Post('favourite/add')
  async addFavouriteCafe(@Body() favouriteCafe: { userId: number; cafeId: number }) {
    return this.usersService.addFavouriteCafe(favouriteCafe);
  }

  @Post('favourite/remove')
  async removeFavouriteCafe(@Body() favouriteCafe: { userId: number; cafeId: number }) {
    return this.usersService.removeFavouriteCafe(favouriteCafe);
  }

  @Post('favourite/list')
  async getFavouriteCafes(@Body() userId: { userId: number }) {
    return this.usersService.getFavouriteCafes(userId.userId);
  }


}
