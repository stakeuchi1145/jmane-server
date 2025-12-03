package com.example.service

import at.favre.lib.crypto.bcrypt.BCrypt
import com.example.db.Users
import com.example.repository.IUserRepository
import com.example.repository.UserRepository
import org.koin.java.KoinJavaComponent.inject

class UserService: IUserService {
    private val userRepository by inject<IUserRepository>(UserRepository::class.java)

    override fun getUserByEmail(email: String): Users? {
        return userRepository.getUserByEmail(email)
    }

    override fun authenticateUser(email: String, password: String): Users? {
        val user = userRepository.getUserByEmail(email) ?: return null
        return if (verify(password, user.password)) user else null
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
