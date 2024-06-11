import 'dart:convert';
import 'package:projeto_petgo/model/Tipo.dart';
import 'package:http/http.dart' as http;

class TipoService {
  static const String baseUrl = 'http://10.121.138.123:8080/tipo/';

  Future<List<Tipo>> buscarTipos() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((dynamic item) => Tipo.fromJson(item)).toList();
    } else {
      throw Exception('Falha ao carregar tipo');
    }
  }

  Future<void> criarTipo(Tipo tipo) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset= UFT-8'
      },
      body: jsonEncode(tipo.toJson()),
    );
    if (response.statusCode != 201) {
      throw Exception('Falha ao criar tipo ');
    }
  }

  Future<void> atualizarTipo(Tipo tipo) async {
    final response = await http.put(
      Uri.parse('$baseUrl${tipo.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset= UFT-8'
      },
      body: jsonEncode(tipo.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Falha ao atualizar tipo ');
    }
  }

  Future<void> deletarTipo(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl$id'));
    if (response.statusCode == 204) {
      print('Tipo deletado com sucesso');
    } else {
      print('Erro ao deletar tipo: ${response.statusCode} ${response.body}');
      throw Exception('Falha ao deletar tipo');
    }
  }
}
