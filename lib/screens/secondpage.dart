import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {

  File? _imageFile;

  Future<void> _shareText(String text) async {
    try {
      await Share.share(text);
      _showSnackBar("Text shared successfully!");
    } catch (e) {
      _showSnackBar("Error sharing text: ${e.toString()}");
    }
  }

  Future<void> _shareImage() async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        setState(() {
          _imageFile = File(pickedFile.path);
        });

        if (_imageFile != null) {
          // Use XFile from image_picker package for shareXFiles
          await Share.shareXFiles([XFile(_imageFile!.path)]);
          _showSnackBar("Image shared successfully!");
        } else {
          _showSnackBar("Failed to load image.");
        }
      } else {
        _showSnackBar("No image selected.");
      }
    } catch (e) {
      _showSnackBar("Error sharing image: ${e.toString()}");
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
      appBar: AppBar(title: Text('Share Content')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => _shareText("This is a sample text to share!"),
              child: Text('Share Text'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _shareImage,
              child: Text('Share Image'),
            ),
          ],
        ),
      ),
    );
  }
}
