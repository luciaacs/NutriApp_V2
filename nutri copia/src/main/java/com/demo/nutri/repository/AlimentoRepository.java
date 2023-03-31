package com.demo.nutri.repository;

import com.demo.nutri.model.Alimento;

import org.springframework.data.repository.CrudRepository;

public interface AlimentoRepository extends CrudRepository<Alimento, Integer> {
    Alimento findByName(String name);
}
