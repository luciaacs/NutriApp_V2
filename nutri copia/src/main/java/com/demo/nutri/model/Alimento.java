package com.demo.nutri.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;

@Entity
public class Alimento {
    @Id
    @GeneratedValue
    private Integer id;
    private String name;
    private Double cantidad;
    private Double calorias;
    private Double grasas;
    private Double proteinas;
    private Double carbohidratos;

    public Integer getId() {
        return id;
    }
    public void setId(Integer id) {
        this.id = id;
    }
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }
    public Double getCantidad() {
        return cantidad;
    }
    public void setCantidad(Double cantidad) {
        this.cantidad = cantidad;
    }
    public Double getCalorias() {
        return calorias;
    }
    public void setCalorias(Double calorias) {
        this.calorias = calorias;
    }
    public Double getGrasas() {
        return grasas;
    }
    public void setGrasas(Double grasas) {
        this.grasas = grasas;
    }
    public Double getProteinas() {
        return proteinas;
    }
    public void setProteinas(Double proteinas) {
        this.proteinas = proteinas;
    }
    public Double getCarbohidratos() {
        return carbohidratos;
    }
    public void setCarbohidratos(Double carbohidratos) {
        this.carbohidratos = carbohidratos;
    }

}




 
