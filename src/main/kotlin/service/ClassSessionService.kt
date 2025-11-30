package com.example.service

import com.example.db.ClassSession
import com.example.repository.ClassSessionRepository
import com.example.repository.IClassSessionRepository
import org.koin.java.KoinJavaComponent.inject

class ClassSessionService: IClassSessionService {
    private val classSessionRepository by inject<IClassSessionRepository>(ClassSessionRepository::class.java)

    override fun getClassesForTodayByUserId(userId: Int, date: String): List<ClassSession> {
        return classSessionRepository.getClassesForTodayByUserId(userId, date)
    }
}
