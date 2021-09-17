import 'package:comerciolivre/route_generator.dart';
import 'package:comerciolivre/pages/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

final ThemeData temaPadrao =
    ThemeData(primaryColor: Color(0xff9c27b0), accentColor: Color(0xff7b1fa2));

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    title: "Comercio Livre",
    home: Login(),
    theme: temaPadrao,
    initialRoute: '/login',
    // rota inicial
    onGenerateRoute: RouteGenerator.generateRoute,
    // classe pra gerenciar as rotas
    debugShowCheckedModeBanner: false,
  ));
}
