
import 'package:shared_preferences/shared_preferences.dart';

class PreferenciasUsuario{

  static PreferenciasUsuario _instancia = new PreferenciasUsuario._internal();
  factory PreferenciasUsuario(){
    return _instancia;
  }
  PreferenciasUsuario._internal();
  SharedPreferences _prefs ;

  initprefs()async {
    this._prefs = await SharedPreferences.getInstance();
  }



  get token{
    return _prefs.getString("token") ?? "";
  }

  set token(String value){
    _prefs.setString("token", value);
  }

   get tokenUser{
    return _prefs.getString("tokenUser") ?? "aasdasd";
  }

  set tokenUser(String value){
    _prefs.setString("tokenUser", value);
  }


}