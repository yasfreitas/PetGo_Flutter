class Consulta{
  final int? id;
  final String data;
  final String descricao;
  final String hora;
  final String id_pet;
  final String id_veterinario;

  Consulta({this.id, required this.data, required this.descricao, required this.hora,
    required this.id_pet, required this.id_veterinario});

  factory Consulta.fromJson(Map<String, dynamic> json){
    return Consulta(
        id: json['id'],
        data: json['data'],
        descricao: json['descricao'],
        hora: json['hora'],
        id_pet: json['id_pet'],
        id_veterinario: json['id_veterinario']
    );
  }
  Map<String, dynamic> toJson(){
    return{
      'id': id,
      'data': data,
      'descricao': descricao,
      'hora': hora,
      'id_pet': id_pet,
      'id_veterinario': id_veterinario
    };
  }
}