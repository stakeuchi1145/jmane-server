package com.example

import com.zaxxer.hikari.HikariConfig
import com.zaxxer.hikari.HikariDataSource
import org.koin.dsl.module
import javax.sql.DataSource

object KoinModule {
    fun appModule() = module {
        single<DataSource> {
            val config = HikariConfig().apply {  }
            HikariDataSource(config)
        }
    }
}