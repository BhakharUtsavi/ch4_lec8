import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class Thirdpage extends StatefulWidget {
  const Thirdpage({super.key});

  @override
  State<Thirdpage> createState() => _ThirdpageState();
}

class _ThirdpageState extends State<Thirdpage> {

  File? _imageFile;
  String? _savedImagePath;

  Future<void> _selectImage() async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        setState(() {
          _imageFile = File(pickedFile.path);
        });
      } else {
        _showSnackBar("No image selected.");
      }
    } catch (e) {
      _showSnackBar("Error selecting image: ${e.toString()}");
    }
  }

  Future<void> _saveImage() async {
    try {
      if (_imageFile == null) {
        _showSnackBar("No image to save.");
        return;
      }

      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/saved_image_${DateTime.now().millisecondsSinceEpoch}.png';
      final newFile = await _imageFile!.copy(filePath);

      setState(() {
        _savedImagePath = newFile.path;
      });

      _showSnackBar("Image saved to $filePath");
    } catch (e) {
      _showSnackBar("Error saving image: ${e.toString()}");
    }
  }

  Future<void> _shareImage() async {
    try {
      if (_savedImagePath == null) {
        _showSnackBar("No image saved to share.");
        return;
      }

      await Share.shareXFiles([XFile(_savedImagePath!)]);
      _showSnackBar("Image shared successfully!");
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
      appBar: AppBar(title: const Text('Save and Share Image')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: _selectImage,
              child: const Text('Select Image'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveImage,
              child: const Text('Save Image'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _shareImage,
              child: const Text('Share Image'),
            ),
          ],
        ),
      ),
    );
  }
}
