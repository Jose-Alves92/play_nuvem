import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
//import 'package:chewie/chewie.dart';
//import 'package:flutter/services.dart';
import 'package:play_nuvem/controllers/nuvem_controller.dart';
import 'package:provider/provider.dart';
//import 'package:video_player/video_player.dart';

class VideoPlayerComponent extends StatefulWidget {
  const VideoPlayerComponent({super.key});

  @override
  State<VideoPlayerComponent> createState() => _VideoPlayerComponentState();
}

class _VideoPlayerComponentState extends State<VideoPlayerComponent> {
  late BetterPlayerController _betterPlayerController;
  // late VideoPlayerController _videoPlayerController;
  // late ChewieController _chewieController;

  _showModalBottomSheet() {
    final _nuvemController =
        Provider.of<NuvemController>(context, listen: false);
    showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return _nuvemController.listReproductionItems.isEmpty
            ? const Text('Nenhum conteúdo disponível!')
            : ListView.builder(
                itemCount: _nuvemController.listReproductionItems.length,
                itemBuilder: (context, int index) => Container(
                  child: ListTile(
                    leading: const CircleAvatar(),
                    title: Text(
                      _nuvemController.listReproductionItems[index].title,
                      style: const TextStyle(fontSize: 10),
                    ),
                    subtitle: Text(
                      _nuvemController.listReproductionItems[index].nameNuvem,
                      style: const TextStyle(fontSize: 10),
                    ),
                    //trailing: Text(_nuvemController.listReproductionMovie[index].resolution, style: const TextStyle(fontSize: 10),),
                    onTap: () {
                      _nuvemController.updateUrl(index: index);
                      print(_nuvemController.url);
                    },
                  ),
                ),
              );
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    String _url = Provider.of<NuvemController>(context, listen: false).url;
    BetterPlayerDataSource betterPlayerDataSource =
        BetterPlayerDataSource(BetterPlayerDataSourceType.network, _url);
    _betterPlayerController = BetterPlayerController(
        BetterPlayerConfiguration(
            aspectRatio: 16 / 9,
            controlsConfiguration: BetterPlayerControlsConfiguration(
              overflowMenuCustomItems: [
                BetterPlayerOverflowMenuItem(
                  Icons.cloud,
                  'Opções de Mídia',
                  () => _showModalBottomSheet(),
                ),
              ],
            )),
        betterPlayerDataSource: betterPlayerDataSource);
    // _videoPlayerController = VideoPlayerController.network(_url);
    // _chewieController = ChewieController(
    //   videoPlayerController: _videoPlayerController,
    //   aspectRatio: 16 / 9,
    //   autoPlay: true,
    //   //looping: true,
    //   additionalOptions: (context) {
    //     return <OptionItem>[
    //       OptionItem(
    //         onTap: () => _showModalBottomSheet(),
    //         iconData: Icons.cloud_done_sharp,
    //         title: 'Opções de Mídia',
    //       ),
    //     ];
    //   },
    // );
  }

  @override
  void dispose() {
    _betterPlayerController.dispose();
    // _videoPlayerController.dispose();
    // _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _nuvemController = Provider.of<NuvemController>(context);

    return AspectRatio(
      aspectRatio: 16 / 9,
      child: BetterPlayer(
        controller: _betterPlayerController,
      ), //Chewie(controller: _chewieController),
    );
  }
}
