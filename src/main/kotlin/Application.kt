package com.example

import io.ktor.serialization.kotlinx.json.json
import io.ktor.server.application.*
import io.ktor.server.auth.Authentication
import io.ktor.server.auth.bearer
import io.ktor.server.engine.embeddedServer
import io.ktor.server.netty.Netty
import io.ktor.server.plugins.contentnegotiation.ContentNegotiation
import org.koin.core.context.startKoin

fun main(args: Array<String>) {
    io.ktor.server.netty.EngineMain.main(args)
}

fun Application.module() {
    startKoin { modules(KoinModule.appModule()) }

    embeddedServer(Netty, port = 8081, host = "0.0.0.0") {
        install(Authentication) {
            bearer("auth-bearer") {
                realm = "Access to the '/' path"
                authenticate { tokenCredential ->
                    println("tokenCredential: ${tokenCredential.token}")
                }
            }
        }

        install(ContentNegotiation) {
            json()
        }

        configureRouting()
    }.start(wait = true)
}
