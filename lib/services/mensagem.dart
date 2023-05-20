import 'package:flutter/material.dart';

class Mensagem {
  final BuildContext context;

  Mensagem(this.context);

  void mostrarMensagem(String mensagem) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(mensagem)));
  }

  Future<void> mostrarDialogMensagem(String mensagem, Widget actions) async {
    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Atenção'),
        content: Text(mensagem),
        actions: [actions],
      ),
    );
  }
}
