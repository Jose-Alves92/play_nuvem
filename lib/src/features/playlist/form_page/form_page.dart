import 'package:flutter/material.dart';
import 'package:play_nuvem/src/features/playlist/playlist_controller.dart';
import 'package:play_nuvem/src/shared/locator/locator_services.dart';

class FormPage extends StatefulWidget {

  const FormPage({ super.key });

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {

  var controller = getIt.get<PlaylistController>();


   @override
   Widget build(BuildContext context) {
       return Scaffold(
           appBar: AppBar(title: const Text('Playlist'),),
           body: Form(
             child: Column(
              children: [
                
              ],
             ),
           ),
       );
  }
}