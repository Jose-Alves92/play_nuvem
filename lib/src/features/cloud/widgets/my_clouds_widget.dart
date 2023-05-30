// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../shared/models/cloud_model.dart';

class MyCloudsWidget extends StatelessWidget {
  final Cloud cloud;
  final Function(Cloud cloud) changeCloud;
  final Function(Cloud cloud) removeCloud;

  const MyCloudsWidget({
    Key? key,
    required this.cloud,
    required this.changeCloud,
    required this.removeCloud,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: Colors.blue,
        ),
        title: Text(cloud.name),
        subtitle: Text('Nuvem: ${cloud.tipo}'),
        trailing: SizedBox(
          width: 100,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                  onPressed: () => changeCloud(cloud),
                  icon: const Icon(Icons.add)),
              IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Tem certeza em remover esta nuvem?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              removeCloud(cloud);
                            },
                            child: Text(
                              'Sim',
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Não',
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                            ),
                          ),
                        ],
                      ),
                    );
                   
                  },
                  icon: const Icon(Icons.delete)),
            ],
          ),
        ),
      ),
    );
  }
}
