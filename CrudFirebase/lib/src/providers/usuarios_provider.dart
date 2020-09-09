import 'dart:convert';
import 'dart:io';

import 'package:formvalidation/src/share_preferences/preferencias_user.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

class UsuarioProvider{

  final String _firebaseToken="AIzaSyBa5kbxz1XxtUv0vofXug0LAVrm5AA1T3Q";
  final _prefs = PreferenciasUsuario();

  Future<Map<String,dynamic>>login(String email, String password)async {
     final authData={
      "email"  :email,
      "password": password,
      "returnSecureToken" :true
    };
final ioc = new HttpClient();/////////////////////
        ioc.badCertificateCallback =///////////////
            (X509Certificate cert, String host, int port) => true;///////////////  solo para fines de desarollo borrar para apk
        final http = new IOClient(ioc); //////////////       
    final respuesta = await http.post(
      "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$_firebaseToken",
      body: json.encode(authData)
    );
    Map<String,dynamic> decodeResp = json.decode(respuesta.body);  
    print (decodeResp);
    if(decodeResp.containsKey("idToken")){
      _prefs.token=decodeResp["idToken"];
      return {"ok":true, "token":decodeResp["idToken"]};
    }
    else{
      return {"ok":false, "mensaje":decodeResp["error"]["message"]};
    }
  }

  Future<Map<String,dynamic>> nuevoUsuario(String email, String password)async {
    final authData={
      "email"  :email,
      "password": password,
      "returnSecureToken" :true
    };
final ioc = new HttpClient();/////////////////////
        ioc.badCertificateCallback =///////////////
            (X509Certificate cert, String host, int port) => true;///////////////  solo para fines de desarollo borrar para apk
        final http = new IOClient(ioc); //////////////
       
    final respuesta = await http.post(
      "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_firebaseToken",
      body: json.encode(authData)
    );

    Map<String,dynamic> decodeResp = json.decode(respuesta.body);
    
    print (decodeResp);

    if(decodeResp.containsKey("idToken")){
      _prefs.token=decodeResp["idToken"];
      return {"ok":true, "token":decodeResp["idToken"]};
    }
    else{
      return {"ok":false, "mensaje":decodeResp["error"]["message"]};
    }

  }
}