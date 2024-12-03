import 'package:flutter/material.dart';

class KunjunganPage extends StatefulWidget {
  const KunjunganPage({super.key});

  @override
  State<KunjunganPage> createState() => _KunjunganPageState();
}

class _KunjunganPageState extends State<KunjunganPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Kunjungan'),
        titleTextStyle: const TextStyle(fontWeight: FontWeight.bold),
        //color title
        backgroundColor: const Color.fromARGB(255, 114, 76, 175),
      ),
      body: const Center(child: Text('Kunjungan'),
      ),
    );
  }
}