import 'dart:convert';
import 'package:projeto_petgo/model/Pet.dart';
import 'package:http/http.dart' as http;

class PetService {
  static const String baseUrl = 'http://10.121.138.123:8080/pet/';

  Future<List<Pet>> buscarPets() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((dynamic item) => Pet.fromJson(item)).toList();
    } else {
      throw Exception('Falha ao carregar pet');
    }
  }
// Future<void> criarPet(Pet pet) async {
// final response = await http.post(
// Uri.parse(baseUrl),
//headers: <String, String>{'Content-Type':'application/json; charset= UFT-8'},
//body: jsonEncode(pet.toJson()),
//    );
//  if (response.statusCode != 201){
//  throw Exception('Falha ao criar pet ');

//}
//}

//  Future<void> atualizarPet(Pet pet) async {
//   final response = await http.put(
//   Uri.parse('$baseUrl${pet.id}'),
// headers: <String, String>{'Content-Type':'application/json; charset= UFT-8'},
//      body: jsonEncode(pet.toJson()),
//  );
// if (response.statusCode != 200){
// throw Exception('Falha ao atualizar pet ');

//}
//}
//Future<void> deletarPet(int id) async {
//final response = await http.delete(Uri.parse('$baseUrl$id'));
//if (response.statusCode == 204){
//print('Pet deletado com sucesso');
//} else {
//print('Erro ao deletar pet: ${response.statusCode} ${response.body}');
//throw Exception('Falha ao deletar pet');
//}
//}
}
