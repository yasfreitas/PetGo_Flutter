import 'package:flutter/material.dart';
import 'package:projeto_petgo/service/ConsultaService.dart';
import 'package:projeto_petgo/model/Consulta.dart';


class TelaConsulta extends StatefulWidget {
  @override
  _TelaConsultaState createState() => _TelaConsultaState();
}

class _TelaConsultaState extends State<TelaConsulta> {
  late Future<List<Consulta>> _consultas;
  final ConsultaService _consultaService = ConsultaService();

  final TextEditingController _dataController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  final TextEditingController _horaController = TextEditingController();
  final TextEditingController _idPetController = TextEditingController();
  final TextEditingController _idVeterinarioController = TextEditingController();


  Consulta? _consultaAtual;

   @override
  void initState() {
  super.initState();
  _atualizarConsulta();}

  void _atualizarConsulta() {
  setState(() {
   _consultas = _consultaService.buscarConsultas();
  });}

  void _mostrarFormulario({Consulta? consulta}) {
  if (consulta != null) {
  _consultaAtual = consulta;
  _dataController.text = consulta.data;
  _descricaoController.text = consulta.descricao;
  _horaController.text = consulta.hora;
  _idPetController.text = consulta.id_pet;
  _idVeterinarioController.text = consulta.id_veterinario;
  } else {
  _consultaAtual = null;
  _dataController.clear();
  _descricaoController.clear();
  _horaController.clear();
  _idPetController.clear();
  _idVeterinarioController.clear();
  }

  showModalBottomSheet(
  context: context,
  isScrollControlled: true,
  builder: (context) => Padding(
    padding: EdgeInsets.only(
      bottom: MediaQuery.of(context).viewInsets.bottom,
      top: 20,
      left: 20,
     right: 20,
    ),
  child: Column(
   mainAxisSize: MainAxisSize.min,
    children: [
      TextField(
       controller: _dataController,
        decoration: InputDecoration(labelText: 'Data'),
    ),
      TextField(
        controller: _descricaoController,
       decoration: InputDecoration(labelText: 'Descricao'),
        keyboardType: TextInputType.number,
      ),
      SizedBox(height: 20),
      //ElevatedButton(
        //onPressed: (),
       //child: Text(_consultaAtual == null ? 'Criar' : 'Atualizar'),
     //),
    ],
   ),
      ),
   );
   }

//  void _submeter() async {
//    final nome = _nomeController.text;
//    final preco = _precoController.text;

//    if (_consultaAtual == null) {
//      final novoConsulta = Consulta(nome: nome, preco: preco);
//      await _consultaService.criarConsulta(novoConsulta);
  //   }
  //   else {
  //     final consultaAtualizado = Consulta(
  //       id: _consultaAtual!.id,
  //       nome: nome,
  //       preco: preco,
  //     );
  //     await _consultaService.atualizarConsulta(consultaAtualizado);
  //   }

  //  Navigator.of(context).pop();
  //  _atualizarConsultas();
  // }

  //void _deletarConsulta(int id) async {
  // try {
  //  await _consultaService.deletarConsulta(id);
  //  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Consulta deletado com sucesso!')));
  //  _atualizarConsultas();
  // } catch (error) {
  // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Falha ao deletar consulta: $error')));
  // } }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CONSULTA'),
        centerTitle: true,
        backgroundColor: Colors.cyan,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => (),
          ),
        ],
      ),
      body: FutureBuilder<List<Consulta>>(
        future: _consultas,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final consulta = snapshot.data![index];
                return ListTile(
                  title: Text(consulta.descricao),
                  subtitle: Text(consulta.data),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () => (),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => (),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
