import 'dart:io';

import 'package:flutter/material.dart';
import 'package:formvalidation/src/blocs/provider.dart';
import 'package:formvalidation/src/models/producto_model.dart';

import 'package:formvalidation/src/utils/utils.dart' as utils;
import 'package:image_picker/image_picker.dart';

class ProductoPage extends StatefulWidget {

  @override
  _ProductoPageState createState() => _ProductoPageState();
}

class _ProductoPageState extends State<ProductoPage> {
 

  final formkey = GlobalKey<FormState>();
  final scaffoldkey = GlobalKey<ScaffoldState>();
  ProductosBloc productosBloc;
  ProductModel producto = new ProductModel();
  bool _guardando =false;
   File foto;

  @override
  Widget build(BuildContext context) {

    productosBloc = Provider.productosBloc(context);

    final ProductModel prodData =ModalRoute.of(context).settings.arguments;
    if(prodData != null){
      producto =prodData;
    }
    return Scaffold(
      key: scaffoldkey,
      appBar: AppBar(
        title: Text("Producto"),
        actions: [
          IconButton(
            icon: Icon(Icons.photo_size_select_actual),
            onPressed: _seleccionarFoto,
          ),
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: _tomarFoto,
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
                _mostrarFoto(),
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
      onPressed: (_guardando)?null : _sumbmit,
      label: Text("Guardar"),
   );
  }

  void _sumbmit()async {

    if(!formkey.currentState.validate()) return ;

    formkey.currentState.save();
    setState(() {
    _guardando=true;      
    });
    if(foto!=null){
     producto.fotoUrl =await productosBloc.subirFoto(foto);
    }
    print ("ok");
    if(producto.id == null){
    productosBloc.agregarProducto(producto);
    }
    else{
      productosBloc.editarProducto(producto);
    }
    setState(() {
    _guardando=false;      
    });
    mostrarSnackbar("Registro exitoso");
    Navigator.pop(context);
    
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
  void mostrarSnackbar(String mensaje){
    final snackbar= SnackBar(
      content: Text(mensaje),
      duration: Duration(milliseconds: 1500),
    );
    scaffoldkey.currentState.showSnackBar(snackbar);
  }

  Widget _mostrarFoto(){
    if(producto.fotoUrl!=null){      
      return FadeInImage(
        image: NetworkImage(producto.fotoUrl),
        placeholder: AssetImage("assets/jar-loading.gif"),
        height: 300,
        fit: BoxFit.contain,
      );
    }
    else{
      return Image(
        image: AssetImage(foto?.path??"assets/no-image.png"),
        height: 300,
        fit: BoxFit.cover,
      );
    }
  }

  _seleccionarFoto()async {
    _procesarImagen(ImageSource.gallery);

  }
  
  _tomarFoto()async {
    _procesarImagen(ImageSource.camera);
  }

  _procesarImagen(ImageSource origen)async{
    final piker=ImagePicker();
    final f = await piker.getImage(source:origen );
    foto=File(f.path);
    if(foto!=null){
    producto.fotoUrl=null;
    }
    setState(() {
      
    });
  }
}