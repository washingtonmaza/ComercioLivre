import 'dart:convert';
import 'package:comerciolivre/models/vendedores.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../api.dart';

class Anuncios extends StatefulWidget {
  @override
  _AnunciosState createState() => _AnunciosState();
}

class _AnunciosState extends State<Anuncios> {
  var vendedores = <Vendedores>[];
  var itensMenu = <String>[];

  // busca da lista de vendedores transformando em json
  _getVendedores() {
    Api.getUsers().then((response) {
      setState(() {
        Iterable lista = json.decode(response.body);
        vendedores = lista.map((model) => Vendedores.fromJson(model)).toList();
      });
    });
  }

  _AnunciosState() {
    _getVendedores();
  }

  _escolhaMenuItem(String itemEscolhido) {
    switch (itemEscolhido) {
      case "Meus anúncios":
        Navigator.pushReplacementNamed(context, "/meus-anuncios");
        break;
      case "Entrar / Cadastrar":
        Navigator.pushReplacementNamed(context, "/login");
        break;
      case "Sair":
        _deslogarUsuario();
        break;
    }
  }

  _deslogarUsuario() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();

    Navigator.pushReplacementNamed(context, "/login");
  }

  Future _verificarUsuarioLogado() async {
    FirebaseAuth auth = FirebaseAuth.instance;

    if (auth.currentUser == null) {
      itensMenu = ["Entrar / Cadastrar"];
    } else {
      itensMenu = ["Sair"];
    }
  }

  @override
  void initState() {
    super.initState();

    _verificarUsuarioLogado();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Vendedores"),
        elevation: 0,
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: _escolhaMenuItem,
            itemBuilder: (context) {
              return itensMenu.map((String item) {
                return PopupMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList();
            },
          )
        ],
      ),
      body: listaUsuarios(),
    );
  }

  listaUsuarios() {
    return ListView.builder(
        itemCount: vendedores.length,
        itemBuilder: (context, index) {
          return ListTile(
              title: Text(
            vendedores[index].name,
            style: TextStyle(fontSize: 20),
          ));
        });
  }
}
