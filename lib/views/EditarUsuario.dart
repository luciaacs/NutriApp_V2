import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_app/controllers/databasehelpers.dart';
import 'package:my_app/model/Usuario.dart';
import 'package:my_app/views/listviewfood.dart';
import 'package:http/http.dart' as http;

class EditarUsuarioPage extends StatefulWidget {
  final String nombreUsuario;
  final String nombre;

  EditarUsuarioPage({
    required this.nombreUsuario,
    required this.nombre,
  });

  @override
  _EditarUsuarioPageState createState() => _EditarUsuarioPageState();
}

class _EditarUsuarioPageState extends State<EditarUsuarioPage> {
  late Future<Usuario> _futureUsuario;

  DataBaseHelper dataBaseHelper = DataBaseHelper();
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController nombreUsuarioController = TextEditingController();
  final TextEditingController EdadController = TextEditingController();
  final TextEditingController PesoController = TextEditingController();
  final TextEditingController AlturaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _futureUsuario = getUsuarioById(widget.nombreUsuario);
  }

  Future<Usuario> getUsuarioById(String nombreUsuario) async {
    final response =
        await http.get(Uri.parse('http://localhost:8080/users/$nombreUsuario'));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return Usuario.fromJson(jsonData);
    } else {
      throw Exception('Error al cargar el usuario');
    }
  }

  @override
  Widget build(BuildContext context) {
    var _generoSeleccionado;
    var _nivelActividadSeleccionado;
    List<Map<String, dynamic>> _alergias = [
      {'titulo': 'Polen', 'valor': false},
      {'titulo': 'Lactosa', 'valor': false},
      {'titulo': 'Mariscos', 'valor': false},
      {'titulo': 'Nueces', 'valor': false},
    ];
    List<CheckboxListTile> _crearAlergias() {
      List<CheckboxListTile> alergias = [];

      for (int i = 0; i < _alergias.length; i++) {
        alergias.add(
          CheckboxListTile(
            title: Text(_alergias[i]['titulo']),
            value: _alergias[i]['valor'],
            onChanged: (bool? newValue) {
              setState(() {
                _alergias[i]['valor'] = newValue ?? false;
              });
            },
          ),
        );
      }

      return alergias;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Usuario'),
      ),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: FutureBuilder<Usuario>(
          future: _futureUsuario,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error al cargar el usuario'),
              );
            } else {
              final usuario = snapshot.data!;
              nombreUsuarioController.text = usuario.nombreUsuario;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Nombre de usuario',
                    style: TextStyle(
                      fontSize: 10.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    usuario.nombreUsuario,
                    style: TextStyle(
                      fontSize: 10.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    'Nombre',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  TextField(
                    controller: nombreController,
                    decoration: InputDecoration(
                      hintText: 'Ingresa tu nombre',
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  TextField(
                    controller: EdadController,
                    decoration: InputDecoration(
                      labelText: 'Edad',
                      icon: Icon(Icons.cake),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  TextField(
                    controller: AlturaController,
                    decoration: InputDecoration(
                      labelText: 'Altura',
                      hintText: 'Altura en cm',
                      icon: Icon(Icons.height),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  TextField(
                    controller: PesoController,
                    decoration: InputDecoration(
                      labelText: 'Peso',
                      hintText: 'Peso en kg',
                      icon: Icon(Icons.fitness_center),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  DropdownButtonFormField(
                    decoration: InputDecoration(
                      labelText: 'Género',
                      icon: Icon(Icons.wc),
                    ),
                    value: _generoSeleccionado,
                    onChanged: (value) {
                      setState(() {
                        _generoSeleccionado = value;
                      });
                    },
                    items: [
                      DropdownMenuItem(
                        value: 'hombre',
                        child: Text('Hombre'),
                      ),
                      DropdownMenuItem(
                        value: 'mujer',
                        child: Text('Mujer'),
                      ),
                    ],
                  ),
                  DropdownButtonFormField(
                    decoration: InputDecoration(
                      labelText: 'Nivel de actividad física',
                      icon: Icon(Icons.directions_run),
                    ),
                    value: _nivelActividadSeleccionado,
                    onChanged: (value) {
                      setState(() {
                        _nivelActividadSeleccionado = value;
                      });
                    },
                    items: [
                      DropdownMenuItem(
                        value: 'nada activo',
                        child: Text('Nada activo'),
                      ),
                      DropdownMenuItem(
                        value: 'poco activo',
                        child: Text('Poco activo'),
                      ),
                      DropdownMenuItem(
                        value: 'activo',
                        child: Text('Activo'),
                      ),
                      DropdownMenuItem(
                        value: 'muy activo',
                        child: Text('Muy activo'),
                      ),
                    ],
                  ),
                  // CheckboxListTile para seleccionar alergias
                  Text(
                    'Alergias:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 10.0,
                    ),
                  ),

                  SizedBox(height: 8.0),

                  Column(
                    children: _crearAlergias(),
                  ),

                  ElevatedButton(
                    onPressed: () {
                      dataBaseHelper.updateUsuario(
                        nombreController.text.trim(),
                        usuario.nombreUsuario,
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ListAlimentos(
                            nombreUsuario: usuario.nombreUsuario,
                          ),
                        ),
                      );
                    },
                    child: Text('Guardar cambios'),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
