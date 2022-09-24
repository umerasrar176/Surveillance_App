import 'package:flutter/cupertino.dart';
import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';

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

  @override
  void initState() {
    BetterPlayerConfiguration _playerConfigurations =
        const BetterPlayerConfiguration(
            aspectRatio: 16 / 9, fit: BoxFit.contain);
    BetterPlayerDataSource _playerDatasource = BetterPlayerDataSource(
        BetterPlayerDataSourceType.network, widget.videoUrl);
    _controller = BetterPlayerController(_playerConfigurations);
    _controller.setupDataSource(_playerDatasource);
    _controller.setBetterPlayerGlobalKey(_playerKey);

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
            child: BetterPlayer(
              key: _playerKey,
              controller: _controller,
            ),
          ))
        ],
      ),
    );
  }
}
