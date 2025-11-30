package com.example.module.request

import kotlinx.serialization.Serializable

@Serializable
data class GetClassSessionRequest(
    val date: String?
)
