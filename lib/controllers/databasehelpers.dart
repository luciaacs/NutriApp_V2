import 'dart:core';
import 'dart:ffi';

import 'package:http/http.dart' as http;
import 'dart:convert';

class DataBaseHelper{

// Add
  Future <http.Response> addAlimento(String nameController, double cantidadController,double caloriasController, double grasasController, double proteinasController, double carbohidratosController, String imageController, String nombreUsuarioController) async {
    var url ="http://localhost:8080/foods/add";
    Map data={
      'name':nameController,
      'cantidad':'$cantidadController',
      'calorias':'$caloriasController',
      'grasas': '$grasasController',
      'proteinas': '$proteinasController',
      'carbohidratos': '$carbohidratosController',
      'image': imageController,
      'nombreUsuario': nombreUsuarioController
    } ;
    var body =json.encode(data);
    var response = await http.post(Uri.parse(url),
      headers:{"Content-Type" : "application/json"}, body: body );
      print("${response.statusCode}");
      print("${response.body}");
      return response;
  } 

  // Add
  Future <http.Response> addUsuario(String nombreController, String nombreUsuarioController) async {
    var url ="http://localhost:8080/users/add";
    Map data={
      'nombre':nombreController,
      'nombreUsuario':nombreUsuarioController,
    } ;
    var body =json.encode(data);
    print(body);
    var response = await http.post(Uri.parse(url),
      headers:{"Content-Type" : "application/json"}, body: body );
      print("${response.statusCode}");
      print("${response.body}");
      return response;
  } 

   // Add
  Future <http.Response> updateUsuario( String nombreController, String nombreUsuarioController) async {
    var url ="http://localhost:8080/users/$nombreUsuarioController";
    Map data={
      'nombre':nombreController,
      'nombreUsuario':nombreUsuarioController,
    } ;
    var body =json.encode(data);
    var response = await http.put(Uri.parse(url),
      headers:{"Content-Type" : "application/json"}, body: body );
      print("${response.statusCode}");
      print("${response.body}");
      return response;
  } 

  // Delete
  Future <http.Response> deleteAlimento(int id) async {
    var url ="http://localhost:8080/foods/{id}";
      var response = await http.delete(Uri.parse(url),
        headers:{"Content-Type" : "application/json"} );
        print("${response.statusCode}");
        print("${response.body}");
        return response;

  } 

}
