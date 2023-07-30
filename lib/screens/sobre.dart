import 'package:flutter/material.dart';

class Sobre extends StatelessWidget {
  const Sobre({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: const Text('Sobre'),
      actions: [
        IconButton(
          onPressed: () => Navigator.of(context).pushNamed('/'),
          icon: const Icon(Icons.close),
        ),
      ],
    );

    final availableHeight = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: appBar,
      body: Column(
        children: [
          SizedBox(
            height: availableHeight * 0.30,
            child: const Center(
              child: Text(
                'Agenda Telefônica',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.blueAccent,
                ),
              ),
            ),
          ),
          SizedBox(
            height: availableHeight * 0.7,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Text('Versão: 1.0'),
                Text('Info: Dados mockados'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
