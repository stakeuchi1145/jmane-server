package com.example.repository

import com.example.db.ClassSession

interface IClassSessionRepository {
    fun getClassesForTodayByUserId(userId: Int, date: String): List<ClassSession>
}
