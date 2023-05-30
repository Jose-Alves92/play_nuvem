import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../controllers/cloud_controller.dart';

class MyCloudsComponent extends StatelessWidget {
  const MyCloudsComponent({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final cloudController = Provider.of<CloudController>(context);
    return Container(
      padding: const EdgeInsets.all(10),
      width: size.width,
      height: size.height,
      child: ListView.builder(
        itemCount: cloudController.listNuvem.length,
        itemBuilder: (context, int index) => Card(
          child: ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.blue,
            ),
            title: Text(cloudController.listNuvem[index].name),
            subtitle:
                Text('Nuvem: ${cloudController.listNuvem[index].tipo}'),
            trailing: SizedBox(
              width: 50,
              child: Row(
                children: [
                  Text(
                      cloudController.listNuvem[index].totalcountitems!),
                  Expanded(
                    child: IconButton(
                        onPressed: () {}, icon: const Icon(Icons.delete)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
