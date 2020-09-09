import 'package:flutter/material.dart';
import 'package:formvalidation/src/blocs/provider.dart';
import 'package:formvalidation/src/models/producto_model.dart';


class HomePage extends StatelessWidget {
 
 

  @override
  Widget build(BuildContext context) {
    
    final productosBloc = Provider.productosBloc(context);
    productosBloc.cargarProductos();
    
    return Scaffold(
      appBar: AppBar(
        title:Text("home")
      ),
      body: _crearListado(productosBloc),

      floatingActionButton: _crearBoton(context),
    );
  }

  Widget _crearListado(ProductosBloc productosBloc){

    return StreamBuilder(
      stream:  productosBloc.productosStream,      
      builder: (BuildContext context, AsyncSnapshot<List<ProductModel>> snapshot){
        if(snapshot.hasData){
          final productos=snapshot.data;
            return ListView.builder(
              itemCount: productos.length,
              itemBuilder: ( context, i){
               return  _crearItem( context, productos[i],productosBloc);
              },
              
              );
        }
        else{
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );

   
  }

  Widget _crearItem(BuildContext context, ProductModel producto,ProductosBloc productosBloc){
    
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.red,
      ),
      onDismissed: (direccion){
      //  productosProvider.borrarProducto(producto.id);
      productosBloc.borrarProducto(producto.id);
      },
      child: Card(
        child: Column(
          children: [
            (producto.fotoUrl==null)?Image(image: AssetImage("assets/no-image.png"),):
             FadeInImage(
              image: NetworkImage(producto.fotoUrl),
              placeholder: AssetImage("assets/jar-loading.gif"),
              height: 300,
              width: double.infinity,
              fit: BoxFit.cover,
             ),
             ListTile(
        title: Text("${producto.titulo} - ${producto.valor}" ),
        subtitle: Text(producto.id),
        onTap: ()=>Navigator.pushNamed(context, "producto", arguments: producto),
      ), 
          ],
        ),
      )
    );
  }


  _crearBoton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      backgroundColor: Colors.deepPurple,
      onPressed: ()=>Navigator.pushNamed(context, "producto"),
    );
  }
}