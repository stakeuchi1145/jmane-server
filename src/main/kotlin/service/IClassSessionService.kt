package com.example.service

import com.example.db.ClassSession

interface IClassSessionService {
    fun getClassesForTodayByUserId(userId: Int, date: String): List<ClassSession>
}
