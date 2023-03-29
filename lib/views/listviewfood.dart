import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/views/AddAlimentoPage.dart';
import 'package:my_app/views/buscador.dart';

class ListAlimentos extends StatefulWidget {
  @override
  _ListAlimentosState createState() => _ListAlimentosState();
}

class _ListAlimentosState extends State<ListAlimentos> {
  late List data;

  Future<List> getData() async {
    final response =
        await http.get(Uri.parse("http://192.168.1.51:8080/foods"));
    return json.decode(response.body);
  }

  @override
  void initState() {
    super.initState();
    this.getData();
  }

  _navigateAddAlimento(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddAlimentoPage()),
    );
    if (result) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alimentos'),

        // ignore: prefer_const_literals_to_create_immutables
        actions: [
          IconButton(
            color: Colors.black12,
            icon: Icon(Icons.add),
            onPressed: () => _navigateAddAlimento(context),
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => BuscadorComida()));
            },
          ),
        ],
      ),
      body: FutureBuilder<List>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
          }
          return snapshot.hasData
              ? ItemList(
                  list: snapshot.data!,
                )
              : const Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}

class ItemList extends StatelessWidget {
  final List list;

  const ItemList({required this.list});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        return Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                height: 100.3,
                child: Card(
                  color: Colors.orangeAccent,
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            list[i]['name'].toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.w300,
                              fontStyle: FontStyle.normal,
                              fontFamily: "Open Sans",
                              fontSize: 30.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.remove_circle_outline),
                        color: Colors.white,
                        onPressed: () {
                          // Añada aquí el código para borrar el alimento
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.remove_red_eye),
                        color: Colors.white,
                        onPressed: () {
                          // Añada aquí el código para ver el alimento
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

}
