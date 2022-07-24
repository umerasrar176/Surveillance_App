import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:video_player/video_player.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class Livepreview extends StatefulWidget {
  const Livepreview({Key? key}) : super(key: key);

  @override
  _LivepreviewState createState() => _LivepreviewState();
}

class _LivepreviewState extends State<Livepreview> {
  /*int _currentIndex = 0;
  final List _children = [];

  List<String> imageList = [
    'https://cdn.pixabay.com/photo/2020/12/15/16/25/clock-5834193__340.jpg',
    'https://cdn.pixabay.com/photo/2020/09/18/19/31/laptop-5582775_960_720.jpg',
    'https://media.istockphoto.com/photos/woman-kayaking-in-fjord-in-norway-picture-id1059380230?b=1&k=6&m=1059380230&s=170667a&w=0&h=kA_A_XrhZJjw2bo5jIJ7089-VktFK0h0I4OWDqaac0c=',
    'https://cdn.pixabay.com/photo/2019/11/05/00/53/cellular-4602489_960_720.jpg',
    'https://cdn.pixabay.com/photo/2017/02/12/10/29/christmas-2059698_960_720.jpg',
    'https://cdn.pixabay.com/photo/2020/01/29/17/09/snowboard-4803050_960_720.jpg',
    'https://cdn.pixabay.com/photo/2020/02/06/20/01/university-library-4825366_960_720.jpg',
    'https://cdn.pixabay.com/photo/2020/11/22/17/28/cat-5767334_960_720.jpg',
    'https://cdn.pixabay.com/photo/2020/12/13/16/22/snow-5828736_960_720.jpg',
    'https://cdn.pixabay.com/photo/2020/12/09/09/27/women-5816861_960_720.jpg',
  ];*/
  //late VideoPlayerController _videoController;
  late FlickManager flickManager;

  Map<String, dynamic> mockData = {
    "items": [
      {
        "title": "Rio from Above",
        "image": "images/rio_from_above_poster.jpg",
        "trailer_url":
        "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4",
      },
      {
        "title": "The Valley",
        "image": "images/the_valley_poster.jpg",
        "trailer_url":
        "https://github.com/GeekyAnts/flick-video-player-demo-videos/blob/master/example/the_valley_compressed.mp4?raw=true",
      },
      {
        "title": "Iceland",
        "image": "images/iceland_poster.jpg",
        "trailer_url":
        "https://github.com/GeekyAnts/flick-video-player-demo-videos/blob/master/example/iceland_compressed.mp4?raw=true",
      },
      {
        "title": "9th May & Fireworks",
        "image": "images/9th_may_poster.jpg",
        "trailer_url":
        "https://github.com/GeekyAnts/flick-video-player-demo-videos/blob/master/example/9th_may_compressed.mp4?raw=true",
      },
    ]
  };

  @override
  void initState() {
    super.initState();
    flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.network(
        //'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
        mockData["items"][0]["trailer_url"],
        //'http://10.113.57.118:8080//video'
      ),
    );
    // **When the controllers change, call setState() to rebuild widget.**
    /*..addListener(() => setState(() {}))
      ..setLooping(true)
      ..initialize();
      _videoController.play();*/
    /*_audioController = VideoPlayerController.network(
      'https://file-examples.com/wp-content/uploads/2017/11/file_example_MP3_700KB.mp3',
    )
      ..addListener(() => setState(() {}))
      ..setLooping(true)
      ..initialize();*/
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: const EdgeInsets.all(5),
          child:  StaggeredGridView.countBuilder(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 12,
              itemCount: 8,
              itemBuilder: (context, index) {
                return Container(
                  decoration: const BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.all(
                          Radius.circular(15))
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(
                        Radius.circular(15)),
                    child: _buildVideoPlayerUI()
                    )
                );
              },
              staggeredTileBuilder: (index) {
                return StaggeredTile.count(1, index.isEven ? 1 : 1);
              }),
        ),
      ),
    );

    /*return ListView(
      padding: const EdgeInsets.all(4),
      children: <Widget>[
        //const ListTile(title: Text('Play online video:')),
        Center(
          child: _videoController.value.isInitialized
              ? _buildVideoPlayerUI()
              : const CircularProgressIndicator(),
        ),
         *//**//* *//*const Divider(),
        const ListTile(title: Text('Play online audio:')),
        Center(
          child: _audioController.value.isInitialized
              ? _buildAudioPlayerUI()
              : const LinearProgressIndicator(),
        ),
        const Divider(),
        const ListTile(
          title: Text(
            '(Also possible to play media from local file or '
                'from assets, or display subtitles. '
                'Cf. the plugin documentation.)',
          ),
        ),*//*
      ],
    );*/
  }
    Widget _buildVideoPlayerUI() {
      return VisibilityDetector(
        key: ObjectKey(flickManager),
        onVisibilityChanged: (visibility) {
          if (visibility.visibleFraction == 0 && mounted) {
            flickManager.flickControlManager?.autoPause();
          } else if (visibility.visibleFraction == 1) {
            flickManager.flickControlManager?.autoResume();
          }
        },
        child: FlickVideoPlayer(
          flickManager: flickManager,
          flickVideoWithControls: const FlickVideoWithControls(
            //closedCaptionTextStyle: TextStyle(fontSize: 8),
            controls: FlickPortraitControls(),
          ),
          flickVideoWithControlsFullscreen: const FlickVideoWithControls(
            controls: FlickLandscapeControls(),
          ),
        ),
      );
      /*return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        AspectRatio(
          aspectRatio: _videoController.value.aspectRatio,
          child: VideoPlayer(_videoController),
        ),*/
      /*Text(
          '${_videoController.value.position} / ${_videoController.value.duration}',
        ),*/
      //VideoProgressIndicator(_videoController, allowScrubbing: true),
      /*ElevatedButton.icon(
          onPressed: () => _videoController.value.isPlaying
              ? _videoController.pause()
              : _videoController.play(),
          icon: Icon(
            _videoController.value.isPlaying ? Icons.pause : Icons.play_arrow,
          ),
          label: Text(_videoController.value.isPlaying ? 'Pause' : 'Play'),
        ),
      ],
    );*/
      return VisibilityDetector(
        key: ObjectKey(flickManager),
        onVisibilityChanged: (visibility) {
          if (visibility.visibleFraction == 0 && mounted) {
            flickManager.flickControlManager?.autoPause();
          } else if (visibility.visibleFraction == 1) {
            flickManager.flickControlManager?.autoResume();
          }
        },
        child: Container(
          child: FlickVideoPlayer(
            flickManager: flickManager,
            flickVideoWithControls: const FlickVideoWithControls(
              //closedCaptionTextStyle: TextStyle(fontSize: 8),
              controls: FlickPortraitControls(),
            ),
            flickVideoWithControlsFullscreen: const FlickVideoWithControls(
              controls: FlickLandscapeControls(),
            ),
          ),
        ),
      );
    }
    @override
    void dispose() {
      //_videoController.dispose();
      flickManager.dispose();
      super.dispose();
    }
  }