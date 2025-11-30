package com.example

import com.example.auth.JwtConfig
import com.example.module.request.LoginRequest
import com.example.module.response.LoginResponse
import com.example.service.IUserService
import com.example.service.UserService
import io.ktor.http.HttpStatusCode
import io.ktor.server.application.*
import io.ktor.server.auth.UserIdPrincipal
import io.ktor.server.auth.authenticate
import io.ktor.server.auth.jwt.JWTPrincipal
import io.ktor.server.auth.principal
import io.ktor.server.request.receive
import io.ktor.server.response.*
import io.ktor.server.routing.*
import org.koin.java.KoinJavaComponent.inject

fun Application.configureRouting() {
    val userService by inject<IUserService>(UserService::class.java)

    routing {
        get("/") {
            call.respondText("Hello World!")
        }

        post("/login") {
            val request = call.receive<LoginRequest>()

            request.email?.let { email ->
                request.password?.let { password ->
                    val user = userService.getUserByEmail(email, password) ?: run {
                        call.respond(HttpStatusCode.BadRequest, "user not found")
                        return@post
                    }

                    val token = JwtConfig.generateToken(user)
                    call.respond(HttpStatusCode.OK, LoginResponse(token))
                }
            }
        }

        authenticate("auth-jwt") {
            get("/me") {
                val principal = call.principal<JWTPrincipal>()
                val userId = principal!!.subject
                val name = principal.getClaim("name", String::class)

                call.respond(
                    mapOf(
                        "userId" to userId,
                        "name" to name
                    )
                )
            }
        }
    }
}
