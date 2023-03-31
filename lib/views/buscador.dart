import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/views/mostrarFood.dart';

class BuscadorComida extends StatefulWidget {
  @override
  _BuscadorComidaState createState() => _BuscadorComidaState();
}

class _BuscadorComidaState extends State<BuscadorComida> {
  String _query = '';
  List<String> _foodList = [];
  List<Map<String, dynamic>> _foods = [];


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
                                  insertarAlimento(
                                  _foods[index]['label'],
                                  _foods[index]['nutrients']['ENERC_KCAL'],
                                  100, // 100 gramos de comida
                                  _foods[index]['nutrients']['CHOCDF'],
                                  _foods[index]['nutrients']['FAT'],
                                  _foods[index]['nutrients']['PROCNT'],
                                  _foods[index]['image'] ?? ""

                                );
                              // Lógica para añadir el elemento
                              // insertarAlimento(String _foods.label , double calorias, double cantidad, double carbohidratos, double grasas, double proteinas);
                            },
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 8),
                        child: ElevatedButton(
                          onPressed: () {
                            print(_foods[index]['nutrients']['ENERC_KCAL'].runtimeType);
                            print(_foods[index]['nutrients']['ENERC_KCAL']);

                            // Lógica para ver más detalles del elemento
                          Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MostrarFood(
                                    name:  _foods[index]['label'],
                                    cantidad: 100,
                                    calorias : _foods[index]['nutrients']['ENERC_KCAL'],
                                    grasas : _foods[index]['nutrients']['FAT'] ,                                 
                                    proteinas : _foods[index]['nutrients']['PROCNT'],                             
                                    carbohidratos : _foods[index]['nutrients']['CHOCDF']             
                                  )));
                           },
                          child: const Text('Ver'),
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
    var foodList = body['hints'].map((food) => food['food']['label']).toList();
    var foods = body['hints'].map((food) => food['food']).toList().cast<Map<String, dynamic>>();

    setState(() {
      _foodList = foodList.cast<String>(); // Convert foodList to List<String>
      _foods = foods;
      print(_foods[0]);
    });
    // Show food list in UI
    // ...
  } else {
    print('Error al realizar la búsqueda');
  }
}

}

Future<http.Response> insertarAlimento(String name, double calorias, double cantidad, double carbohidratos, double grasas, double proteinas, String image) async {
  final response = await http.post(
    Uri.parse('http://localhost:8080/foods/add'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'name': name,
      'calorias': calorias,
      'cantidad': cantidad,
      'carbohidratos': carbohidratos,
      'grasas': grasas,
      'proteinas': proteinas,
      'image' : image
    }),
  );
  return response;
}
