class Pet {
  final int? id;
  final String cor;
  final String documento;
  final String nascimento;
  final String nome;
  final String raca;

  Pet ({this.id, required this.cor, required this.documento, required this.nascimento,
    required this.nome
    , required this.raca});

  factory Pet.fromJson(Map<String, dynamic> json){
    return Pet(
      id: json ['id'],
      cor: json ['cor'],
      documento: json ['documento'],
      nascimento: json ['nascimento'],
      nome: json ['nome'],
      raca: json ['raca'],
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'id': id,
      'cor': cor,
      'documento': documento,
      'nascimento': nascimento,
      'nome': nome,
      'raca': raca
    };
  }

}