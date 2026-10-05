import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../models/producto.dart';
import '../services/api_service.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  final MobileScannerController controller = MobileScannerController();

  Producto? producto;
  bool cargando = false;
  String? error;

  bool procesandoCodigo = false;

  Future<void> detectarCodigo(BarcodeCapture captura) async {
    if (procesandoCodigo) return;

    final String? codigo = captura.barcodes.firstOrNull?.rawValue;

    if (codigo == null || codigo.isEmpty) {
      return;
    }

    setState(() {
      procesandoCodigo = true;
      cargando = true;
      error = null;
    });

    await controller.stop();

    try {
      final Producto resultado =
          await ApiService.buscarProducto(codigo);

      if (!mounted) return;

      setState(() {
        producto = resultado;
        cargando = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        cargando = false;
        error = e.toString();
      });
    } finally {
      procesandoCodigo = false;
    }
  }

  Future<void> volverEscanear() async {
    setState(() {
      producto = null;
      error = null;
      cargando = false;
      procesandoCodigo = false;
    });

    await controller.start();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Escanear producto'),
        centerTitle: true,
      ),

      body: Column(
        children: [
          // Cámara
          Expanded(
            flex: 3,
            child: Stack(
              children: [
                MobileScanner(
                  controller: controller,
                  onDetect: detectarCodigo,
                ),

                Center(
                  child: Container(
                    width: 260,
                    height: 160,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                if (cargando)
                  Container(
                    color: Colors.black54,
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // Información del producto
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: _mostrarResultado(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _mostrarResultado() {
    if (error != null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            color: Colors.red,
            size: 50,
          ),

          const SizedBox(height: 10),

          Text(
            error!,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.red,
            ),
          ),

          const SizedBox(height: 20),

          ElevatedButton.icon(
            onPressed: volverEscanear,
            icon: const Icon(Icons.qr_code_scanner),
            label: const Text('Escanear nuevamente'),
          ),
        ],
      );
    }

    if (producto == null) {
      return const Center(
        child: Text(
          'Apunta la cámara hacia el código de barras',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          producto!.nombre,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 10),

        Text(
          'Código: ${producto!.codigoBarras}',
        ),

        const SizedBox(height: 6),

        Text(
          'Stock: ${producto!.stock}',
        ),

        const SizedBox(height: 6),

        Text(
          'Precio: \$${producto!.precioVenta.toStringAsFixed(2)}',
        ),

        if (producto!.categoria != null) ...[
          const SizedBox(height: 6),
          Text(
            'Categoría: ${producto!.categoria}',
          ),
        ],

        const Spacer(),

        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: volverEscanear,
            icon: const Icon(Icons.qr_code_scanner),
            label: const Text('Escanear otro producto'),
          ),
        ),
      ],
    );
  }
}