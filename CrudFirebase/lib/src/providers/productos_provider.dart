

import 'dart:convert';
import 'dart:io';
import 'package:formvalidation/src/share_preferences/preferencias_user.dart';
import 'package:mime_type/mime_type.dart';
import 'package:flutter/material.dart';
import 'package:formvalidation/src/models/producto_model.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class ProductosProvider{

  final String _url="https://flutter-varios-865b4.firebaseio.com";
  final _prefs = PreferenciasUsuario();

  Future<bool>crearProducto(ProductModel producto) async{

    final url="$_url/productos.json?auth=${_prefs.token}";
    final response = await http.post(url, body: productModelToJson(producto));
    
    final decodedata = json.decode(response.body);
    
    return true;
  }

  Future<bool>editarProducto(ProductModel producto) async{

    final url="$_url/productos/${producto.id}.json?auth=${_prefs.token}";
    final response = await http.put(url, body: productModelToJson(producto));
    final decodedata = json.decode(response.body);
    
    return true;
  }


  Future<List<ProductModel>>cargarProductos() async {
    final url="$_url/productos.json?auth=${_prefs.token}";
    final respuesta = await http.get(url);    
    final Map<String,dynamic> decodedData =json.decode(respuesta.body);
    final List<ProductModel> productos=new List();
    if(decodedData==null){
      return [];
    }

    decodedData.forEach((id, value) {
      final prodTemp = ProductModel.fromJson(value);
      prodTemp.id=id;
      productos.add(prodTemp);
    });
    
    return productos;
  }

  Future <int> borrarProducto(String id) async {
    final url="$_url/productos/$id.json?auth=${_prefs.token}";
    final resp = await http.delete(url);
    return 1;

  }


  Future <String> subirImagen(File imagen)async{

    final url=Uri.parse("https://api.cloudinary.com/v1_1/angelisai/image/upload?upload_preset=zpezuqp6");
    final mineType=mime(imagen.path).split("/");
    final imageUploadReques = http.MultipartRequest(
      "post",
      url,      
    );

    final file = await http.MultipartFile.fromPath("file", imagen.path,
    contentType: MediaType(mineType[0],mineType[1])
    );

    imageUploadReques.files.add(file);

    final streamrespionde = await imageUploadReques.send();
    final resp= await http.Response.fromStream(streamrespionde);
    if(resp.statusCode!=200 && resp.statusCode!=201){
      print("algo salio mal");
      print(resp.body); 
      return(null);      
    }
    final respData = json.decode(resp.body);
    print(respData);
    return respData["secure_url"];
  }
  

}