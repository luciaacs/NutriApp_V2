import 'package:flutter/material.dart';
import 'package:my_app/controllers/databasehelpers.dart';
import 'package:my_app/views/IniciarSesion.dart';
import 'package:my_app/views/listviewfood.dart';

class CrearUsuarioPage extends StatefulWidget {
  @override
  _CrearUsuarioPageState createState() => _CrearUsuarioPageState();
}

class _CrearUsuarioPageState extends State<CrearUsuarioPage> {
  DataBaseHelper dataBaseHelper = DataBaseHelper();

  final TextEditingController nombreController = TextEditingController();
  final TextEditingController nombreUsuarioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crear Usuario'),
        automaticallyImplyLeading: false, // esto evita que aparezca el botón de volver
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
              onPressed: () {
                // Lógica para crear la cuenta
                dataBaseHelper.addUsuario(
                  nombreController.text.trim(),
                  nombreUsuarioController.text.trim(),
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ListAlimentos(nombreUsuario: nombreUsuarioController.text.trim())),
                );
              },
              icon: Icon(Icons.check),
              label: Text('Crear cuenta'),
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
                   MaterialPageRoute(builder: (context) => IniciarSesionPage())
                 );
              },
              child: Text('Ya tienes cuenta? Inicia sesión'),
            ),
          ],
        ),
      ),
    );
  }
}
