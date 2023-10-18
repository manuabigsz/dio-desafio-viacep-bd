import 'package:desafio_consome_cep/model/viacep_model.dart';
import 'package:flutter/material.dart';
import '../model/back4app_model.dart';
import '../drawer/drawer.dart';
import '../repositories/back4app/cep_back4app_repository.dart';

class ConsultaCEP extends StatefulWidget {
  const ConsultaCEP({super.key});

  @override
  State<ConsultaCEP> createState() => _ConsultaCEPState();
}

class _ConsultaCEPState extends State<ConsultaCEP> {
  var cepController = TextEditingController(text: "");
  bool loading = false;
  var viacepModel = ViaCepModel();
  var viaCepRepository = ViaCepRepository();
  List<ViaCepModel> cepsList = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 200,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF0077FF),
                  Color(0xFF0033CC),
                ],
                stops: [0, 1],
              ),
            ),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 30, bottom: 30),
                child: Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Consulta de CEP',
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Digite o CEP que deseja consultar:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: cepController,
                maxLength: 8,
                keyboardType: TextInputType.number,
                onChanged: (String value) async {
                  var cep = value.replaceAll(RegExp(r'[^0-9]'), '');
                  if (cep.length == 8) {
                    setState(() {
                      loading = true;
                    });
                    viacepModel =
                        await viaCepRepository.getCEP(cepController.text);
                    setState(() {
                      loading = false;
                    });
                  }
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.black12,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              if (viacepModel.logradouro != null)
                Text(viacepModel.logradouro ?? "",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              if (viacepModel.logradouro != null)
                Text(
                    '${viacepModel.localidade ?? ""} - ${viacepModel.uf ?? ""}',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              if (loading) CircularProgressIndicator(),
              if (viacepModel.logradouro != null)
                SizedBox(
                  height: 20,
                ),
              if (viacepModel.logradouro != null)
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      cepsList.add(viacepModel);
                    });
                    saveback4app(viacepModel);
                  },
                  child: Text('Salvar'),
                  style: ElevatedButton.styleFrom(
                    elevation: 10.0,
                    backgroundColor: Color(0xFF0033CC),
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 20.0,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              SizedBox(
                height: 20,
              ),
              if (cepsList.isNotEmpty) buildCEPDataTable(),
            ],
          ),
        ),
        drawer: DrawerPage(),
      ),
    );
  }

  Widget buildCEPDataTable() {
    return DataTable(
      columns: [
        DataColumn(label: Text('CEP')),
        DataColumn(label: Text('Localidade')),
        DataColumn(label: Text('UF')),
        DataColumn(label: Text('Logradouro')),
        DataColumn(label: Text('Bairro')),
      ],
      rows: cepsList
          .map(
            (cep) => DataRow(
              cells: [
                DataCell(Text(cep.cep ?? '')),
                DataCell(Text(cep.localidade ?? '')),
                DataCell(Text(cep.uf ?? '')),
                DataCell(Text(cep.logradouro ?? '')),
                DataCell(Text(cep.bairro ?? '')),
              ],
            ),
          )
          .toList(),
    );
  }

  void saveback4app(ViaCepModel viacepModel) async {
    try {
      if (viacepModel.cep != null &&
          viacepModel.localidade != null &&
          viacepModel.uf != null) {
        ViaCep viaCep = ViaCep.create(
          viacepModel.cep,
          viacepModel.localidade,
          viacepModel.uf,
          viacepModel.logradouro,
          viacepModel.bairro,
        );
        await viaCepRepository.criar(viaCep);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('CEP salvo com sucesso!'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Dados de CEP inválidos, não foi possível salvar.'),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao salvar o CEP: $e'),
        ),
      );
      print('Erro ao salvar o CEP: $e');
    }
  }
}
