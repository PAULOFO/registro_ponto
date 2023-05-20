import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:registro_ponto/services/mensagem.dart';

class Localizacao {
  final BuildContext context;
  late final Mensagem mensagem;

  Localizacao(this.context) {
    mensagem = Mensagem(context);
  }

  Future<LatLng> getLocalizacaoAtual() async {
    if (!await validarPermissoes()) return LatLng(0, 0);
    final position = await Geolocator.getCurrentPosition();
    return LatLng(position.latitude, position.longitude);
  }

  Future<bool> validarPermissoes() async {
    LocationPermission permissao = await Geolocator.checkPermission();
    if (permissao == LocationPermission.denied) {
      permissao = await Geolocator.requestPermission();
      if (permissao == LocationPermission.denied) {
        mensagem.mostrarMensagem('Não será possível utilizar o recurso '
            'por falta de permissão');
      }
    }
    if (permissao == LocationPermission.deniedForever) {
      await mensagem.mostrarDialogMensagem(
          'Para utilizar esse recurso, você deverá acessar '
          'as configurações do app para permitir a utilização do serviço de localização',
          TextButton(
              onPressed: () => Navigator.of(context).pop(), child: Text('OK')));
      Geolocator.openAppSettings();
      return false;
    }
    return true;
  }
}
