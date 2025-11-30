package com.example.service

import com.example.db.Users

interface IUserService {
    fun getUserByEmail(email: String): Users?
    fun authenticateUser(email: String, password: String): Users?
    fun getUserById(id: Int): Users?
}
