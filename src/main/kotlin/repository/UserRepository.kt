package com.example.repository

import com.example.db.Users
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext
import org.koin.java.KoinJavaComponent.inject
import javax.sql.DataSource

class UserRepository : IUserRepository {
    private val dataSource by inject<DataSource>(DataSource::class.java)

    override fun getUserByEmail(email: String): Users? {
            dataSource.connection.use { connection ->
                connection.prepareStatement("SELECT * FROM users WHERE email = ?").use { statement ->
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
        dataSource.connection.use { connection ->
            connection.prepareStatement("SELECT * FROM users WHERE id = ?").use { statement ->
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