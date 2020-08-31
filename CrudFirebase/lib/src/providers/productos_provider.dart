

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:formvalidation/src/models/producto_model.dart';
import 'package:http/http.dart' as http;

class ProductosProvider{

  final String _url="https://flutter-varios-865b4.firebaseio.com";

  Future<bool>crearProducto(ProductModel producto) async{

    final url="$_url/productos.json";
    final response = await http.post(url, body: productModelToJson(producto));
    final decodedata = json.decode(response.body);
    print (decodedata);
    return true;
  }

  Future<bool>editarProducto(ProductModel producto) async{

    final url="$_url/productos/${producto.id}.json";
    final response = await http.put(url, body: productModelToJson(producto));
    final decodedata = json.decode(response.body);
    
    return true;
  }


  Future<List<ProductModel>>cargarProductos() async {
    final url="$_url/productos.json";
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
    final url="$_url/productos/$id.json";
    final resp = await http.delete(url);
    return 1;

  }

  

}