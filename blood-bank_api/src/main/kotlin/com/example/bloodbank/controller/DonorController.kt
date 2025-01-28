package com.example.bloodbank.controller

import com.example.bloodbank.model.Donor
import com.example.bloodbank.service.DonorService
import com.fasterxml.jackson.module.kotlin.jacksonObjectMapper
import com.fasterxml.jackson.module.kotlin.readValue
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*

@RestController
@RequestMapping("/api/donors")
class DonorController(private val service: DonorService) {

    @GetMapping("/has-data")
    fun hasData(): ResponseEntity<Boolean> {
        val hasData = service.getAllDonors().isNotEmpty()
        return ResponseEntity.ok(hasData)
    }

    @PostMapping
    fun saveDonors(@RequestBody json: String): ResponseEntity<String> {
        return try {
            val mapper = jacksonObjectMapper()
            val donors: List<Donor> = mapper.readValue(json)

            val existingDonors = service.getExistingDonors(donors)
            val existingCpfs = existingDonors.map { it.cpf }.toSet()

            val newDonors = donors.filter { it.cpf !in existingCpfs }
            val alreadyRegistered = donors.filter { it.cpf in existingCpfs }

            if (newDonors.isNotEmpty()) {
                service.saveDonors(newDonors)
            }

            val responseMessage = buildString {
                append("${newDonors.size} new donors saved.")
                if (alreadyRegistered.isNotEmpty()) {
                    append(" ${alreadyRegistered.size} donors were already registered.")
                }
            }

            ResponseEntity.ok(responseMessage)
        } catch (e: Exception) {
            ResponseEntity.badRequest().body("Erro ao processar JSON: ${e.message}")
        }
    }

    @GetMapping fun getAllDonors(): List<Donor> = service.getAllDonors()

    @GetMapping("/count-by-state")
    fun countDonorsByState(): Map<String, Long> {
        return service.countDonorsByState()
    }

    @GetMapping("/average-imc-by-age")
    fun averageImcByAgeGroup(): Map<String, Double> {
        return service.averageImcByAgeGroup()
    }

    @GetMapping("/obesity-percentage")
    fun obesityPercentage(): Map<String, Double> {
        return service.obesityPercentage()
    }

    @GetMapping("/average-age-by-blood-type")
    fun averageAgeByBloodType(): Map<String, Double> {
        return service.averageAgeByBloodType()
    }

    @GetMapping("/possible-donors-by-blood-type")
    fun possibleDonorsByBloodType(): ResponseEntity<Map<String, List<Donor>>> {
        val donors = service.possibleDonorsByBloodType()
        return if (donors.isNotEmpty()) ResponseEntity.ok(donors)
        else ResponseEntity.noContent().build()
    }
}
