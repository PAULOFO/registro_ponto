import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:registro_ponto/dao/registro_ponto_dao.dart';
import 'package:registro_ponto/models/registro_ponto.dart';
import 'package:registro_ponto/pages/listar_historico_ponto_page.dart';
import 'package:registro_ponto/pages/relogio.dart';
import 'package:registro_ponto/services/localizacao.dart';
import 'package:registro_ponto/services/mensagem.dart';

class RegistroPontoPage extends StatefulWidget {
  _RegistroPontoPageState createState() => _RegistroPontoPageState();
}

class _RegistroPontoPageState extends State<RegistroPontoPage> {
  final _dao = RegistroPontoDao();
  late final mensagem;

  @override
  Widget build(BuildContext context) {
    mensagem = Mensagem(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro de ponto remoto'),
      ),
      body: _criarBody(),
    );
  }

  Widget _criarBody() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Relogio(),
          TextButton(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
            ),
            child: Text('Registrar ponto'),
            onPressed: () async => salvarPonto(),
          ),
          TextButton(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
            ),
            child: Text('Verificar histórico'),
            onPressed: () {
              Navigator.pushNamed(context, ListarHistoricoPontoPage.routeName);
            },
          )
        ],
      ),
    );
  }

  void salvarPonto() async {
    LatLng latLng = await Localizacao(context).getLocalizacaoAtual();
    _dao
        .salvar(RegistroPonto(
            id: null,
            hora: DateTime.now(),
            latitude: latLng.latitude,
            longitude: latLng.longitude))
        .then((value) {
      mensagem.mostrarMensagem('Registro feito com sucesso');
    }).onError((error, stackTrace) {
      mensagem.mostrarMensagem('Erro ao registrar ponto: $error');
    });
  }
}
