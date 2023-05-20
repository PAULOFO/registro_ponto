import 'package:intl/intl.dart';

class RegistroPonto {

  static const NOME_TABLE = 'registro_ponto';

  static const CAMPO_ID = '_id';
  static const CAMPO_HORA = 'hora';
  static const CAMPO_LATITUDE = 'latitude';
  static const CAMPO_LONGITUDE = 'longitude';  

  int? id;
  DateTime? hora;
  double latitude;
  double longitude;
  

  RegistroPonto(
    {
      required this.id,  
      required this.hora, 
      required this.latitude,
      required this.longitude,
    }
  );

  String get horaFormatada {
    if (hora == null){
      return "";
    } 
    return DateFormat('dd/MM/yyyy HH:mm:ss').format(hora!);
  }

  Map<String, dynamic> toMap() => <String, dynamic>{
    CAMPO_ID: id,
    CAMPO_HORA: hora == null ? null : DateFormat("dd/MM/yyyy HH:mm:ss").format(hora!),
    CAMPO_LATITUDE: latitude,
    CAMPO_LONGITUDE: longitude,
  };

  factory RegistroPonto.fromMap(Map<String, dynamic> map) => RegistroPonto(
    id: map[CAMPO_ID] is int ? map[CAMPO_ID] : null,
    hora: map[CAMPO_HORA] == null ? null : DateFormat("dd/MM/yyyy HH:mm:ss").parse(map[CAMPO_HORA]),
    latitude: map[CAMPO_LATITUDE] is double ? map[CAMPO_LATITUDE] : 0,
    longitude: map[CAMPO_LONGITUDE] is double ? map[CAMPO_LONGITUDE] : 0,
  );
}