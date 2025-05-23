import 'dart:io';

import 'package:chat_app/screens/chat.dart';
import 'package:chat_app/widget/user_input_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

final _firebase = FirebaseAuth.instance;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var isLogin = true;
  var _isAuthenting = false;
  final _form = GlobalKey<FormState>();
  var _enteredEmail = '';
  var _enteredPassword = '';
  var _enteredUserName = '';
  File? _selectedImage;

  void _submit() async {
    var isValid = _form.currentState!.validate();
    if (!isValid || _selectedImage == null && !isLogin) {
      return;
    }
    _form.currentState!.save();

    try {
      setState(() {
        _isAuthenting = true;
      });

      if (!isLogin) {
        final credentials = await _firebase.createUserWithEmailAndPassword(
          email: _enteredEmail,
          password: _enteredPassword,
        );
        final storageRef = await FirebaseStorage.instance.ref(
          'user_images/${credentials.user!.uid}.jpg',
        );

        await storageRef.putFile(_selectedImage!);
        final imageUrl = await storageRef.getDownloadURL();
        print(imageUrl);
        await FirebaseFirestore.instance
            .collection('users')
            .doc(credentials.user!.uid)
            .set({
              'username': _enteredUserName,
              'email': _enteredEmail,
              'image_url': imageUrl,
            });
      } else {
        final credentials = await _firebase.signInWithEmailAndPassword(
          email: _enteredEmail,
          password: _enteredPassword,
        );
      }
    } on FirebaseAuthException catch (err) {
      setState(() {
        _isAuthenting = false;
      });
      if (err.code == 'weak-password') {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Password is too weak')));
      } else if (err.code == 'email-already-in-use') {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Email already in use')));
      } else if (err.code == 'user-not-found') {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('User not found')));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('An error occurred, please try again later'),
          ),
        );
      }
    }
    if (_isAuthenting) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ChatScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(title: const Text('Welcome to FlutterChat!')),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Theme.of(context).colorScheme.secondary,
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).colorScheme.shadow,
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Image.asset(
                  'assets/images/chat.png',
                  width: 100,
                  height: 100,
                ),
              ),
              Card(
                margin: const EdgeInsets.all(10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Form(
                      key: _form,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          if (!isLogin)
                            UserInputImage(
                              onSelectImage: (pickedImage) {
                                _selectedImage = pickedImage;
                              },
                            ),
                          if (!isLogin)
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Username',
                              ),
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    value.length < 4) {
                                  return 'Please enter a valid username';
                                }
                                return null;
                              },
                              onSaved: (value) => {_enteredUserName = value!},
                            ),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Email address',
                            ),
                            keyboardType: TextInputType.emailAddress,
                            autocorrect: false,
                            textCapitalization: TextCapitalization.none,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your Email address';
                              }
                              return null;
                            },
                            onSaved: (newValue) => {_enteredEmail = newValue!},
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Password',
                            ),
                            obscureText: true,
                            validator:
                                (value) =>
                                    value != null && value.length < 6
                                        ? 'Password must be at least 6 characters long'
                                        : null,
                            onSaved:
                                (newValue) => {_enteredPassword = newValue!},
                          ),
                          SizedBox(height: 20),
                          if (_isAuthenting) CircularProgressIndicator(),
                          if (!_isAuthenting)
                            ElevatedButton(
                              onPressed: _submit,
                              child: Text(isLogin ? 'Login' : 'Sign Up'),
                            ),
                          if (!_isAuthenting)
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  isLogin = !isLogin;
                                });
                              },
                              child: Text(
                                isLogin
                                    ? 'Create new account'
                                    : 'I already have an account',
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
