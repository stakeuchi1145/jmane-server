package com.example.auth

import com.auth0.jwt.JWT
import com.auth0.jwt.algorithms.Algorithm
import com.example.db.Users
import java.util.Date

object JwtConfig {
    // 開発用の適当な秘密鍵（本番はもっと長く&環境変数で）
    private const val defaultSecretForDev = "local-dev-only-secret-change-me"
    val secret = System.getenv("JWT_SECRET") ?: defaultSecretForDev
    const val issuer = "com.example"
    const val audience = "com.example.audience"
    const val realm = "Access to teacher api"

    // 有効期限（ms）→ 1時間
    const val validityInMs = 60 * 60 * 1000L

    fun generateToken(user: Users): String {
        val now = System.currentTimeMillis()
        val expireAt = Date(now + validityInMs)

        return JWT.create()
            .withIssuer(issuer)
            .withAudience(audience)
            .withSubject(user.id.toString())        // sub にユーザーID
            .withClaim("name", user.name)          // 追加で欲しい情報
            .withClaim("role", user.role)
            .withExpiresAt(expireAt)
            .sign(Algorithm.HMAC256(secret))
    }
}