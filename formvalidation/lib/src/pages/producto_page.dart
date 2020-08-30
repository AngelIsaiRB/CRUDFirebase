import 'package:flutter/material.dart';
import 'package:formvalidation/src/models/producto_model.dart';
import 'package:formvalidation/src/providers/productos_provider.dart';
import 'package:formvalidation/src/utils/utils.dart' as utils;

class ProductoPage extends StatefulWidget {

  @override
  _ProductoPageState createState() => _ProductoPageState();
}

class _ProductoPageState extends State<ProductoPage> {
  ProductModel producto = new ProductModel();
  final formkey = GlobalKey<FormState>();
  final productoProvider = new ProductosProvider();

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
                _creardisponible(),
                _crearBoton(),
              ],
            ),

          ),
        ),
      ),

    );
  }

  Widget _crearNombre() {
    return TextFormField(
      initialValue: producto.titulo,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: "producto"
      ),
      onSaved: (value)=>producto.titulo=value,
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
     initialValue: producto.valor.toString(),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: "precio"
      ),
      onSaved: (value)=>producto.valor=double.parse(value),
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

    formkey.currentState.save();

    print ("ok");

    productoProvider.crearProducto(producto);

    
  }

  Widget _creardisponible() {
    return SwitchListTile(
      
      value: producto.disponible,
      title: Text("Disponible"),
      activeColor: Colors.deepPurple,
      onChanged: (value) => setState((){
        producto.disponible=value;
      }),
    );
  }
}