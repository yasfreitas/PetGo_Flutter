class Veterinario {
  final int? id;
  final String cidade;
  final String cpf;
  final String crmv;
  final String nome;
  final String numero;
  final String rua;
  final String telefone1;
  final String telefone2;

  Veterinario({this.id, required this.cidade, required this.cpf, required this.crmv, required this.nome,
    required this.numero, required this.rua, required this.telefone1, required this.telefone2});

  factory Veterinario.fromJson(Map<String, dynamic> json) {
    return Veterinario(
      id: json['id'],
      cidade: json['cidade'],
      cpf: json['cpf'],
      crmv: json['crmv'],
      nome: json['nome'],
      numero: json['numero'],
      rua: json['rua'],
      telefone1: json['telefone1'],
      telefone2: json['telefone2'],

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cidade': cidade,
      'cpf': cpf,
      'crmv': crmv,
      'nome': nome,
      'numero': numero,
      'rua': rua,
      'telefone1': telefone1,
      'telefone2': telefone2,
    };
  }
}