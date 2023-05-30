import 'package:flutter/material.dart';
import 'package:play_nuvem/src/features/cloud/cloud_controller.dart';
import 'package:provider/provider.dart';

import '../../shared/models/cloud_model.dart';
import 'cloud_state.dart';
import 'widgets/my_clouds_widget.dart';

class CloudPage extends StatefulWidget {
  const CloudPage({
    Key? key,
  }) : super(key: key);

  @override
  State<CloudPage> createState() => _CloudPageState();
}

class _CloudPageState extends State<CloudPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CloudController>().loadListCloud();
    });
  }

  _changeCloud(Cloud cloud) {
    showFormCloud(context: context, cloud: cloud);
  }

  _removeCloud(Cloud cloud) {
    
    context.read<CloudController>().removeCloud(cloud).then((value) {
      if (value) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Removido com Sucesso!'),),
        );
      } else {
       ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro! Não foi passível remover.'),),
       );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final controller = context.watch<CloudController>();
    final state = controller.state;
    Widget? child;
    if (state is CloudLoadingState) {
      child = const Center(
        child: CircularProgressIndicator(),
      );
    } else if (state is CloudErrorState) {
      child = const Center(child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Text('Ocorreu um erro'),
      ));
    } else if (state is CloudSuccessState) {
      child = Container(
        padding: const EdgeInsets.all(10),
        width: size.width,
        height: size.height,
        child: ListView.builder(
          itemCount: controller.listCloud.length,
          itemBuilder: (context, int index) => MyCloudsWidget(
            cloud: controller.listCloud[index],
            changeCloud: _changeCloud,
            removeCloud: _removeCloud,
          ),
        ),
      );
    }

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
        ],
      ),
      body: child ?? const SizedBox(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => showFormCloud(context: context),
      ),
    );
  }
}

showFormCloud({required BuildContext context, Cloud? cloud}) {
  final formKey = GlobalKey<FormState>();
  var DataFormCloud = {};

  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Nuvem'),
      actions: [
        TextButton(
          onPressed: () async {
            formKey.currentState!.save();
            await context
                .read<CloudController>()
                .saveCloud(
                  Cloud(
                    id: cloud != null ? cloud.id : null,
                    tipo: 'Storj',
                    name: 'MyNuem',
                    credenciais: Credentials(
                      endPoint: DataFormCloud['endPoint'],
                      accessKey: DataFormCloud['accessKey'],
                      secretKey: DataFormCloud['secretKey'],
                    ),
                    pathBucketMovies: DataFormCloud['bucketMovies'],
                    pathBucketTvShows: DataFormCloud['bucketTvShows'],
                  ),
                )
                .then(
              (value) {
                Navigator.pop(context);
                if (value!) {
                 ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Salvo com Sucesso!'),
                    ),
                 );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Erro! Não foi passível salvar.'),),
                  );
                }
              },
            );
          },
          child: Text(
            'Salvar',
            style: TextStyle(color: Theme.of(context).colorScheme.secondary),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'Cancelar',
            style: TextStyle(color: Theme.of(context).colorScheme.secondary),
          ),
        ),
      ],
      content: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                initialValue: cloud != null ? cloud.credenciais.endPoint : '',
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  label: Text('endPoint'),
                ),
                onSaved: (newValue) {
                  DataFormCloud.addAll({'endPoint': newValue});
                },
              ),
              TextFormField(
                initialValue: cloud != null ? cloud.credenciais.accessKey : '',
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  label: Text('accessKey'),
                ),
                onSaved: (newValue) {
                  DataFormCloud.addAll({'accessKey': newValue});
                },
              ),
              TextFormField(
                initialValue: cloud != null ? cloud.credenciais.secretKey : '',
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  label: Text('secretKey'),
                ),
                onSaved: (newValue) {
                  DataFormCloud.addAll({'secretKey': newValue});
                },
              ),
              TextFormField(
                initialValue: cloud != null ? cloud.pathBucketMovies : '',
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  label: Text('Nome do Bucket Filmes'),
                ),
                onSaved: (newValue) {
                  DataFormCloud.addAll({'bucketMovies': newValue});
                },
              ),
              TextFormField(
                initialValue: cloud != null ? cloud.pathBucketTvShows : '',
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  label: Text('Nome do Bucket Series'),
                ),
                onSaved: (newValue) {
                  DataFormCloud.addAll({'bucketTvShows': newValue});
                },
              ),
            ],
          ),
        ),
      ),
    ),
  );
}


// MyCloudsWidget(listCloud: cloudController.listCloud)