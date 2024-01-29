import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Center(child: Text('This is home page')),
          ElevatedButton(
              onPressed: () {}, child: const Text('Click to homepage'))
        ],
      ),
    );
  }
}
