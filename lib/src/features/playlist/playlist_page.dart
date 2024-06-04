import 'package:flutter/material.dart';
import 'package:play_nuvem/src/features/playlist/playlist_controller.dart';
import 'package:play_nuvem/src/features/playlist/playlist_state.dart';
import 'package:play_nuvem/src/shared/locator/locator_services.dart';

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
            return const Center(
              child: Text('Ocorreu um erro!'),
            );
          } else if (controller.state is PlaylistSuccess) {
            var playlist = controller.state.playlist;
            return Column(
              children: playlist.map((e) {
                return ListTile(
                  leading: const Icon(Icons.movie_edit),
                  title: Text(e.name),
                  trailing: Expanded(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {},
                        )
                      ],
                    ),
                  ),
                );
              }).toList(),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
