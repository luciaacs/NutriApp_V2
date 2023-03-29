import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BuscadorComida extends StatefulWidget {
  @override
  _BuscadorComidaState createState() => _BuscadorComidaState();
}

class _BuscadorComidaState extends State<BuscadorComida> {
  String _query = '';
  List<String> _foodList = [];

  final random = Random();

  Color _getRandomPastelColor() {
    final random = Random();
    final hue = 20 + random.nextInt(40); // Rango de matiz entre 30 y 60 grados
    final saturation =
        0.5 + random.nextDouble() * 0.3; // Rango de saturación entre 0.4 y 0.6
    final lightness =
        0.7 + random.nextDouble() * 0.2; // Rango de luminosidad entre 0.7 y 0.9
    return HSLColor.fromAHSL(1.0, hue.toDouble(), saturation, lightness)
        .toColor();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buscador de comidas'),
      ),
      body: Column(
        children: [
          TextField(
            onChanged: (query) {
              setState(() {
                _query = query;
              });
              print(_query);
              searchAndDisplayFood(_query);
            },
            decoration: InputDecoration(
              hintText: 'Introduce el nombre de la comida',
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _foodList.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Card(
                        color: _getRandomPastelColor(),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          title: Text(
                            _foodList[index],
                            style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w300, // Agregamos negrita
                              fontSize: 24, // Ajustamos el tamaño
                              fontFamily: 'Monserrat', // Cambiamos la fuente
                            ),
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () {
                              // Lógica para añadir el elemento
                            },
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 8),
                        child: ElevatedButton(
                          onPressed: () {
                            // Lógica para ver más detalles del elemento
                          },
                          child: Text('Ver'),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<http.Response> searchFood(String searchTerm) async {
    var url =
        'https://api.edamam.com/api/food-database/v2/parser?app_id=2c2e2462&app_key=7b3486401bec7d7ccd46c6bc6e85b3cc&ingr=$searchTerm';
    return await http.get(Uri.parse(url));
  }

  Future<void> searchAndDisplayFood(String searchTerm) async {
    var response = await searchFood(searchTerm);

    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      var foodList =
          body['hints'].map((food) => food['food']['label']).toList();
      setState(() {
        _foodList = foodList.cast<
            String>(); // Conversión de lista dinámica a lista de cadenas de texto
      });
      // Mostrar lista de alimentos en la interfaz de usuario
      // ...
    } else {
      print('Error al realizar la búsqueda');
    }
  }
}
