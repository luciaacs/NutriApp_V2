package com.demo.nutri.controller;

import java.net.URI;
import java.net.URISyntaxException;
import java.util.List;
import java.util.Optional;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.demo.nutri.model.Usuario;
import com.demo.nutri.repository.UsuarioRepository;

@RestController
@RequestMapping("/users")

public class UsuarioController {
    private final UsuarioRepository repository;

    public UsuarioController(UsuarioRepository UsuarioRepository) {
        this.repository = UsuarioRepository;
    }

    @GetMapping
    public List<Usuario> getUsuarios() {
        return (List<Usuario>) repository.findAll();
    }

    @PostMapping
    public ResponseEntity<Usuario> createUsuario(@RequestBody Usuario Usuario) throws URISyntaxException {
        Usuario savedUsuario = repository.save(Usuario);
        return ResponseEntity.created(new URI( savedUsuario.getEmail())).body(savedUsuario);
    }

    @GetMapping("/{id}")
    public ResponseEntity<Usuario>  getUsuario(@PathVariable Integer id) {
        return repository.findById(id).map(
                usuario -> ResponseEntity.ok().body(usuario)).orElse(new ResponseEntity<Usuario>(HttpStatus.NOT_FOUND));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Usuario>  deleteUsuario(@PathVariable Integer id) {
        repository.deleteById(id);
        return ResponseEntity.ok().build();
    }

    @PutMapping("/{id}")
    public ResponseEntity<Usuario>  updateUsuario(@PathVariable Integer id, @RequestBody Usuario Usuario) {
        return repository.findById(id).map(usuario -> {
            usuario.setName(Usuario.getName());
            usuario.setEmail(Usuario.getEmail());
            repository.save(usuario);
            return ResponseEntity.ok().body(usuario);
        }).orElse(new ResponseEntity<Usuario>(HttpStatus.NOT_FOUND));
    }


    // @PostMapping("/{id}/incrementa")
    // ResponseEntity<Usuario> incrementa(@PathVariable Integer id) {
    //     return repository.findById(id).map(
    //             usuario -> {
    //                 usuario.setStatus(usuario.getStatus() + 1);
    //                 repository.save(usuario);
    //                 return ResponseEntity.ok().body(usuario);
    //             }).orElse(new ResponseEntity<Usuario>(HttpStatus.NOT_FOUND));

    // }
}
