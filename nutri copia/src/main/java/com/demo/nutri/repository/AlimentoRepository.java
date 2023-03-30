package com.demo.nutri.repository;

import com.demo.nutri.model.Alimento;
import org.springframework.data.jpa.repository.JpaRepository;

public interface AlimentoRepository extends JpaRepository<Alimento, Integer> {
    Alimento findByName(String name);
}
