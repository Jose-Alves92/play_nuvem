import 'package:flutter/material.dart';
import 'package:play_nuvem/controllers/nuvem_controller.dart';
import 'package:provider/provider.dart';

class MyCloudsComponent extends StatelessWidget {
  const MyCloudsComponent({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final _mediaQuery = MediaQuery.of(context);
    final _nuvemController = Provider.of<NuvemController>(context);
    return Container(
      padding: const EdgeInsets.all(10),
      width: _mediaQuery.size.width,
      height: _mediaQuery.size.height,
      child: ListView.builder(
        itemCount: _nuvemController.listNuvem.length,
        itemBuilder: (context, int index) => Card(
          child: ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.blue,
            ),
            title: Text(_nuvemController.listNuvem[index].name),
            subtitle:
                Text('Nuvem: ${_nuvemController.listNuvem[index].tipo}'),
            trailing: SizedBox(
              width: 50,
              child: Row(
                children: [
                  Text(
                      _nuvemController.listNuvem[index].totalcountitems!),
                  IconButton(
                      onPressed: () {}, icon: const Icon(Icons.delete)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
