package com.example.module.response

import kotlinx.serialization.Serializable

@Serializable
data class GetClassSessionsResponse(
    val classSessions: List<ClassSession>
)

@Serializable
data class ClassSession(
    val id: Int,
    val startDateTime: String,
    val endDateTime: String,
    val roomName: String,
    val gradeName: String,
    val subjectName: String,
    val countPresent: Int,
    val countAbsent: Int,
    val countLate: Int,
    val reportStatus: String
)
