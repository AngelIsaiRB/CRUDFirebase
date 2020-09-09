import 'package:flutter/material.dart';
import 'package:formvalidation/src/blocs/provider.dart';
import 'package:formvalidation/src/pages/home_page.dart';
import 'package:formvalidation/src/pages/login_page.dart';
import 'package:formvalidation/src/pages/producto_page.dart';
import 'package:formvalidation/src/pages/registro_page.dart';
import 'package:formvalidation/src/share_preferences/preferencias_user.dart';
 
void main() async{
  runApp(MyApp());
  final prefs = new  PreferenciasUsuario();
  await prefs.initprefs();
}
 
class MyApp extends StatelessWidget {    

  @override
  Widget build(BuildContext context) {
    final prefs = new  PreferenciasUsuario();
    print (prefs.token);
    return Provider(
        child: MaterialApp(
        title: 'Material App',
        debugShowCheckedModeBanner: false,
        initialRoute: "login",
        routes: {
          "login": (BuildContext context)=> LoginPage(),
          "homepage" : (BuildContext context)=> HomePage(),
          "producto" : (BuildContext context)=> ProductoPage(),
          "registro" : (BuildContext context)=>RegistroPage(),
        },
        theme: ThemeData(
          primaryColor: Colors.purple
        ),
      ),
    );
  }
}