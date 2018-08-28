import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:biblia_app/src/icons/bible_icons.dart';
import 'capitulos.dart';
import 'package:biblia_app/src/shared/Livro.dart';

class HomePage extends StatefulWidget {
  @override
  StateHomePage createState() => StateHomePage();
}

class StateHomePage extends State<HomePage>
    with SingleTickerProviderStateMixin {
  List<Livro> lista = [];
  String url = "https://biblia-catolica.herokuapp.com/api/biblia";

  Future<Map> getbiblia() async {
    Map data = Map();
    var response =
        await http.get(url, headers: {"Content-Type": "application/json"});

    data = jsonDecode(response.body);
    return data;
  }

  void loading() {
    lista = [];
    getbiblia().then((data) {
      List list = data["livros"];
      if (list.length > 0) {
        print(list);
        for (int i = 0; i < list.length && (i + 1) < list.length + 1; i++) {
          setState(() {
            lista.add(Livro(list[i]["nome"], list[i]["id"]));
          });
        }
      }
    });
  }

  TabController controller;

  @override
  void initState() {
    super.initState();
    controller = new TabController(length: 3, vsync: this);
    loading();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  buildListTiles(BuildContext context, var nome, var pos) {
    return new MergeSemantics(
      child: new ListTile(
        title: new Text(nome, style: TextStyle(fontWeight: FontWeight.bold)),
        leading: new Icon(Icons.bookmark, color: Colors.yellowAccent,),
        onTap: () {
          var route = new MaterialPageRoute(builder: (context) => new Capitulos( pos.toString(), nome ));
          Navigator.push(context, route);
        },
        trailing: new IconButton(
            icon: new Icon(
              Bible.heart,
              color: Colors.white,
            ),
            onPressed: () {
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Iterable<Widget> listtiles =
        lista.map((item) => buildListTiles(context, item.nome, item.id));

    return new Scaffold(
        drawer: new Drawer(
            child: new Column(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              decoration: new BoxDecoration(
                image: new DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/2.0x/images/biblia.jpg')),
                    
              ),
              accountName: new Text("Nome"),
              accountEmail: new Text("Email"),
              currentAccountPicture: new CircleAvatar(
                child: new Icon(Icons.person),
              ),
            ),
            new ListTile(
              title: new Text("Meus favoritos"),
              trailing: new Icon(
                Bible.heart,
                color: Colors.red,
              ),
              onTap:()
                   {
                   },
            ),
            new Divider(
              height: 2.0,
            ),
          ],
        )),
        appBar: new AppBar(
          bottom: new TabBar(
            controller: controller,
            tabs: <Widget>[
              new Tab(
                child: new Icon(
                  Icons.book
                ),
              ),
              new Tab(
                child: new Icon(
                    Icons.search
                ),
              ),
              new Tab(
                child: new Icon(
                    Icons.favorite
                ),
              ),
            ],
          ),
          backgroundColor: Colors.blueAccent,
        ),
        body: new TabBarView(
          controller: controller,
          children: <Widget>[

            new ListView(
              children: lista.length < 1
                  ? <Widget>[
                      new SizedBox(
                        height: 200.0,
                      ),
                      new Center(child: new CircularProgressIndicator())
                    ]
                  : listtiles.toList(),


            ),

            new Text("Pesquisa"),

            new Text("Favoritos"),

          ],
        ));
  }
}
