package com.example.bloodbank.repository

import com.example.bloodbank.model.Donor
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.stereotype.Repository

@Repository
interface DonorRepository : JpaRepository<Donor, Long> {
    fun findByCpfIn(cpfs: List<String>): List<Donor>
}
