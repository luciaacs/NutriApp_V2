import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_app/controllers/databasehelpers.dart';
import 'package:my_app/views/CrearUsuario.dart';
import 'package:my_app/views/listviewfood.dart';
import 'package:http/http.dart' as http;

import '../model/Usuario.dart';

class IniciarSesionPage extends StatefulWidget {
  @override
  _IniciarSesionPageState createState() => _IniciarSesionPageState();
}

class _IniciarSesionPageState extends State<IniciarSesionPage> {
  DataBaseHelper dataBaseHelper = DataBaseHelper();

  final TextEditingController nombreController = TextEditingController();
  final TextEditingController nombreUsuarioController = TextEditingController();

  Future<Usuario?> getUsuario(String nombreUsuario) async {
    final response =
        await http.get(Uri.parse('http://localhost:8080/users/$nombreUsuario'));

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return Usuario.fromJson(json);
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Iniciar Sesión'),
        automaticallyImplyLeading:
            false, // esto evita que aparezca el botón de volver
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: nombreController,
              decoration: InputDecoration(
                labelText: 'Nombre',
                hintText: 'Nombre completo',
                icon: Icon(Icons.person),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: nombreUsuarioController,
              decoration: InputDecoration(
                labelText: 'Nombre de usuario',
                hintText: 'nombredeusuario',
                icon: Icon(Icons.email),
              ),
            ),
            SizedBox(height: 32.0),
            ElevatedButton.icon(
              onPressed: () async {
                // Lógica para iniciar sesión
                final usuario =
                    await getUsuario(nombreUsuarioController.text.trim());
                if (usuario != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ListAlimentos(
                            nombreUsuario:
                                nombreUsuarioController.text.trim())),
                  );
                } else {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Usuario incorrecto'),
                      content: Text('Usuario o contraseña incorrecto'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Cerrar'),
                        ),
                      ],
                    ),
                  );
                }
              },
              icon: Icon(Icons.check),
              label: Text('Iniciar sesión'),
              style: ElevatedButton.styleFrom(
                primary: Colors.orange,
                onPrimary: Colors.white,
              ),
            ),
            SizedBox(height: 16.0),
            TextButton(
              onPressed: () {
                // Lógica para ir a la página de inicio de sesión
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CrearUsuarioPage()),
                );
              },
              child: Text('No tienes cuenta? Crea tu propia cuenta!'),
            ),
          ],
        ),
      ),
    );
  }
}
