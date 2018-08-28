import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:biblia_app/src/widgets/widget.dart';
import 'package:biblia_app/src/shared/Capitulo.dart';

class Versiculos extends StatefulWidget {

  final String livro;
  final String nome;

  Versiculos(this.livro, this.nome);

  VersiculosState createState() => new VersiculosState();

}

class VersiculosState extends State<Versiculos> {

  List<Versiculo> lista = [];
  String url;

  Future<Map> getcapitulos() async {
    Map data = Map();
    var response = await http.get(url, headers: {"Content-Type": "application/json"});

    data = jsonDecode(response.body);
    return data;
  }

  void loading(String livro, String nome) {
    lista = [];
    getcapitulos().then((data) {
      List list = data[livro][nome];
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
    loading(widget.livro, widget.nome);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text(widget.nome),
        backgroundColor: Colors.blueAccent,
      ),
      body: new GridView.builder(
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
        itemCount: lista.length,
        itemBuilder: (BuildContext context, int index) {
          return cards( index + 1 );
        },

      ),
    );


  }

}