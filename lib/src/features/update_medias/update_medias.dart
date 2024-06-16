import 'package:flutter/material.dart';
import 'package:play_nuvem/src/features/update_medias/update_medias_controller.dart';
import 'package:play_nuvem/src/features/update_medias/update_medias_state.dart';
import 'package:play_nuvem/src/shared/locator/locator_services.dart';
import 'package:play_nuvem/src/shared/ui/styles/app_text_style.dart';

class UpdateMedias extends StatefulWidget {

  const UpdateMedias({ super.key });

  @override
  State<UpdateMedias> createState() => _UpdateMediasState();
}

class _UpdateMediasState extends State<UpdateMedias> {
  final controller = getIt.get<UpdateMediasController>();

  @override
  void initState() {
    super.initState();
    controller.init();
  }

   @override
   Widget build(BuildContext context) {
       return Scaffold(
           body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text('Atualizando conteúdo de medias', style: AppTextStyle.titleMedium, textAlign: TextAlign.center),
              const SizedBox(
                 height: 20,
              ),
              ListenableBuilder(listenable: controller, builder: (context, child) {
                if(controller.state is UpdateMediasLoading){
                  return const Center(child: CircularProgressIndicator());
                } else {
                  Future.delayed(const Duration(seconds: 3), () {
                    Navigator.pop(context);
                  });
                  return const Text('Conteúdo atualizado', textAlign:  TextAlign.center);
                }
              },),
            ],
           ),
       );
  }
}