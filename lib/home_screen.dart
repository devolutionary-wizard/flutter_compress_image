import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ImagePicker _picker = ImagePicker();
  File? _imageFile;
  File? _compressedFile;

  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = File(image!.path);
    });
  }

  Future<void> compressImage() async {
    var res = await FlutterImageCompress.compressAndGetFile(
        _imageFile!.absolute.path, '${_imageFile!.path}compressed.jpg',
        quality: 20);
    setState(() {
      _compressedFile = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Image Compressing'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_imageFile != null)
              Image.file(
                _imageFile!,
                height: 200,
                width: 200,
              ),
            if (_imageFile != null) Text('Before Compress ${_imageFile!.lengthSync()/1000} bytes'),
            if (_compressedFile != null)
              Image.file(
                _compressedFile!,
                height: 200,
                width: 200,
              ),
            if (_compressedFile != null)
              Text('After Compress ${_compressedFile!.lengthSync()/1000} bytes'),
            ElevatedButton(
                onPressed: () async {
                  await pickImage();
                },
                child: const Text('Select Image')),
            if (_imageFile != null)
              ElevatedButton(
                  onPressed: () async {
                    await compressImage();
                  },
                  child: const Text('Compress Image'))
          ],
        ),
      ),
    );
  }
}
