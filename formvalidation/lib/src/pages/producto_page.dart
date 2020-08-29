import 'package:flutter/material.dart';
import 'package:formvalidation/src/utils/utils.dart' as utils;

class ProductoPage extends StatefulWidget {

  @override
  _ProductoPageState createState() => _ProductoPageState();
}

class _ProductoPageState extends State<ProductoPage> {
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Producto"),
        actions: [
          IconButton(
            icon: Icon(Icons.photo_size_select_actual),
            onPressed: (){},
          ),
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: (){},
          )
        ],
      ),

      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: formkey,
            child: Column(
              children: [
                _crearNombre(),
                _crearPrecio(),
                _crearBoton()
              ],
            ),

          ),
        ),
      ),

    );
  }

  Widget _crearNombre() {
    return TextFormField(
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: "producto"
      ),
      validator: (value){
        if(value.length<3){
          return "ingrese el nombre";
        }
        else{return null;}
      },
    );
  }

 Widget _crearPrecio() {
   return TextFormField(
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: "precio"
      ),
      validator: (value){
       if(utils.isNumeric(value)){
         return null;
       }
       else{
         return "Solo numeros";
       }
      },
    );
 }

 Widget _crearBoton() {
    return RaisedButton.icon( 
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0)
      ),     
      color: Colors.deepPurple,
      textColor: Colors.white,
      icon: Icon(Icons.save),
      onPressed: _sumbmit,
      label: Text("Guardar"),
   );
  }

  void _sumbmit(){

    if(!formkey.currentState.validate()) return ;

    print ("ok");
    
  }
}