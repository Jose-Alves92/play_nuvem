// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';

import '../utils/app_url_tmdb.dart';


class VideoPlayerWidget extends StatefulWidget {
  final String url;
  final String? backdropPath;
  const VideoPlayerWidget({
    Key? key,
    required this.url,
    required this.backdropPath,
  }) : super(key: key);

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late BetterPlayerController _betterPlayerController;
  
  

  @override
  void initState() {
    super.initState();
    
    BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(BetterPlayerDataSourceType.network, widget.url);
    _betterPlayerController = BetterPlayerController(
        BetterPlayerConfiguration(
          aspectRatio: 16 / 9,
          autoPlay: false,
          placeholder: Image.network(AppUrlTmdb.image(widget.backdropPath!), fit: BoxFit.cover,),
        ),
        betterPlayerDataSource: betterPlayerDataSource);
   
  }

  @override
  void dispose() {
    super.dispose();
    _betterPlayerController.dispose();
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
