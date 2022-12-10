import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:style_trace_back_frontend/common/AppIcon.dart';
import 'package:style_trace_back_frontend/common/TopBar.dart';

import '../widgets/layer3/custom_buttons/custom_painter_handler.dart';

class ImageScannerPage extends StatefulWidget {
  const ImageScannerPage({
    Key? key,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ImageScannerPageState createState() => _ImageScannerPageState();
}

class _ImageScannerPageState extends State<ImageScannerPage> {
  // XFile? _pickedFile;
  CroppedFile? _croppedFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: topBar(
          pageName: "Image Scanner",
          leadingIcon: AppIcon.topBarBack,
          actionIcon: AppIcon.searchIcon),
      body: Stack(
        children: [
          _body(),
          Positioned(
            bottom: MediaQuery.of(context).size.height / 8,
            left: 0,
            child: const LeftCurveBtn(),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height / 8,
            right: 0,
            child: const RightCurveBtn(),
          ),
        ],
      ),
    );
  }

  Widget _body() {
    if (_croppedFile != null) {
      return _imageCard();
    } else {
      return _uploaderCard();
    }
  }

  Widget _imageCard() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: kIsWeb ? 24.0 : 16.0),
            child: Card(
              elevation: 4.0,
              child: Padding(
                padding: const EdgeInsets.all(kIsWeb ? 24.0 : 16.0),
                child: _image(),
              ),
            ),
          ),
          const SizedBox(height: 24.0),
          _menu(),
        ],
      ),
    );
  }

  Widget _image() {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    if (_croppedFile != null) {
      final path = _croppedFile!.path;
      return ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 0.8 * screenWidth,
          maxHeight: 0.7 * screenHeight,
        ),
        child: kIsWeb ? Image.network(path) : Image.file(File(path)),
      );
      // } else if (_pickedFile != null) {
      //   final path = _pickedFile!.path;
      //   return ConstrainedBox(
      //     constraints: BoxConstraints(
      //       maxWidth: 0.8 * screenWidth,
      //       maxHeight: 0.7 * screenHeight,
      //     ),
      //     child: kIsWeb ? Image.network(path) : Image.file(File(path)),
      //   );
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget _menu() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        FloatingActionButton(
          onPressed: () {
            _clear();
          },
          backgroundColor: Colors.redAccent,
          tooltip: 'Delete',
          child: const Icon(Icons.delete),
        ),
        // if (_croppedFile == null)
        //   Padding(
        //     padding: const EdgeInsets.only(left: 32.0),
        //     child: FloatingActionButton(
        //       onPressed: () {
        //         _cropImage(); // entry: crop
        //       },
        //       backgroundColor: const Color(0xFFBC764A),
        //       tooltip: 'Crop',
        //       child: const Icon(Icons.crop),
        //     ),
        //   )
      ],
    );
  }

  Widget _uploaderCard() {
    return Center(
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: SizedBox(
          width: kIsWeb ? 380.0 : 320.0,
          height: 300.0,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  _pickImage();
                },
                child: const Text('Upload'),
              ),
              ElevatedButton(
                onPressed: () {
                  _takePhoto();
                },
                child: const Text('Take Photo'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _cropImage(XFile pickedFile) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: pickedFile.path,
      compressFormat: ImageCompressFormat.jpg,
      compressQuality: 100,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            hideBottomControls: true),
      ],
    );
    // TODO: send request to backend
    // File imageFile;
    // if (croppedFile != null) {
    //   if (kDebugMode) {
    //     _debugL(croppedFile.path);
    //   }
    //   imageFile = File(croppedFile.path);
    //   String baseUrl = "http://localhost:5000";
    //   var request = http.MultipartRequest('POST', Uri.parse(baseUrl))
    //     ..fields['imgId'] = 'RandomInteger'
    //     ..files.add(http.MultipartFile(
    //       'file',
    //       imageFile.readAsBytes().asStream(),
    //       imageFile.lengthSync(),
    //       filename: imageFile.path.split("/").last,
    //     ));
    //   _debugL(request.fields);
    //   _debugL(request.headers);
    //   _debugL(request.files);
    //   // var response = await request.send();
    //   _debugL("======= status code: =======");
    //   // _debugL(response.statusCode);
    // }

    if (croppedFile != null) {
      setState(() {
        _croppedFile = croppedFile;
      });
    }
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _cropImage(pickedFile);
    }
  }

  Future<void> _takePhoto() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      _cropImage(pickedFile);
    }
  }

  void _clear() {
    setState(() {
      // _pickedFile = null;
      _croppedFile = null;
    });
  }
}

void _debugL(Object o) {
  log("img_scanner.dart: - $o");
}
