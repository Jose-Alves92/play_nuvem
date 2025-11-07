import 'package:flutter/material.dart';
import 'package:play_nuvem/src/features/playlist/playlist_controller.dart';
import 'package:play_nuvem/src/features/playlist/playlist_state.dart';
import 'package:play_nuvem/src/shared/locator/locator_services.dart';
import 'package:play_nuvem/src/shared/ui/helpers/messages.dart';
import 'package:play_nuvem/src/shared/ui/styles/app_colors.dart';
import 'package:play_nuvem/src/shared/ui/widgets/error_widget.dart';
import 'package:play_nuvem/src/shared/utils/app_routes.dart';

// ignore: must_be_immutable
class PlaylistPage extends StatefulWidget {
  const PlaylistPage({super.key});

  @override
  State<PlaylistPage> createState() => _PlaylistPageState();
}

class _PlaylistPageState extends State<PlaylistPage> {
  final controller = getIt.get<PlaylistController>();

  @override
  void initState() {
    super.initState();
    controller.fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListenableBuilder(
        listenable: controller,
        builder: (context, child) {
          if (controller.state is PlaylistLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (controller.state is PlaylistError) {
            return const ErrorPageWidget();
          } else if (controller.state is PlaylistSuccess) {
            var playlist = controller.state.playlist;
            return playlist.isNotEmpty
                ? ListView.builder(
                    itemCount: playlist.length,
                    itemBuilder: (content, index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                        decoration: BoxDecoration(
                            color: AppColors.secondaryColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: ListTile(
                          leading: const Icon(Icons.movie_edit),
                          title: Text(playlist[index].name),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, AppRoutes.PLAYLIST_FORM,
                                      arguments: playlist[index]);
                                },
                              ),
                              IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    controller
                                        .removePlaylist(playlist[index])
                                        .then(
                                      (value) {
                                        if (value) {
                                          Messages.showSuccess('Playlist deletada!',context);
                                          Future.delayed(const Duration(seconds: 5), () {
                                            Navigator.pushNamed(context, AppRoutes.UPDATE_MEDIAS);
                                          },);
                                        } else {
                                          Messages.showError('Ocorreu um erro ao deletar a playlist!', context);
                                        }
                                      },
                                    );
                                  }),
                            ],
                          ),
                        ),
                      );
                    },
                  )
                : const ErrorPageWidget();
          } else {
            return const SizedBox();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.PLAYLIST_FORM);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
