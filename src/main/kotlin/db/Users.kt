package com.example.db

data class Users(
    val id: Int,
    val name: String,
    val email: String,
    val password: String,
    val imageUrl: String,
    val role: String
)
