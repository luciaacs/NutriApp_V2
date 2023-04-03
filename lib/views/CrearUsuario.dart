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
  final TextEditingController EdadController = TextEditingController();
  final TextEditingController PesoController = TextEditingController();
  final TextEditingController AlturaController = TextEditingController();

  List<String> _alergiasSeleccionadas = [];

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
        title: Text('Crear Usuario'),
        automaticallyImplyLeading:
            false, // esto evita que aparezca el botón de volver
      ),
      body: Container(
        padding: const EdgeInsets.all(8.0),
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
            SizedBox(height: 10.0),
            TextField(
              controller: nombreUsuarioController,
              decoration: InputDecoration(
                labelText: 'Nombre de usuario',
                hintText: 'nombredeusuario',
                icon: Icon(Icons.email),
              ),
            ),
            SizedBox(height: 10.0),
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

            ElevatedButton.icon(
              onPressed: () {
                // Lógica para crear la cuenta
                dataBaseHelper.addUsuario(
                  nombreController.text.trim(),
                  nombreUsuarioController.text.trim(),
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ListAlimentos(
                          nombreUsuario: nombreUsuarioController.text.trim())),
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
                    MaterialPageRoute(
                        builder: (context) => IniciarSesionPage()));
              },
              child: Text('Ya tienes cuenta? Inicia sesión'),
            ),
          ],
        ),
      ),
    );
  }
}
