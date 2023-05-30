// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';

import '../../core/utils/app_url_tmdb.dart';

class VideoPlayerComponent extends StatefulWidget {
  final String url;
  final String backdropPath;
  const VideoPlayerComponent({
    Key? key,
    required this.url,
    required this.backdropPath,
  }) : super(key: key);

  @override
  State<VideoPlayerComponent> createState() => _VideoPlayerComponentState();
}

class _VideoPlayerComponentState extends State<VideoPlayerComponent> {
  late BetterPlayerController _betterPlayerController;
  
  

  @override
  void initState() {
    super.initState();
    
    BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(BetterPlayerDataSourceType.network, widget.url);
    _betterPlayerController = BetterPlayerController(
        BetterPlayerConfiguration(
          aspectRatio: 16 / 9,
          autoPlay: true,
          placeholder: Image.network(AppUrlTmdb.REQUEST_IMAGE(widget.backdropPath), fit: BoxFit.cover,),
        ),
        betterPlayerDataSource: betterPlayerDataSource);
   
  }

  @override
  void dispose() {
    _betterPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return AspectRatio(
      aspectRatio: 16 / 9,
      child: BetterPlayer(
        controller: _betterPlayerController,
      ),
    );
  }
}
