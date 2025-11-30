package com.example.repository

import com.example.db.Users

interface IUserRepository {
    fun getUserByEmail(email: String): Users?
    fun getUserById(id: Int): Users?
}
