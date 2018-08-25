import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

class Capitulo {
  var id;
  Capitulo(this.id);
}

class Capitulos extends StatefulWidget {

  final String livro;

  Capitulos(this.livro);

  CapitulosState createState() => new CapitulosState();

}

class CapitulosState extends State<Capitulos> {

  List<Capitulo> lista = [];
  String url;

  Future<Map> getcapitulos() async {
    Map data = Map();
    http.Response response =
    await http.get(url, headers: {"Content-Type": "application/json"});

    data = jsonDecode(response.body);
    return data;
  }

  void loading() {
    lista = [];
    getcapitulos().then((data) {
      List list = data["genesis"];
      if (list.length > 0) {
        print(list);
        for (int i = 0; i < list.length && (i + 1) < list.length + 1; i++) {
          setState(() {
            lista.add(Capitulo(list[i]["id"]));
          });
        }
      }
    });
  }

  @override
  void initState() {
    this.url = 'https://biblia-catolica.herokuapp.com/api/biblia/' + widget.livro + '/capitulos';
    super.initState();
    loading();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new GridView.builder(
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
        itemCount: lista.length,
        itemBuilder: (BuildContext context, int index) {
          return cards(index);
        },

      ),
    );


  }

  Widget cards(val){
    return new Card(
      color: Colors.pink,
      child:new Padding(
        padding: const EdgeInsets.all(10.0),
        child: new Text('$val'),
      ),);
  }

}