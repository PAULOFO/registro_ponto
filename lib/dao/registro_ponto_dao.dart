import 'package:registro_ponto/models/registro_ponto.dart';
import 'package:sqflite/sqflite.dart';

import '../database/database_provider.dart';

class RegistroPontoDao {
  final dbProvider = DatabaseProvider.instance;

  Future<bool> salvar(RegistroPonto registroPonto) async {
    final database = await dbProvider.database;
    final valores = registroPonto.toMap();
    if (registroPonto.id == null || registroPonto.id == 0) {
      try {
        // Alterado id para null pois se deixar como 0 sempre faz o insert com o valor 0 ao invés de incrementar
        valores.update(RegistroPonto.CAMPO_ID, (value) => null);
        registroPonto.id = await database.insert(
          RegistroPonto.NOME_TABLE,
          valores,
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      } catch (e) {
        print(e);
      }

      return true;
    } else {
      final registrosAtualizados = await database.update(
        RegistroPonto.NOME_TABLE,
        valores,
        where: '${RegistroPonto.CAMPO_ID} = ?',
        whereArgs: [registroPonto.id],
      );
      return registrosAtualizados > 0;
    }
  }

  Future<List<RegistroPonto>> listar() async {
    final database = await dbProvider.database;
    final resultado = await database.query(
      RegistroPonto.NOME_TABLE,
      columns: [
        RegistroPonto.CAMPO_ID,
        RegistroPonto.CAMPO_HORA,
        RegistroPonto.CAMPO_LATITUDE,
        RegistroPonto.CAMPO_LONGITUDE,
      ],
      orderBy: '${RegistroPonto.CAMPO_ID} DESC',
    );
    return resultado.map((m) => RegistroPonto.fromMap(m)).toList();
  }
}
