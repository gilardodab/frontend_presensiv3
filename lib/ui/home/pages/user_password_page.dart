import 'package:flutter/material.dart';

class UserPasswordPage extends StatefulWidget {
  const UserPasswordPage({super.key});

  @override
  State<UserPasswordPage> createState() => _UserPasswordPageState();
}

class _UserPasswordPageState extends State<UserPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('Ubah Password'),
        backgroundColor: Color.fromARGB(255, 114, 76, 175),
        titleTextStyle: TextStyle(fontWeight: FontWeight.bold),
      ),
      body: Center(
        child: Text('Ubah Password'),
      ),
    );
  }
}