import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/producto.dart';

class ApiService {
  // URL de producción en Hostinger
  static const String baseUrl =
      'https://victorypoint.justmarino.com';

  static Future<Producto> buscarProducto(String codigoBarras) async {
    final url = Uri.parse('$baseUrl/api/escaneo.php');

    try {
      final respuesta = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'codigo_barras': codigoBarras,
        }),
      );

      print('STATUS: ${respuesta.statusCode}');
      print('RESPUESTA: ${respuesta.body}');

      final datos = jsonDecode(respuesta.body);

      if (respuesta.statusCode == 200 && datos['ok'] == true) {
        return Producto.fromJson(datos['producto']);
      }

      throw Exception(
        datos['mensaje'] ?? 'No se pudo encontrar el producto.',
      );
    } catch (e) {
      throw Exception(
        'Error al conectar con SEYER-Control: $e',
      );
    }
  }
}