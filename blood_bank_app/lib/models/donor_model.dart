class Donor {
  final String nome;
  final String cpf;
  final String rg;
  final String dataNasc;
  final String sexo;
  final String mae;
  final String pai;
  final String email;
  final String cep;
  final String endereco;
  final int numero;
  final String bairro;
  final String cidade;
  final String estado;
  final String? telefoneFixo;
  final String celular;
  final double altura;
  final double peso;
  final String tipoSanguineo;

  Donor({
    required this.nome,
    required this.cpf,
    required this.rg,
    required this.dataNasc,
    required this.sexo,
    required this.mae,
    required this.pai,
    required this.email,
    required this.cep,
    required this.endereco,
    required this.numero,
    required this.bairro,
    required this.cidade,
    required this.estado,
    this.telefoneFixo,
    required this.celular,
    required this.altura,
    required this.peso,
    required this.tipoSanguineo,
  });

  factory Donor.fromJson(Map<String, dynamic> json) {
    return Donor(
      nome: json['nome'],
      cpf: json['cpf'],
      rg: json['rg'],
      dataNasc: json['data_nasc'],
      sexo: json['sexo'],
      mae: json['mae'],
      pai: json['pai'],
      email: json['email'],
      cep: json['cep'],
      endereco: json['endereco'],
      numero: json['numero'],
      bairro: json['bairro'],
      cidade: json['cidade'],
      estado: json['estado'],
      telefoneFixo: json['telefone_fixo'],
      celular: json['celular'],
      altura: json['altura'],
      peso: json['peso'],
      tipoSanguineo: json['tipo_sanguineo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'cpf': cpf,
      'rg': rg,
      'data_nasc': dataNasc,
      'sexo': sexo,
      'mae': mae,
      'pai': pai,
      'email': email,
      'cep': cep,
      'endereco': endereco,
      'numero': numero,
      'bairro': bairro,
      'cidade': cidade,
      'estado': estado,
      'telefone_fixo': telefoneFixo,
      'celular': celular,
      'altura': altura,
      'peso': peso,
      'tipo_sanguineo': tipoSanguineo,
    };
  }
}
