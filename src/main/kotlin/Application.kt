package com.example

import com.auth0.jwt.JWT
import com.auth0.jwt.algorithms.Algorithm
import com.example.auth.JwtConfig
import com.example.service.IUserService
import com.example.service.UserService
import io.ktor.serialization.kotlinx.json.json
import io.ktor.server.application.*
import io.ktor.server.auth.Authentication
import io.ktor.server.auth.jwt.JWTPrincipal
import io.ktor.server.auth.jwt.jwt
import io.ktor.server.engine.embeddedServer
import io.ktor.server.netty.Netty
import io.ktor.server.plugins.contentnegotiation.ContentNegotiation
import org.koin.core.context.startKoin
import org.koin.java.KoinJavaComponent.inject

fun main(args: Array<String>) {
    io.ktor.server.netty.EngineMain.main(args)
}

fun Application.module() {
    val userService by inject<IUserService>(UserService::class.java)

    startKoin { modules(KoinModule.appModule()) }

    embeddedServer(Netty, port = 8081, host = "0.0.0.0") {
        install(Authentication) {
            jwt("auth-jwt") {
                realm = JwtConfig.realm
                verifier(
                    JWT.require(Algorithm.HMAC256(JwtConfig.secret))
                        .withIssuer(JwtConfig.issuer)
                        .withAudience(JwtConfig.audience)
                        .build()
                )

                validate { credential ->
                    val userId = credential.payload.subject?.toIntOrNull()
                    if (userId != null) {
                        if (userService.getUserById(userId) == null) {
                            return@validate null
                        }

                        JWTPrincipal(credential.payload)
                    } else {
                        null
                    }
                }
            }
        }

        install(ContentNegotiation) {
            json()
        }

        configureRouting()
    }.start(wait = true)
}
