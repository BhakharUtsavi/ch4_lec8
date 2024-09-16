import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {

  final GlobalKey _repaintBoundaryKey = GlobalKey();

  Future<void> _captureAndSaveScreenshot() async {
    try {
      RenderRepaintBoundary boundary = _repaintBoundaryKey.currentContext?.findRenderObject() as RenderRepaintBoundary;
      if (boundary == null) {
        _showSnackBar("Failed to capture screenshot.");
        return;
      }

      ui.Image image = await boundary.toImage();
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      if (byteData == null) {
        _showSnackBar("Failed to convert image.");
        return;
      }

      final Uint8List pngBytes = byteData.buffer.asUint8List();
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/screenshot_${DateTime.now().millisecondsSinceEpoch}.png';
      final file = File(filePath);
      await file.writeAsBytes(pngBytes);

      _showSnackBar("Screenshot saved to $filePath");
    } catch (e) {
      _showSnackBar("Error saving screenshot: ${e.toString()}");
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Save Screenshot')),
      body: Center(
        child: RepaintBoundary(
          key: _repaintBoundaryKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                color: Colors.blue,
                width: 200,
                height: 200,
                child: Center(child: Text('Capture Me!', style: TextStyle(color: Colors.white, fontSize: 20))),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _captureAndSaveScreenshot,
                child: Text('Save Screenshot'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
