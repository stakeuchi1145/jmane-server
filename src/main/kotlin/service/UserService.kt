package com.example.service

import at.favre.lib.crypto.bcrypt.BCrypt
import com.example.db.Users
import com.example.repository.IUserRepository
import com.example.repository.UserRepository
import org.koin.java.KoinJavaComponent.inject

class UserService: IUserService {
    private val userRepository by inject<IUserRepository>(UserRepository::class.java)

    override fun getUserByEmail(email: String, password: String): Users? {
        userRepository.getUserByEmail(email)?.let { user ->
            if (!verify(password, user.password)) return null
            return user
        }

        return null
    }

    override fun getUserById(id: Int): Users? {
        return userRepository.getUserById(id)
    }

    private fun verify(rawPassword: String, hashedPassword: String): Boolean {
        val result = BCrypt.verifyer()
            .verify(rawPassword.toCharArray(), hashedPassword)

        return result.verified
    }
}
