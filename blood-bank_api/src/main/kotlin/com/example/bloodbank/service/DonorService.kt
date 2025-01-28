package com.example.bloodbank.service

import com.example.bloodbank.model.Donor
import com.example.bloodbank.repository.DonorRepository
import java.time.LocalDate
import java.time.Period
import java.time.format.DateTimeFormatter
import org.springframework.stereotype.Service

@Service
class DonorService(private val repository: DonorRepository) {

    fun getExistingDonors(donors: List<Donor>): List<Donor> {
        val existingCpfs = donors.map { it.cpf }
        return repository.findByCpfIn(existingCpfs)
    }

    fun saveDonors(donors: List<Donor>) {
        val existingDonors = getExistingDonors(donors)
        val existingCpfs = existingDonors.map { it.cpf }.toSet()

        val newDonors = donors.filter { it.cpf !in existingCpfs }

        if (newDonors.isNotEmpty()) {
            repository.saveAll(newDonors)
        }
    }

    fun getAllDonors(): List<Donor> = repository.findAll()

    fun countDonorsByState(): Map<String, Long> {
        return repository.findAll().groupingBy { it.estado }.eachCount().mapValues {
            it.value.toLong()
        }
    }

    fun averageImcByAgeGroup(): Map<String, Double> {
        return repository
                .findAll()
                .groupBy { donor ->
                    val idade = calculateAge(donor.dataNasc)
                    when (idade) {
                        in 0..10 -> "0-10"
                        in 11..20 -> "11-20"
                        in 21..30 -> "21-30"
                        in 31..40 -> "31-40"
                        in 41..50 -> "41-50"
                        in 51..60 -> "51-60"
                        in 61..70 -> "61-70"
                        else -> "70+"
                    }
                }
                .mapValues { (_, donors) ->
                    donors
                            .filter { it.altura > 0 }
                            .map { it.peso / (it.altura * it.altura) }
                            .average()
                }
                .filterValues { it > 0 }
    }

    fun obesityPercentage(): Map<String, Double> {
        val donors = repository.findAll()
        val totalMale = donors.count { it.sexo == "Masculino" }
        val totalFemale = donors.count { it.sexo == "Feminino" }

        val obeseMale =
                donors.count { it.sexo == "Masculino" && it.peso / (it.altura * it.altura) > 30 }
        val obeseFemale =
                donors.count { it.sexo == "Feminino" && it.peso / (it.altura * it.altura) > 30 }

        return mapOf(
                "Masculino" to if (totalMale > 0) (obeseMale.toDouble() / totalMale) * 100 else 0.0,
                "Feminino" to
                        if (totalFemale > 0) (obeseFemale.toDouble() / totalFemale) * 100 else 0.0
        )
    }

    fun averageAgeByBloodType(): Map<String, Double> {
        return repository.findAll().groupBy { it.tipoSanguineo }.mapValues { (_, donors) ->
            donors.map { calculateAge(it.dataNasc) }.average()
        }
    }

    fun possibleDonorsByBloodType(): Map<String, List<Donor>> {
        val bloodCompatibility =
                mapOf(
                        "A+" to listOf("A+", "AB+"),
                        "A-" to listOf("A+", "A-", "AB+", "AB-"),
                        "B+" to listOf("B+", "AB+"),
                        "B-" to listOf("B+", "B-", "AB+", "AB-"),
                        "AB+" to listOf("AB+"),
                        "AB-" to listOf("AB+", "AB-"),
                        "O+" to listOf("A+", "B+", "O+", "AB+"),
                        "O-" to listOf("A+", "A-", "B+", "B-", "O+", "O-", "AB+", "AB-")
                )

        return bloodCompatibility.mapValues { (recipients) ->
            repository.findAll().filter { recipients.contains(it.tipoSanguineo) }.filter { donor ->
                val idade = calculateAge(donor.dataNasc)
                idade in 16..69 && donor.peso > 50
            }
        }
    }

    fun calculateAge(dateOfBirth: String): Int {
        return try {
            val formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy")
            val birthDate = LocalDate.parse(dateOfBirth, formatter)
            Period.between(birthDate, LocalDate.now()).years
        } catch (e: Exception) {
            0
        }
    }
}
