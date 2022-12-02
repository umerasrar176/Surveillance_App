import 'package:flutter/cupertino.dart';
import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';

class VideoScreen extends StatefulWidget {
  final String name, videoUrl;
  const VideoScreen({Key? key, required this.name, required this.videoUrl})
      : super(key: key);

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late BetterPlayerController _controller;
  final GlobalKey _playerKey = GlobalKey();
  late VlcPlayerController _videoPlayerController;

  @override
  void initState() {
    BetterPlayerConfiguration _playerConfigurations =
        const BetterPlayerConfiguration(
            aspectRatio: 16 / 9, fit: BoxFit.contain);
    BetterPlayerDataSource _playerDatasource = BetterPlayerDataSource(
        BetterPlayerDataSourceType.file, widget.videoUrl);
    _controller = BetterPlayerController(_playerConfigurations);
    _controller.setupDataSource(_playerDatasource);
    _controller.setBetterPlayerGlobalKey(_playerKey);

    _videoPlayerController = VlcPlayerController.network(
      widget.videoUrl,
      hwAcc: HwAcc.full,
      //autoPlay: false,
      options: VlcPlayerOptions(),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 8,
          ),
          Expanded(
              child: AspectRatio(
            aspectRatio: 16 / 9,
            child: VlcPlayer(
              controller: _videoPlayerController,
              aspectRatio: 16 / 9,
              placeholder: const Center(child: CircularProgressIndicator()),
            ),
                /*BetterPlayer(
              key: _playerKey,
              controller: _controller,
            ),*/
          ))
        ],
      ),
    );
  }
}
