import {
  BadRequestException,
  Injectable,
  InternalServerErrorException,
  NotFoundException,
  UnauthorizedException,
} from '@nestjs/common';
import { spawn } from 'child_process';
import { SignInDto } from './dto/signin.dto';
import { UserRepository } from 'src/users/repositories/user.repository';
import { SignUpDto } from './dto/siginup.dto';

@Injectable()
export class AuthService {
  constructor(private readonly userRepository: UserRepository) {}

  async signin(signInData: SignInDto) {
    const foundUser = await this.userRepository.findUserByEmail(
      signInData.email,
    );
    if (!foundUser) throw new NotFoundException('User not found!');

    if (foundUser.password !== signInData.password)
      throw new UnauthorizedException('Password is incorrect');

    return {
      username: foundUser.username,
      email: foundUser.email,
    };
  }

  async signup(signUpData: SignUpDto) {
    const foundUser = await this.userRepository.findUserByEmail(
      signUpData.email,
    );
    if (foundUser) throw new BadRequestException('User already exist!');

    const userWithSameUsername = await this.userRepository.findUserByUsername(
      signUpData.username,
    );
    if (userWithSameUsername)
      throw new BadRequestException(
        'User with the same username already exist!',
      );

    const newUser = await this.userRepository.createNewUser(signUpData);
    return {
      username: newUser.email,
      email: newUser.username,
    };
  }

  async forgotPassword(email: string) {
    const foundUser = await this.userRepository.findUserByEmail(email);
    if (!foundUser) throw new BadRequestException('Email is not exist!');

    const pythonProcess = spawn('python', ['script.py', email]);

    pythonProcess.stdout.on('data', (data) => {
      console.log(`stdout: ${data}`);
      return {
        success: true,
        message: 'An email has been sent to your mailbox. Check it out!',
      };
    });

    pythonProcess.stderr.on('data', (data) => {
      console.error(`stderr: ${data}`);
      throw new InternalServerErrorException('Oops! Something went wrong!');
    });

    pythonProcess.on('close', (code) => {
      console.log(`child process exited with code ${code}`);
    });
  }
}
