import 'package:flutter/material.dart';
import 'package:projeto_petgo/telas/TelaProprietarios.dart';
import 'package:projeto_petgo/telas/TelaEspecialidades.dart';
import 'package:projeto_petgo/telas/TelaVeterinarios.dart';
import 'package:projeto_petgo/telas/TelaConsultas.dart';
import 'package:projeto_petgo/telas/TelaPets.dart';
import 'package:projeto_petgo/telas/TelaTipos.dart';

class TelaPrincipal extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('PETGO'),
        centerTitle: true,
        backgroundColor: Colors.cyan,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.cyan,
              ),
              child: Text(
                'Menu Principal',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.list),
              title: Text('Pets'),
              onTap: (){
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => TelaPet()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.list),
              title: Text('Proprietarios'),
              onTap: (){
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => TelaProprietarios()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.list),
              title: Text('Veterinarios'),
              onTap: (){
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => TelaVeterinarios()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.list),
              title: Text('Especialidades'),
              onTap: (){
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => TelaEspecialidades()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.list),
              title: Text('Tipos'),
              onTap: (){
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => TelaTipo()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.list),
              title: Text('Consultas'),
              onTap: (){
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => TelaConsulta()),
                );
              },
            )
          ],
        ),
      ),
      body: Center(
          child: Text('Bem-vindo à Tela Principal!',
              style: TextStyle(color: Colors.blueGrey, fontSize: 20)
          )
      ),
    );
  }
}
