import { Controller, Post, Body } from '@nestjs/common';
import { AuthService } from './auth.service';
import { SignInDto } from './dto/signin.dto';
import { SignUpDto } from './dto/siginup.dto';

@Controller('auth')
export class AuthController {
  constructor(private readonly authService: AuthService) {}

  @Post('sign-in')
  async signin(@Body() signInData: SignInDto) {
    return await this.authService.signin(signInData);
  }

  @Post('sign-up')
  async signup(@Body() signUpData: SignUpDto) {
    return await this.authService.signup(signUpData);
  }

  @Post('forgot-password')
  async forgotPassword(@Body() email: string) {
    return await this.authService.forgotPassword(email);
  }
}
