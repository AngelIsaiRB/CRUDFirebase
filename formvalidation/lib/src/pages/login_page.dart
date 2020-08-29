import 'package:flutter/material.dart';
import 'package:formvalidation/src/blocs/login_bloc.dart';
import 'package:formvalidation/src/blocs/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _crearFondo(context),
          _loginform(context),
        ],
      )
    );
  }

  Widget _crearFondo(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final fondoMorado= Container(
      height: size.height*0.4,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            Color.fromRGBO(63, 63, 156, 1.0),
            Color.fromRGBO(90, 70, 178, 1.0),
            ]
        )
      ),
    );

    final circulo= Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        color: Colors.white10,
      )
    );

    return Stack(
      children: [
        fondoMorado,
        Positioned(child: circulo,top: 90.0,left: 30.0,),
        Positioned(child: circulo,top: -40.0,right: -40.0,),
        Positioned(child: circulo,bottom: -50.0,right: 30.0,),
        Container(
          padding: EdgeInsets.only(top:80.0),
          child: Column(            
            children: [
              Icon(Icons.person_pin_circle, color: Colors.white, size: 100.0,),
              SizedBox(height: 10.0, width: double.infinity,),
              Text("Isai R B", style: TextStyle(color: Colors.white,fontSize: 25.0), )              
            ],
          ),
        )
        
      ],
    );
  }

  Widget _loginform(BuildContext context) {
    final bloc = Provider.of(context);
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(      
      child: Column(
        children: [
          SafeArea(
            child: Container(
              height: 180.0,
            ),
          ),
          Container(
            width: size.width*0.85,
            padding: EdgeInsets.symmetric(vertical: 50.0),
            margin: EdgeInsets.symmetric(vertical: 30.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 3.0,
                  offset: Offset(0.0,5.0),
                  spreadRadius: 3.0
                  ),
              ]
            ),
            child: Column(
              children: [
                Text("ingreso", style: TextStyle(fontSize: 20.0),),
                SizedBox(height: 60.0,),
                _crearEmail(bloc),
                SizedBox(height: 30.0,),
                _crearPassword(bloc),
                SizedBox(height: 30.0,),
                _crearBoton(bloc)
              ],
            ),
          ),
          Text("¿olvido la contraseña?"),
          SizedBox(height: 100.0,)
        ],
      ),
    );
  }
  Widget _crearEmail(LoginBloc bloc){
    return StreamBuilder(
      stream: bloc.emailStream ,      
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          icon: Icon(Icons.alternate_email, color: Colors.deepPurple,),
          hintText: "ejemplo@correo.com",
          labelText: "correo electronico",
          counterText: snapshot.data,
          errorText: snapshot.error
        ),
        onChanged: (value)=>bloc.changeEmail(value),
        //onChanged:bloc.changeEmail,   es lo mismo
      ),
    );
      },
    );
    
  }
  Widget _crearPassword(LoginBloc bloc){

    return StreamBuilder(
      stream: bloc.passwordStream ,      
      builder: (BuildContext context, AsyncSnapshot snapshot){
       return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        obscureText: true,
        decoration: InputDecoration(
          icon: Icon(Icons.lock, color: Colors.deepPurple,),          
          labelText: "contraseña",
          counterText: snapshot.data,
          errorText: snapshot.error
        ),
        onChanged: bloc.changePassword,
      ),
    );
      },
    );
    
  }
  Widget _crearBoton(LoginBloc bloc){
    return StreamBuilder(
      stream: bloc.formValidStream,      
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return RaisedButton(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
        child: Text("Ingresar"),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0)
      ),
      elevation: 0.0,
      color: Colors.deepPurple,
      textColor: Colors.white,      
      onPressed: snapshot.hasData?()=>_login(bloc, context):null,
    );
      },
    );
  }

  _login(LoginBloc bloc, BuildContext context){    
    print("-----------");
    print("email: ${bloc.email}");
    print("password: ${bloc.password} ");
    print("-------------");
    Navigator.pushReplacementNamed(context, "homepage");
  }
}