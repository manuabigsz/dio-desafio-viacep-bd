import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../model/back4app_model.dart';
import '../../model/viacep_model.dart';
import 'custom_dio.dart';

class ViaCepRepository {
  final _custonDio = Back4AppCustonDio();

  Future<ViaCepModel> getCEP(String cep) async {
    final response =
        await http.get(Uri.parse("https://viacep.com.br/ws/$cep/json/"));

    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      return ViaCepModel.fromJson(json);
    } else {
      throw Exception('Falha ao consultar CEP: ${response.statusCode}');
    }
  }

  Future<CepsBack4AppModel> getAllCEP() async {
    var url = "/cep";

    var result = await _custonDio.dio.get(url);
    return CepsBack4AppModel.fromJson(result.data);
  }

  Future<void> criar(ViaCep viacep) async {
    try {
      await _custonDio.dio.post("/cep", data: viacep.toJsonEndpoint());
    } catch (e) {
      throw e;
    }
  }

  Future<void> updateCEP(ViaCep viaCep) async {
    try {
      await _custonDio.dio.put("cep/${viaCep.objectId}", data: viaCep.toJson());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteCEP(String objectId) async {
    try {
      await _custonDio.dio.delete("cep/$objectId");
    } catch (e) {
      rethrow;
    }
  }
}
