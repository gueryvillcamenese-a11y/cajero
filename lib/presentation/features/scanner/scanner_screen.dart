import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({Key? key}) : super(key: key);

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  bool _hasPermission = false;
  bool _isLoading = true;
  // Se recomienda inicializar el controlador aquí
  final MobileScannerController cameraController = MobileScannerController();

  @override
  void initState() {
    super.initState();
    _checkPermission();
  }

  Future<void> _checkPermission() async {
    final status = await Permission.camera.request();
    if (mounted) {
      setState(() {
        _hasPermission = status.isGranted;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (!_hasPermission) {
      return Scaffold(
        appBar: AppBar(title: const Text('Escanear Producto')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.camera_alt_outlined, size: 64, color: Colors.grey),
              const SizedBox(height: 16),
              const Text('Se necesita permiso de cámara'),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _checkPermission,
                child: const Text('Otorgar Permiso'),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Escanear Producto',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          // Botón del Flash (Antorcha) corregido
          IconButton(
            color: Colors.white,
            iconSize: 32.0,
            icon: ValueListenableBuilder(
              valueListenable: cameraController,
              builder: (context, state, child) {
                // En la v5.x se usa state.torchState directamente
                switch (state.torchState) {
                  case TorchState.off:
                    return const Icon(Icons.flash_off, color: Colors.grey);
                  case TorchState.on:
                    return const Icon(Icons.flash_on, color: Colors.yellow);
                  default:
                    return const Icon(Icons.flash_off, color: Colors.grey);
                }
              },
            ),
            onPressed: () => cameraController.toggleTorch(),
          ),
          // Botón de Girar Cámara corregido
          IconButton(
            color: Colors.white,
            iconSize: 32.0,
            icon: const Icon(Icons.cameraswitch),
            onPressed: () => cameraController.switchCamera(),
          ),
        ],
      ),
      body: Stack(
        children: [
          MobileScanner(
            controller: cameraController,
            onDetect: (capture) {
              final List<Barcode> barcodes = capture.barcodes;
              if (barcodes.isNotEmpty) {
                final String? code = barcodes.first.rawValue;
                if (code != null) {
                  debugPrint('Barcode found! $code');
                  // Cerramos la pantalla y devolvemos el código
                  Navigator.pop(context, code);
                }
              }
            },
          ),
          // Recuadro amarillo de enfoque
          Center(
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFECAB0F), width: 3),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Stack(
                children: [
                  // Animación de línea de escaneo
                  TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0.0, end: 1.0),
                    duration: const Duration(seconds: 2),
                    builder: (context, value, child) {
                      return Positioned(
                        top: value * 230,
                        left: 10,
                        right: 10,
                        child: Container(
                          height: 2,
                          color: const Color(0xFFECAB0F).withAlpha(150),
                        ),
                      );
                    },
                    onEnd: () {
                      // Esto hace que la animación sea infinita (opcional)
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
          ),
          // Texto de guía
          const Positioned(
            bottom: 80,
            left: 0,
            right: 0,
            child: Text(
              'Encuadra el código de barras o QR\ndentro del recuadro amarillo',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                shadows: [Shadow(blurRadius: 10, color: Colors.black)],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }
}
