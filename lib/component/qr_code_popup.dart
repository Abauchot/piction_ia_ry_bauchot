import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';

class QrCodeScannerPopup extends StatefulWidget {
  const QrCodeScannerPopup({Key? key}) : super(key: key);

  @override
  _QrCodeScannerPopupState createState() => _QrCodeScannerPopupState();
}

class _QrCodeScannerPopupState extends State<QrCodeScannerPopup> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;

  @override
  void initState() {
    super.initState();
    _requestCameraPermission();
  }

  Future<void> _requestCameraPermission() async {
    var status = await Permission.camera.status;
    if (status.isDenied || status.isRestricted || status.isPermanentlyDenied) {
      status = await Permission.camera.request();
    }
    if (status.isGranted) {
      setState(() {}); // Redraw to initialize QRView if permission is granted
    } else {
      Navigator.of(context).pop(); // Ferme le scanner si la permission n'est pas accordée
    }
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller?.pauseCamera();
    }
    controller?.resumeCamera();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void _onQRViewCreated(QRViewController qrController) {
    controller = qrController;
    qrController.scannedDataStream.listen((scanData) {
     // Navigator.of(context).pop(scanData.code); // Retourne les données scannées
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scanner le QR Code'),
        backgroundColor: Colors.purple,
      ),
      body: FutureBuilder(
        future: Permission.camera.isGranted,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data == true) {
              return Center(
                child: QRView(
                  key: qrKey,
                  onQRViewCreated: _onQRViewCreated,
                  overlay: QrScannerOverlayShape(
                    borderColor: Colors.purple,
                    borderRadius: 10,
                    borderLength: 30,
                    borderWidth: 10,
                    cutOutSize: MediaQuery.of(context).size.width * 0.8,
                  ),
                ),
              );
            } else {
              return const Center(child: Text('Permission de la caméra refusée'));
            }
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
