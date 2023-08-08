import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../models/user_model.dart';
import '../../viewmodels/auth_viewmodel.dart';
import '../../viewmodels/global_ui_viewmodel.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  File? _selectedImage;
  late UserModel _user;

  void logout() async {
    _ui.loadState(true);
    try {
      await _auth.logout().then((value) {
        Navigator.of(context).pushReplacementNamed('/login');
      }).catchError((e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message.toString())),
        );
      });
    } catch (err) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(err.toString())),
      );
    }
    _ui.loadState(false);
  }

  void _selectImage() async {
    final pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  late GlobalUIViewModel _ui;
  late AuthViewModel _auth;

  @override
  void initState() {
    _ui = Provider.of<GlobalUIViewModel>(context, listen: false);
    _auth = Provider.of<AuthViewModel>(context, listen: false);

    // Initialize _user with the current logged-in user from AuthViewModel
    _user = _auth.loggedInUser!;

    super.initState();
  }

  Future<void> _uploadImageToFirebase() async {
    if (_selectedImage != null) {
      try {
        final ref = FirebaseStorage.instance.ref().child('your_image_folder/${_user.userId}.jpg');
        final uploadTask = ref.putFile(_selectedImage!);
        await uploadTask.whenComplete(() async {
          final imageUrl = await ref.getDownloadURL();
          final userRef = FirebaseFirestore.instance.collection('your_users_collection').doc(_user.userId);
          await userRef.update({'imageUrl': imageUrl});

          // Update the UserModel with the new image URL
          setState(() {
            _user.imageUrl = imageUrl;
          });

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Image uploaded successfully!')));
        });
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to upload image. Please try again.')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 10),
          GestureDetector(
            onTap: _selectImage,
            child: CircleAvatar(
              radius: 50,
              backgroundImage: _selectedImage != null ? FileImage(_selectedImage!) : null,
              child: _selectedImage == null
                  ? Icon(Icons.add_a_photo, color: Colors.white) // Placeholder icon when no image is selected
                  : null, // Remove this line if you don't want the icon overlay
            ),
          ),
          SizedBox(height: 10),
          Container(
            child: Text(_auth.loggedInUser!.email.toString()),
          ),
          SizedBox(height: 10),
          makeSettings(
            icon: Icon(Icons.sell),
            title: "My Products",
            subtitle: "Get a listing of my products",
            onTap: () {
              Navigator.of(context).pushNamed("/my-products");
            },
          ),
          makeSettings(
            icon: Icon(Icons.sell),
            title: "My Products",
            subtitle: "Get a listing of my products",
            onTap: () {
              Navigator.of(context).pushNamed("/my-products");
            },
          ),
          makeSettings(
            icon: Icon(Icons.logout),
            title: "Logout",
            subtitle: "Logout from this application",
            onTap: () {
              logout();
            },
          ),
          makeSettings(
            icon: Icon(Icons.android),
            title: "Version",
            subtitle: "0.0.1",
            onTap: () {},
          ),
        ],
      ),
    );
  }

  makeSettings({required Icon icon, required String title, required String subtitle, Function()? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        child: Card(
          elevation: 4,
          color: Colors.white,
          child: ListTile(
            tileColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.5),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
            leading: icon,
            title: Text(
              title,
            ),
            subtitle: Text(
              subtitle,
            ),
          ),
        ),
      ),
    );
  }
}
