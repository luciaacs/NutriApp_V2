import 'dart:core';
import 'dart:ffi';

import 'package:http/http.dart' as http;
import 'dart:convert';

class DataBaseHelper{

// Add
  Future <http.Response> addAlimento(String nameController, double cantidadController,double caloriasController, double grasasController, double proteinasController, double carbohidratosController) async {
    var url ="http://192.168.1.51:8080/foods/add";
    Map data={
      'name':nameController,
      'cantidad':'$cantidadController',
      'calorias':'$caloriasController',
      'grasas': '$grasasController',
      'proteinas': '$proteinasController',
      'carbohidratos': '$carbohidratosController'
    } ;
    var body =json.encode(data);
    var response = await http.post(Uri.parse(url),
      headers:{"Content-Type" : "application/json"}, body: body );
      print("${response.statusCode}");
      print("${response.body}");
      return response;
  } 
  
}
