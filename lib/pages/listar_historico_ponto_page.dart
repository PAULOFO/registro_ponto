import 'package:flutter/material.dart';
import 'package:registro_ponto/dao/registro_ponto_dao.dart';
import 'package:registro_ponto/models/registro_ponto.dart';
import 'package:maps_launcher/maps_launcher.dart';

class ListarHistoricoPontoPage extends StatefulWidget {
  static const String routeName = '/listar-historico-ponto';
  @override
  _ListarHistoricoPontoPage createState() => _ListarHistoricoPontoPage();
}

class _ListarHistoricoPontoPage extends State<ListarHistoricoPontoPage> {
  final registrosPonto = <RegistroPonto>[];
  final _dao = RegistroPontoDao();

  @override
  void initState() {
    super.initState();
    _bucarRegistros();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista dos pontos cadastrados'),
      ),
      body: _criarBody(),
    );
  }

  _criarBody() {
    if (registrosPonto.isEmpty) return _getWidgetListaVazia();

    return ListView.separated(
      itemBuilder: (BuildContext context, int index) {
        final registroPonto = registrosPonto[index];
        return ListTile(
            title: Text('Hora do registro: ${registroPonto.horaFormatada}'),
            subtitle: Column(
              children: [
                TextButton(
                    onPressed: () {
                      MapsLauncher.launchCoordinates(
                          registroPonto.latitude, registroPonto.longitude);
                    },
                    child: Text('Visualizar no mapa'))
              ],
            ));
      },
      separatorBuilder: (BuildContext context, int index) => Divider(),
      itemCount: registrosPonto.length,
    );
  }

  _getWidgetListaVazia() {
    return const Center(
      child: Text(
        'Nenhum registro de ponto cadastrado',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  _bucarRegistros() async {
    final listaRegistrosPonto = await _dao.listar();
    setState(() {
      registrosPonto.clear();
      if (listaRegistrosPonto.isNotEmpty) {
        registrosPonto.addAll(listaRegistrosPonto);
      }
    });
  }
}
