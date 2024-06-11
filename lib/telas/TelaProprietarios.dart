import 'package:projeto_petgo/service/ProprietarioService.dart';
import 'package:flutter/material.dart';
import 'package:projeto_petgo/model/Proprietario.dart';


class TelaProprietarios extends StatefulWidget {
  @override
  _TelaProprietariosState createState() => _TelaProprietariosState();
}

class _TelaProprietariosState extends State<TelaProprietarios> {
  late Future<List<Proprietario>> _proprietarios;
  final ProprietarioService _proprietarioService = ProprietarioService();

  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _rgController = TextEditingController();
  final TextEditingController _cidadeController = TextEditingController();
  final TextEditingController _ruaController = TextEditingController();
  final TextEditingController _numeroController = TextEditingController();
  final TextEditingController _telefone1Controller = TextEditingController();
  final TextEditingController _telefone2Controller = TextEditingController();

  Proprietario? _proprietarioAtual;

  @override
  void initState() {
    super.initState();
    _atualizarProprietarios();
  }

  void _atualizarProprietarios() {
    setState(() {
      _proprietarios = _proprietarioService.buscarProprietarios();
    });
  }

  void _mostrarFormulario({Proprietario? proprietario}) {
    if (proprietario != null) {
      _proprietarioAtual = proprietario;
      _nomeController.text = proprietario.nome;
      _cpfController.text = proprietario.cpf;
      _rgController.text = proprietario.rg;
      _ruaController.text = proprietario.rua;
      _cidadeController.text = proprietario.cidade;
      _numeroController.text = proprietario.numero;
      _telefone1Controller.text = proprietario.telefone1;
      _telefone2Controller.text = proprietario.telefone2;
    } else {
      _proprietarioAtual = null;
      _nomeController.clear();
      _cpfController.clear();
      _rgController.clear();
      _cidadeController.clear();
      _ruaController.clear();
      _numeroController.clear();
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
              controller: _cpfController,
              decoration: InputDecoration(labelText: 'CPF'),
            ),
            TextField(
              controller: _rgController,
              decoration: InputDecoration(labelText: 'RG'),
            ),
            TextField(
              controller: _cidadeController,
              decoration: InputDecoration(labelText: 'Cidade'),
            ),
            TextField(
              controller: _ruaController,
              decoration: InputDecoration(labelText: 'Rua'),
            ),
            TextField(
              controller: _numeroController,
              decoration: InputDecoration(labelText: 'Numero da casa'),
            ),
            TextField(
              controller: _telefone1Controller,
              decoration: InputDecoration(labelText: 'Telefone 1'),
            ),
            TextField(
              controller: _telefone2Controller,
              decoration: InputDecoration(labelText: 'Telefone 2'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submeter,
              child: Text(_proprietarioAtual == null ? 'Criar' : 'Atualizar'),
            ),
          ],
        ),
      ),
    );
  }

  void _submeter() async {
    final nome = _nomeController.text;
    final cpf = _cpfController.text;
    final rg = _rgController.text;
    final cidade = _cidadeController.text;
    final rua = _ruaController.text;
    final numero = _numeroController.text;
    final telefone1 = _telefone1Controller.text;
    final telefone2 = _telefone2Controller.text;

    if (_proprietarioAtual == null) {
      final novoProprietario = Proprietario(nome: nome, cpf: cpf, rg: rg, cidade: cidade,
          rua: rua, numero: numero, telefone1: telefone1, telefone2: telefone2);
      await _proprietarioService.criarProprietario(novoProprietario);
    }
    else {
      final proprietarioAtualizado = Proprietario(
        id: _proprietarioAtual!.id,
        nome: nome,
        cpf: cpf,
        rg: rg,
        cidade: cidade,
        rua: rua,
        numero: numero,
        telefone1: telefone1,
        telefone2: telefone2,
      );
      await _proprietarioService.atualizarProprietario(proprietarioAtualizado);
    }

    Navigator.of(context).pop();
    _atualizarProprietarios();
  }

  void _deletarProprietario(int id) async {
    try {
      await _proprietarioService.deletarProprietario(id);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Proprietario deletado com sucesso!')));
      _atualizarProprietarios();
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Falha ao deletar proprietario: $error')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PROPRIETARIOS'),
        centerTitle: true,
        backgroundColor: Colors.cyan,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _mostrarFormulario(),
          ),
        ],
      ),
      body: FutureBuilder<List<Proprietario>>(
        future: _proprietarios,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final proprietario = snapshot.data![index];
                return ListTile(
                  title: Text(proprietario.nome),
                  subtitle: Text(proprietario.cpf),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () => _mostrarFormulario(proprietario: proprietario),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => _deletarProprietario(proprietario.id!),
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
