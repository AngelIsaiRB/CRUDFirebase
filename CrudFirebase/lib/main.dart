import 'package:flutter/material.dart';
import 'package:formvalidation/src/blocs/provider.dart';
import 'package:formvalidation/src/pages/home_page.dart';
import 'package:formvalidation/src/pages/login_page.dart';
import 'package:formvalidation/src/pages/producto_page.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
        child: MaterialApp(
        title: 'Material App',
        debugShowCheckedModeBanner: false,
        initialRoute: "homepage",
        routes: {
          "login": (BuildContext context)=> LoginPage(),
          "homepage" : (BuildContext context)=> HomePage(),
          "producto" : (BuildContext context)=> ProductoPage()
        },
        theme: ThemeData(
          primaryColor: Colors.purple
        ),
      ),
    );
  }
}