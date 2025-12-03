package com.example

import com.example.auth.JwtConfig
import com.example.module.request.GetClassSessionRequest
import com.example.module.request.LoginRequest
import com.example.module.response.ClassSession
import com.example.module.response.GetClassSessionsResponse
import com.example.module.response.LoginResponse
import com.example.service.ClassSessionService
import com.example.service.IClassSessionService
import com.example.service.IUserService
import com.example.service.UserService
import io.ktor.http.HttpStatusCode
import io.ktor.server.application.*
import io.ktor.server.auth.authenticate
import io.ktor.server.auth.jwt.JWTPrincipal
import io.ktor.server.auth.principal
import io.ktor.server.request.receive
import io.ktor.server.response.*
import io.ktor.server.routing.*
import org.koin.java.KoinJavaComponent.inject

fun Application.configureRouting() {
    val userService by inject<IUserService>(UserService::class.java)
    val classSessionService by inject<IClassSessionService>(ClassSessionService::class.java)

    routing {
        get("/") {
            call.respondText("Hello World!")
        }

        post("auth/login") {
            val request = call.receive<LoginRequest>()

            val email = request.email
            val password = request.password

            if (email.isNullOrBlank() || password.isNullOrBlank()) return@post call.respond(HttpStatusCode.BadRequest, "email and password are required")
            val user = userService.authenticateUser(email, password) ?: return@post call.respond(HttpStatusCode.BadRequest, "user not found")

            call.respond(HttpStatusCode.OK, LoginResponse(JwtConfig.generateToken(user)))
        }

        authenticate("auth-jwt") {
            get("auth/me") {
                val principal = call.principal<JWTPrincipal>()
                val name = principal?.getClaim("name", String::class)
                val role = principal?.getClaim("role", String::class)

                if (name.isNullOrBlank() || role.isNullOrBlank()) return@get call.respond(HttpStatusCode.BadRequest, "user not found")

                call.respond(
                    mapOf(
                        "name" to name,
                        "role" to role
                    )
                )
            }

            get("classes/{date}") {
                val classSessions: MutableList<ClassSession> = mutableListOf()

                val principal = call.principal<JWTPrincipal>()
                val userId = principal?.subject ?: return@get call.respond(HttpStatusCode.Unauthorized, "Unauthorized")

                if (userId.toIntOrNull() == null) return@get call.respond(HttpStatusCode.BadRequest, "user not found")

                val date = call.parameters["date"]
                if (date.isNullOrBlank()) {
                    call.respond(HttpStatusCode.BadRequest, "date is required")
                    return@get
                }

                val result = classSessionService.getClassesForTodayByUserId(userId.toInt(), date)
                result.forEach { session ->
                    classSessions.add(
                        ClassSession(
                            id = session.id,
                            startDateTime = session.startDateTime,
                            endDateTime = session.endDateTime,
                            roomName = session.roomName,
                            gradeName = session.gradeName,
                            subjectName = session.subjectName,
                            countPresent = session.countPresent,
                            countAbsent = session.countAbsent,
                            countLate = session.countLate,
                            reportStatus = session.reportStatus
                        )
                    )
                }

                call.respond(HttpStatusCode.OK, GetClassSessionsResponse(classSessions))
            }
        }
    }
}
