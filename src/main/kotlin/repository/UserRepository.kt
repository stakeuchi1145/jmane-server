package com.example.repository

import com.example.db.SqlLoader
import com.example.db.Users
import org.koin.java.KoinJavaComponent.inject
import javax.sql.DataSource

class UserRepository : IUserRepository {
    private val dataSource by inject<DataSource>(DataSource::class.java)

    override fun getUserByEmail(email: String): Users? {
        val sql = SqlLoader.load("user/find_by_email.sql")

        dataSource.connection.use { connection ->
            connection.prepareStatement(sql).use { statement ->
                statement.setString(1, email)
                statement.executeQuery().use { resultSet ->
                    if (resultSet.next()) {
                        return Users(
                            resultSet.getInt("id"),
                            resultSet.getString("name"),
                            resultSet.getString("email"),
                            resultSet.getString("password_hash"),
                            resultSet.getString("role")
                        )
                    }
                }
            }
        }

        return null
    }

    override fun getUserById(id: Int): Users? {
        val sql = SqlLoader.load("user/find_by_userid.sql")

        dataSource.connection.use { connection ->
            connection.prepareStatement(sql).use { statement ->
                statement.setInt(1, id)
                statement.executeQuery().use { resultSet ->
                    if (resultSet.next()) {
                        return Users(
                            resultSet.getInt("id"),
                            resultSet.getString("name"),
                            resultSet.getString("email"),
                            resultSet.getString("password_hash"),
                            resultSet.getString("role")
                        )
                    }
                }
            }
        }

        return null
    }
}