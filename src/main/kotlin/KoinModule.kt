package com.example

import com.example.repository.UserRepository
import com.example.service.UserService
import com.zaxxer.hikari.HikariConfig
import com.zaxxer.hikari.HikariDataSource
import org.koin.dsl.module
import javax.sql.DataSource

object KoinModule {
    fun appModule() = module {
        single<DataSource> {
            val config = HikariConfig().apply {
                jdbcUrl = System.getenv("DB_URL") ?: "jdbc:postgresql://localhost:25432/jmane"
                username = System.getenv("DB_USER") ?: "jmane_user"
                password = System.getenv("DB_PASSWORD") ?: "secret"
                maximumPoolSize = 10
            }

            HikariDataSource(config)
        }

        single { UserService() }

        single { UserRepository() }
    }
}
