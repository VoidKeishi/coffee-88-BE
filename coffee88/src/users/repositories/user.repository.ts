import { InjectRepository } from "@nestjs/typeorm";
import { User } from "../entities/user.entity";
import { Injectable } from "@nestjs/common";
import { Repository } from "typeorm";
import { NewUserDto } from "../dto/new-user.dto";

@Injectable()
export class UserRepository {
  constructor(
    @InjectRepository(User)
    private userRepository: Repository<User>,
  ) {}

  async findUserById(id: number): Promise<User | null> {
    return await this.userRepository.findOne({ where: { id: id } })
  }

  async findUserByEmail(email: string): Promise<User | null> {
    return await this.userRepository.findOne({ where: { email: email } })
  }

  async findUserByUsername(username: string): Promise<User | null> {
    return await this.userRepository.findOne({ where: { username: username } })
  }

  async createNewUser(newUserData: NewUserDto): Promise<User> {
    const newUser = this.userRepository.create(newUserData)
    return await this.userRepository.save(newUser)
  }

  async updateUserProfile(updatedUserData: { userId: number; newUserData: NewUserDto }): Promise<User> {
    const foundUser = await this.findUserById(updatedUserData.userId)
    if (!foundUser) return null
    const updatedUser = this.userRepository.create({ ...foundUser, ...updatedUserData.newUserData })
    return await this.userRepository.save(updatedUser)
  }

}