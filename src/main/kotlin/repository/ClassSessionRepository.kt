package com.example.repository

import com.example.db.ClassSession
import com.example.db.SqlLoader
import org.koin.java.KoinJavaComponent.inject
import java.sql.Date
import javax.sql.DataSource

class ClassSessionRepository : IClassSessionRepository {
    private val dataSource by inject<DataSource>(DataSource::class.java)

    override fun getClassesForTodayByUserId(userId: Int, date: String): List<ClassSession> {
        val classSessions = mutableListOf<ClassSession>()
        val sql = SqlLoader.load("class_sessions/find_by_teacher_and_date.sql")

        dataSource.connection.use { connection ->
            connection.prepareStatement(sql).use { statement ->
                statement.setInt(1, userId)
                statement.setString(2, Date.valueOf(date).toString())
                statement.executeQuery().use { resultSet ->
                    while (resultSet.next()) {
                        classSessions.add(
                            ClassSession(
                                resultSet.getInt("class_session_id"),
                                resultSet.getString("start_time"),
                                endDateTime = resultSet.getString("end_time"),
                                roomName = resultSet.getString("room_name"),
                                gradeName = resultSet.getString("grade_group"),
                                subjectName = resultSet.getString("subject"),
                                countPresent = resultSet.getInt("present_count"),
                                countAbsent = resultSet.getInt("absent_count"),
                                countLate = resultSet.getInt("late_count"),
                                reportStatus = resultSet.getString("report_status"),
                            )
                        )
                    }
                }
            }
        }

        return classSessions
    }
}