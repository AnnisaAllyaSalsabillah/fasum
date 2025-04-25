import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  File? _image;
  String? _base64String;
  final TextEditingController _descriptionController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  bool _isUploading = false;
  double? _latitude;
  double? _longitude;


  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if(pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    } await _compressAndEndcodeImage();
  }

  Future<void> _compressAndEndcodeImage() async {
    if(_image == null) return;
    final compressedImage = await FlutterImageCompress.compressWithFile(
      _image!.path,
      quality: 50,
    );
    if (compressedImage == null) return;
    setState(() {
      _base64String = base64Encode(compressedImage);
    });
  }

  Future<void> _getLocation() async{
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if(!serviceEnabled){
      throw Exception("Location services are disabled.");
    }

    permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied){
      permission = await Geolocator.requestPermission();
      if(permission == LocationPermission.deniedForever ||
         permission == LocationPermission.denied){
        throw Exception("Location permissions are denied.");
      }
    }

    try{
      final position = await Geolocator.getCurrentPosition(
        locationSettings: LocationSettings(accuracy: LocationAccuracy.high),
      ).timeout(const Duration(seconds: 10));
      setState(() {
        _latitude = position.latitude;
        _longitude = position.longitude;
      });
    }catch(e){
      debugPrint('Failed to get location: $e');
      setState(() {
        _latitude = null;
        _longitude = null;
      });
    }
  }

  Future<void> _submitPost() async {
    if(_base64String == null || _descriptionController.text.isEmpty) return;
    setState(() => _isUploading = true);
    final now = DateTime.now().toIso8601String();
    final uid = FirebaseAuth.instance.currentUser!.uid;
    if(uid == null) {
      setState(() => _isUploading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User not found')),
      );
      return;
    }

    try {
      await _getLocation();

      final userDoc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
      final fullName = userDoc.data()?['fullName'] ?? 'Anonymus';
      await FirebaseFirestore.instance.collection('posts').add({
        'image': _base64String,
        'description': _descriptionController.text,
        'createdAt': now,
        'userId': uid,
        'fullName': fullName,
        'latitude': _latitude,
        'longitude': _longitude,
      });
      if(!mounted) return;
      Navigator.pop(context);
    }catch(e){
      
    }
  }

  void _showImageSourceDialog(){
    showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        title: Text("Choose Image Source"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _pickImage(ImageSource.camera);
            },
            child: Text("Camera"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _pickImage(ImageSource.camera);
            },
            child: Text("Gallery"),
          )
        ],
      )
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Post')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            _image != null 
            ? Image.file(_image!,
             height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ) 
            : GestureDetector(
              onTap: _showImageSourceDialog,
              child: Container(
                height: 200,
                color: Colors.grey[300],
                child: Icon(Icons.add_a_photo, size: 50,)),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              textCapitalization: TextCapitalization.sentences,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'add a brief description...',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            _isUploading ? CircularProgressIndicator() :ElevatedButton.icon(
              onPressed: _submitPost,
              icon: Icon(Icons.upload),
              label: Text('Post'),
            ),
            Icon(Icons.upload),
          ],
        ),
      ),
    );
  }
}