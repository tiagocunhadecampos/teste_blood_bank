package com.example.bloodbank.model

import com.fasterxml.jackson.annotation.JsonProperty
import jakarta.persistence.Entity
import jakarta.persistence.GeneratedValue
import jakarta.persistence.GenerationType
import jakarta.persistence.Id

@Entity
data class Donor(
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    val id: Long = 0,

    @JsonProperty("nome")
    val nome: String,

    @JsonProperty("cpf")
    val cpf: String,

    @JsonProperty("rg")
    val rg: String,

    @JsonProperty("data_nasc")
    val dataNasc: String,

    @JsonProperty("sexo")
    val sexo: String,

    @JsonProperty("mae")
    val mae: String,

    @JsonProperty("pai")
    val pai: String,

    @JsonProperty("email")
    val email: String,

    @JsonProperty("cep")
    val cep: String,

    @JsonProperty("endereco")
    val endereco: String,

    @JsonProperty("numero")
    val numero: Int,

    @JsonProperty("bairro")
    val bairro: String,

    @JsonProperty("cidade")
    val cidade: String,

    @JsonProperty("estado")
    val estado: String,

    @JsonProperty("telefone_fixo")
    val telefoneFixo: String? = null,

    @JsonProperty("celular")
    val celular: String,

    @JsonProperty("altura")
    val altura: Double,

    @JsonProperty("peso")
    val peso: Double,

    @JsonProperty("tipo_sanguineo")
    val tipoSanguineo: String
)
