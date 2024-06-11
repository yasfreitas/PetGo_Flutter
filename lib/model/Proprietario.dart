class Proprietario{
  final int? id;
  final String nome;
  final String cpf;
  final String rg;
  final String cidade;
  final String rua;
  final String numero;
  final String telefone1;
  final String telefone2;

  Proprietario({this.id, required this.nome, required this.cpf, required this.rg, required this.cidade,
    required this.rua, required this.numero, required this.telefone1, required this.telefone2});

  factory Proprietario.fromJson(Map<String, dynamic> json){
    return Proprietario(
      id: json['id'],
      nome: json['nome'],
      cpf: json['cpf'],
      rg: json['rg'],
      cidade: json['cidade'],
      rua: json['rua'],
      numero: json['numero'],
      telefone1: json['telefone1'],
      telefone2: json['telefone2'],
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'id': id,
      'nome': nome,
      'cpf': cpf,
      'rg': rg,
      'cidade': cidade,
      'rua': rua,
      'numero': numero,
      'telefone1': telefone1,
      'telefone2': telefone2,
    };
  }
}