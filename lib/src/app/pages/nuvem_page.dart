import 'package:flutter/material.dart';

import '../components/my_clouds_component.dart';


class NuvemPage extends StatelessWidget {
  const NuvemPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // NuvemController _nuvemController = Provider.of(context);
    // final _mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Nuvem'),
        actions: [
          IconButton(
            padding: const EdgeInsets.all(8.0),
            onPressed: () {},
            icon: const Icon(Icons.search),
            iconSize: 30,
          ),
          IconButton(
            padding: const EdgeInsets.all(8.0),
            iconSize: 30,
            onPressed: () {},
            icon: const CircleAvatar(
              //backgroundColor: Colors.blue,
              backgroundImage: AssetImage('assets/images/avatar.png'),
            ),
          ),
        ],
      ),
      body: const MyCloudsComponent(),
    );
  }
}

