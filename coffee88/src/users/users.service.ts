import {
  BadRequestException,
  Injectable,
  NotFoundException,
} from '@nestjs/common';
import { UserPreferenceDto } from './dto/user-preference.dto';
import { UserRepository } from './repositories/user.repository';
import { UserPreferenceRepository } from './repositories/user-preference.entity';

@Injectable()
export class UsersService {
  constructor(
    private readonly userRepository: UserRepository,
    private readonly userPreferenceRepository: UserPreferenceRepository,
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
}
