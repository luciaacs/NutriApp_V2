package com.demo.nutri.repository;

import com.demo.nutri.model.Usuario;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UsuarioRepository extends JpaRepository<Usuario, Integer> {
    Usuario findByName(String name);
}
