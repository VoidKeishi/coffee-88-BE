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
}
