import 'package:flutter/material.dart';
import 'package:projeto_petgo/service/VeterinarioService.dart';
import 'package:projeto_petgo/model/Veterinario.dart';


class TelaVeterinarios extends StatefulWidget {
  @override
  _TelaVeterinariosState createState() => _TelaVeterinariosState();
}

class _TelaVeterinariosState extends State<TelaVeterinarios> {
  late Future<List<Veterinario>> _veterinarios;
  final VeterinarioService _veterinarioService = VeterinarioService();

  final TextEditingController _cidadeController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _crmvController = TextEditingController();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _numeroController = TextEditingController();
  final TextEditingController _ruaController = TextEditingController();
  final TextEditingController _telefone1Controller = TextEditingController();
  final TextEditingController _telefone2Controller = TextEditingController();

  Veterinario? _veterinarioAtual;

  @override
  void initState() {
    super.initState();
    _atualizarVeterinarios();
  }

  void _atualizarVeterinarios() {
    setState(() {
      _veterinarios = _veterinarioService.buscarVeterinarios();
    });
  }

  void _mostrarFormulario({Veterinario? veterinario}) {
    if (veterinario!= null) {
      _veterinarioAtual = veterinario;
      _cidadeController.text = veterinario.cidade;
      _cpfController.text = veterinario.cpf;
      _crmvController.text = veterinario.crmv;
      _nomeController.text = veterinario.nome;
      _numeroController.text = veterinario.numero;
      _ruaController.text = veterinario.rua;
      _telefone1Controller.text = veterinario.telefone1;
      _telefone2Controller.text = veterinario.telefone2;
    } else {
      _veterinarioAtual = null;
      _cidadeController.clear();
      _cpfController.clear();
      _crmvController.clear();
      _nomeController.clear();
      _numeroController.clear();
      _ruaController.clear();
      _telefone1Controller.clear();
      _telefone2Controller.clear();
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
              controller: _telefone1Controller,
              decoration: InputDecoration(labelText: 'Telefone 1'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submeter,
              child: Text(_veterinarioAtual == null ? 'Criar' : 'Atualizar'),
            ),
          ],
        ),
      ),
    );
  }

  void _submeter() async {
    final cidade = _cidadeController.text;
    final cpf = _cpfController.text;
    final crmv = _crmvController.text;
    final nome = _nomeController.text;
    final numero = _numeroController.text;
    final rua = _ruaController.text;
    final telefone1 = _telefone1Controller.text;
    final telefone2 = _telefone2Controller.text;

    if (_veterinarioAtual == null) {
      final novoVeterinario = Veterinario(cidade: cidade, cpf: cpf, crmv: crmv,
          nome: nome, numero: numero, rua: rua, telefone1: telefone1, telefone2: telefone2);
      await _veterinarioService.criarVeterinario(novoVeterinario);
    }
    else {
      final veterinarioAtualizado = Veterinario(
        id: _veterinarioAtual!.id,
        cidade: cidade,
        cpf: cpf,
        crmv: crmv,
        nome: nome,
        numero: numero,
        rua: rua,
        telefone1: telefone1,
        telefone2: telefone2,
      );
      await _veterinarioService.atualizarVeterinario(veterinarioAtualizado);
    }

    Navigator.of(context).pop();
    _atualizarVeterinarios();
  }

  void _deletarVeterinario(int id) async {
    try {
      await _veterinarioService.deletarVeterinario(id);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Veterinario deletado com sucesso!')));
      _atualizarVeterinarios();
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Falha ao deletar veterinario: $error')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Veterinario'),
        centerTitle: true,
        backgroundColor: Colors.cyan,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _mostrarFormulario(),
          ),
        ],
      ),
      body: FutureBuilder<List<Veterinario>>(
        future: _veterinarios,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final veterinario = snapshot.data![index];
                return ListTile(
                  title: Text(veterinario.nome),
                  subtitle: Text(veterinario.telefone1),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () => _mostrarFormulario(veterinario: veterinario),
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