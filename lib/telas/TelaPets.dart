import 'package:flutter/material.dart';
import 'package:projeto_petgo/service/PetService.dart';
import 'package:projeto_petgo/model/Pet.dart';

class TelaPet extends StatefulWidget {
  @override
  _TelaPetState createState() => _TelaPetState();
}

class _TelaPetState extends State<TelaPet> {
  late Future<List<Pet>> _pet;
  final PetService _petService = PetService();

  final TextEditingController _corController = TextEditingController();
  final TextEditingController _documentoController = TextEditingController();
  final TextEditingController _nascimentoController = TextEditingController();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _racaController = TextEditingController();

  Pet? _petAtual;

  @override
  void initState() {
    super.initState();
    _atualizarPets();
  }

  void _atualizarPets() {
    setState(() {
      _pet = _petService.buscarPets();
    });
  }

  void _mostrarFormulario({Pet? pet}) {
    if (pet != null) {
      _petAtual = pet;
      _corController.text = pet.cor;
      _documentoController.text = pet.documento;
      _nascimentoController.text = pet.nascimento;
      _nomeController.text = pet.nome;
      _racaController.text = pet.raca;
    } else {
      _petAtual = null;
      _corController.clear();
      _documentoController.clear();
      _nascimentoController.clear();
      _nomeController.clear();
      _racaController.clear();
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
              controller: _nomeController,
              decoration: InputDecoration(labelText: 'Nome'),
            ),
            TextField(
              controller: _corController,
              decoration: InputDecoration(labelText: 'Cor'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _documentoController,
              decoration: InputDecoration(labelText: 'Documento'),
            ),
            TextField(
              controller: _nascimentoController,
              decoration: InputDecoration(labelText: 'Nascimento'),
            ),
            TextField(
              controller: _racaController,
              decoration: InputDecoration(labelText: 'Raça'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            //   ElevatedButton(
            //   onPressed: _submeter,
            // child: Text(_petAtual == null ? 'Criar' : 'Atualizar'),
            //),
          ],
        ),
      ),
    );
  }

//  void _submeter() async {
  //  final nome = _nomeController.text;
  //final raca = _racaController.text;
  // final cor = _corController.text;
  //   final documento = _documentoController.text;
  // final nascimento = _nascimentoController.text;

  //   if (_petAtual == null) {
  //   final novoPet = Pet(nome: nome, raca: raca, nascimento: nascimento, cor: cor, documento: documento);
  // await _apiService.criarPet(novoPet);
  //}
  // else {
  // final petAtualizado = Pet(
  // id: _petAtual!.id,
  //       nome: nome,
  //cor: cor,
  //     nascimento: nascimento,
  //   documento:documento,
  // raca: raca,
  //);
  // await _apiService.atualizarPet(petAtualizado);
  //}

//    Navigator.of(context).pop();
  //  _atualizarPets();
  //}

  //void _deletarPet(int id) async {
  //try {
  //await _apiService.deletarPet(id);
//      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Pet deletado com sucesso!')));
  //    _atualizarPets();
  //} catch (error) {
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Falha ao deletar pet: $error')));
  // }
  //}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PETS'),
        centerTitle: true,
        backgroundColor: Colors.cyan,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _mostrarFormulario(),
          ),
        ],
      ),
      body: FutureBuilder<List<Pet>>(
        future: _pet,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final pet = snapshot.data![index];
                return ListTile(
                  title: Text(pet.nome),
                  subtitle: Text(pet.raca),
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
