import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:surveillance_app/screens/video_screen.dart';
import 'package:transparent_image/transparent_image.dart';
//import 'package:video_player/video_player.dart';
//import 'package:videos_player/model/video.model.dart';
//import 'package:videos_player/videos_player.dart';
//import 'package:flick_video_player/flick_video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';
//import 'package:video_player/video_player.dart';


class Livepreview extends StatefulWidget {
  const Livepreview({Key? key}) : super(key: key);

  @override
  _LivepreviewState createState() => _LivepreviewState();
}

  int count = 0;
class _LivepreviewState extends State<Livepreview> {
  /*int _currentIndex = 0;
  final List _children = [];

  List<String> imageList = [
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

  /*List<String> videos = [
    "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4",
    "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4",
    "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4",
    "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4",
    "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4",
    "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4"
  ];*/

  final List<Map<String, String>> _list = [
    {
      'id': "2",
      'name': "Elephant Dream",
      'videoUrl':
          "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
      'thumbnailUrl':
          "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/ElephantsDream.jpg",
    },
    {
      'id': "3",
      'name': "Big Buck Bunny",
      'videoUrl':
          "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
      'thumbnailUrl':
          "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/BigBuckBunny.jpg",
    },
    {
      'id': "4",
      'name': "For Bigger Blazes",
      'videoUrl':
          "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
      'thumbnailUrl':
          "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/ForBiggerBlazes.jpg"
    },
    {
      'id': "5",
      'name': "For Bigger Escape",
      'videoUrl':
      "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4",
      'thumbnailUrl':
      "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/ForBiggerBlazes.jpg"
    },
    {
      'id': "6",
      'name': "For Bigger Fun",
      'videoUrl':
      "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4",
      'thumbnailUrl':
      "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/ForBiggerBlazes.jpg"
    },
    {
      'id': "7",
      'name': "IP Camera",
      'videoUrl':
      "rtsp://admin:Ecaict123@192.168.43.228:554/live/ch00_1",
      //"https://192.168.0.103:8080/video",
      'thumbnailUrl':
      "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/ForBiggerBlazes.jpg"
    }
  ];
  //late VideoPlayerController _videoController;
  //late FlickManager flickManager;

  /*Map<String, dynamic> mockData = {
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
  };*/

  /*getpath() {
    String vid = '';
    for (var video in videos) {
      setState(() {
        vid = video;
      });
    }
    return vid;
  }*/

  @override
  void initState() {
    super.initState();
    //print("path " + getpath());
    /*flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.network(
        getpath(),
        //'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
        //mockData["items"][0]["trailer_url"],
        //'https://192.168.10.6:8080//video'
        // 'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4'
      ),
    );*/
  }

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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: ListView(
        children: _list
            .map((e) => GestureDetector(
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) =>  VideoScreen(
                        name: e['name']!,
                        videoUrl: e['videoUrl']!
                      ))),
                  child:Card(
                      margin: const EdgeInsets.all(10),
                      shadowColor: const Color(0x802196F3),
                      elevation: 5,
                      child: ListTile(
                        title: Text(e['name']!),
                        leading: const Icon(Icons.video_collection),
                        trailing: Image.network(e['thumbnailUrl']!),
                      )//Text(e['name']!),
                  ))
                  )
            .toList(),
      )

          /*Container(
          margin: const EdgeInsets.all(5),
          child:  StaggeredGridView.countBuilder(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 12,
              itemCount: videos.length,
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
                        child: VisibilityDetector(
                          key: ObjectKey(videos[index]),
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
                        )
                    )
                );
              },
              staggeredTileBuilder: (index) {
                return StaggeredTile.count(1, index.isEven ? 1 : 1);
              }),
        ),*/
          ),
    );

    /*Scaffold(
      body: ListView.builder(
        itemCount: _list.length,
        itemBuilder: (BuildContext ctx, int index) {
          return VideosPlayer(
            networkVideos: [
              NetworkVideo(
                  id: _list[index]['id'],
                  name: _list[index]['name'],
                  videoUrl: _list[index]['videoUrl'],
                  thumbnailUrl: _list[index]['thumbnailUrl'])
            ],
          );
        },
      ),
    );*/

    /*return ListView(
      padding: const EdgeInsets.all(4),
      children: <Widget>[
        //const ListTile(title: Text('Play online video:')),
        Center(
          child: _videoController.value.isInitialized
              ? _buildVideoPlayerUI()
              : const CircularProgressIndicator(),
        ),
         */ /**/ /* */ /*const Divider(),
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
        ),*/ /*
      ],
    );*/
  }
  /*Widget _buildVideoPlayerUI() {
      return VisibilityDetector(
        key: ObjectKey(videos[5]),
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
      */ /*return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        AspectRatio(
          aspectRatio: _videoController.value.aspectRatio,
          child: VideoPlayer(_videoController),
        ),*/ /*
      */ /*Text(
          '${_videoController.value.position} / ${_videoController.value.duration}',
        ),*/ /*
      //VideoProgressIndicator(_videoController, allowScrubbing: true),
      */ /*ElevatedButton.icon(
          onPressed: () => _videoController.value.isPlaying
              ? _videoController.pause()
              : _videoController.play(),
          icon: Icon(
            _videoController.value.isPlaying ? Icons.pause : Icons.play_arrow,
          ),
          label: Text(_videoController.value.isPlaying ? 'Pause' : 'Play'),
        ),
      ],
    );
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
      );*/ /*
    }*/
  /*@override
    void dispose() {
      //_videoController.dispose();
      flickManager.dispose();
      super.dispose();
    }*/
}
