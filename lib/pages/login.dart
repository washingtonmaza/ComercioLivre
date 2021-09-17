import 'package:comerciolivre/models/usuario.dart';
import 'package:comerciolivre/widgets/input_customizado.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _controllerEmail =
      TextEditingController(text: "washington@ortep.com");
  TextEditingController _controllerSenha =
      TextEditingController(text: "teste123");

  bool _cadastrar = false;
  String _mensagemErro = "";
  String _textoBotao = "Entrar";

  _cadastrarUsuario(Usuario usuario) {
    FirebaseAuth auth = FirebaseAuth.instance;

    auth
        .createUserWithEmailAndPassword(
            email: usuario.email, password: usuario.senha)
        .then((firebaseUser) {
      //redireciona para tela principal
      //Navigator.pushReplacementNamed(context, "/");
    });
  }

  _logarUsuario(Usuario usuario) {
    FirebaseAuth auth = FirebaseAuth.instance;

    auth
        .signInWithEmailAndPassword(
            email: usuario.email, password: usuario.senha)
        .then((firebaseUser) {
      //redireciona para tela principal
      Navigator.pushReplacementNamed(context, "/anuncios");
    });
  }

  _validarCampos() {
    //Recupera dados dos campos
    String email = _controllerEmail.text;
    String senha = _controllerSenha.text;

    if (email.isNotEmpty && email.contains("@")) {
      if (senha.isNotEmpty && senha.length > 6) {
        //Configura usuario
        Usuario usuario = Usuario();
        usuario.email = email;
        usuario.senha = senha;

        //cadastrar ou logar
        if (_cadastrar) {
          _cadastrarUsuario(usuario);

          showDialog<void>(
            context: context,
            barrierDismissible: false, // user must tap button!
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Confirmação de cadastro'),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: const <Widget>[
                      Text('Parabéns você se cadastrou com sucesso'),
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text('ok'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
          setState(() {
            _cadastrar = false;
            _textoBotao = 'Entrar';
          });
        } else {
          //Loga o usuario
          _logarUsuario(usuario);
        }
      } else {
        setState(() {
          _mensagemErro = "Preencha a senha! digite mais de 6 caracteres";
        });
      }
    } else {
      setState(() {
        _mensagemErro = "Preencha o E-mail válido";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        leading: SizedBox(),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 32),
                  child: Image.asset(
                    "resources/images/logo.png",
                    width: 200,
                    height: 150,
                  ),
                ),
                InputCustomizado(
                  controller: _controllerEmail,
                  hint: "E-mail",
                  autofocus: true,
                  type: TextInputType.emailAddress,
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 15),
                ),
                InputCustomizado(
                    controller: _controllerSenha, hint: "Senha", obscure: true),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Logar"),
                    Switch(
                      value: _cadastrar,
                      onChanged: (bool valor) {
                        setState(() {
                          _cadastrar = valor;
                          _textoBotao = "Entrar";
                          if (_cadastrar) {
                            _textoBotao = "Cadastrar";
                          }
                        });
                      },
                    ),
                    Text("Cadastrar"),
                  ],
                ),
                ElevatedButton(
                  child: Text(
                    _textoBotao,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          EdgeInsets.all(15)),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Color(0xff9c27b0)),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32)),
                      )),
                  onPressed: () {
                    _validarCampos();
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text(
                    _mensagemErro,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.red),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
