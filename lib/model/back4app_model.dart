class CepsBack4AppModel {
  List<ViaCep> results = [];

  CepsBack4AppModel(this.results);

  CepsBack4AppModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <ViaCep>[];
      json['results'].forEach((v) {
        results.add(ViaCep.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['results'] = results.map((v) => v.toJson()).toList();
    return data;
  }
}

class ViaCep {
  String? objectId;
  String? cep;
  String? localidade;
  String? uf;
  String? createdAt;
  String? updatedAt;
  String? logradouro;
  String? bairro;

  ViaCep({
    this.objectId,
    this.cep,
    this.localidade,
    this.uf,
    this.createdAt,
    this.updatedAt,
    this.logradouro,
    this.bairro,
  });

  ViaCep.create(
      this.cep, this.localidade, this.uf, this.logradouro, this.bairro);

  ViaCep.fromJson(Map<String, dynamic> json) {
    objectId = json['objectId'];
    cep = json['cep'];
    localidade = json['localidade'] ?? "";
    uf = json['uf'] ?? "";
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    logradouro = json['logradouro'] ?? "";
    bairro = json['bairro'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['objectId'] = objectId;
    data['cep'] = cep;
    data['localidade'] = localidade;
    data['uf'] = uf;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['logradouro'] = logradouro;
    data['bairro'] = bairro;

    return data;
  }

  Map<String, dynamic> toJsonEndpoint() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cep'] = cep;
    data['localidade'] = localidade;
    data['uf'] = uf;
    data['logradouro'] = logradouro;
    data['bairro'] = bairro;

    return data;
  }
}
