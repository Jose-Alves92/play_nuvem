import 'package:flutter/material.dart';
import 'package:play_nuvem/src/features/playlist/playlist_controller.dart';
import 'package:play_nuvem/src/shared/locator/locator_services.dart';
import 'package:play_nuvem/src/models/m3u/playlist.dart';
import 'package:play_nuvem/src/shared/ui/helpers/messages.dart';
import 'package:play_nuvem/src/shared/ui/styles/app_colors.dart';
import 'package:play_nuvem/src/shared/ui/styles/app_text_style.dart';
import 'package:play_nuvem/src/shared/utils/app_routes.dart';
import 'package:validatorless/validatorless.dart';

class PlaylistFormPage extends StatefulWidget {
  final Playlist? playlist;
  const PlaylistFormPage({super.key, this.playlist});

  @override
  State<PlaylistFormPage> createState() => _PlaylistFormPageState();
}

class _PlaylistFormPageState extends State<PlaylistFormPage> {
  final nameEC = TextEditingController();
  final urlEC = TextEditingController();
  final formKey = GlobalKey<FormState>();

  var controller = getIt.get<PlaylistController>();

  @override
  void initState() {
    super.initState();
    nameEC.text = widget.playlist?.name ?? '';
    urlEC.text = widget.playlist?.url ?? '';
  }

  @override
  void dispose() {
    super.dispose();
    nameEC.dispose();
    urlEC.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Form(
        key: formKey,
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              children: [
                const Text(
                  'Adicione sua lista de reprodução M3U',
                  style: AppTextStyle.titleMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 70,
                ),
                TextFormField(
                  onTapOutside: (_) => FocusScope.of(context).unfocus(),
                  controller: nameEC,
                  keyboardType: TextInputType.text,
                  validator: Validatorless.required('url is required'),
                  decoration: const InputDecoration(
                      filled: true,
                      fillColor: AppColors.secondaryColor,
                      hintText: 'Name Lista',
                      hintStyle: AppTextStyle.bodySmall,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white))),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  onTapOutside: (_) => FocusScope.of(context).unfocus(),
                  controller: urlEC,
                  keyboardType: TextInputType.text,
                  validator: Validatorless.required('url is required'),
                  decoration: const InputDecoration(
                      filled: true,
                      fillColor: AppColors.secondaryColor,
                      hintText: 'link da Lista',
                      hintStyle: AppTextStyle.bodySmall,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white))),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                    ),
                    onPressed: () {
                      switch (formKey.currentState?.validate()) {
                        case null || false:
                          Messages.showError('Formulário invalido', context);
                        case true:
                          controller.addPlaylist(Playlist(
                                  id: widget.playlist?.id,
                                  name: nameEC.text,
                                  url: urlEC.text))
                              .then(
                            (value) {
                              if (value) {
                                Messages.showSuccess(
                                    'Playlist adicionada com sucesso!', context);
                                Future.delayed(
                                  const Duration(seconds: 5),
                                  () {
                                    Navigator.popAndPushNamed(
                                        context, AppRoutes.UPDATE_MEDIAS);
                                  },
                                );
                              } else {
                                Messages.showError(
                                    'Error nas Credenciais!',
                                    context);
                              }
                            },
                          );
                      }
                    },
                    child:
                        const Text('Salvar', style: AppTextStyle.titleMedium),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
