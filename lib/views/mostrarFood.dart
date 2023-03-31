import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MostrarFood extends StatelessWidget {
  final String name;
  final double cantidad;
  final double calorias;
  final double grasas;
  final double proteinas;
  final double carbohidratos;

  const MostrarFood({
    required this.name,
    required this.cantidad,
    required this.calorias,
    required this.grasas,
    required this.proteinas,
    required this.carbohidratos,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(name),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 8.0,
            margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(color: Colors.orangeAccent),
                  child: ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    title: Text(
                      name,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0,
                      ),
                    ),
                    trailing: Icon(
                      Icons.remove_circle_outline,
                      color: Colors.white,
                    ),
                  ),
                ),
                ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  title: Text(
                    'Cantidad: $cantidad',
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ),
                ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  title: Text(
                    'Calorías: $calorias | Grasas: $grasas | Proteínas: $proteinas | Carbohidratos: $carbohidratos',
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
