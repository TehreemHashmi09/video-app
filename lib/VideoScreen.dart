import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoScreen extends StatefulWidget {
  final String videoUrl;
  final String restorationId;

  const VideoScreen(
      {super.key, required this.videoUrl, required this.restorationId});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> with RestorationMixin {
  @override
  // TODO: implement restorationId
  String? get restorationId => widget.restorationId;
  final RestorableString state = RestorableString('VideoScreen');

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    // TODO: implement restoreState
    registerForRestoration(state, 'VideoScreen');
  }

  VideoPlayerController? controller;

  @override
  void initState() {
    // TODO: implement initState
    print('123 ' + widget.videoUrl.toString());
    super.initState();
    controller = VideoPlayerController.networkUrl(
      Uri.parse(widget.videoUrl.toString()),
    )
      ..addListener(() => setState(() {}))
      ..setLooping(true)
      ..initialize().then((value) => setState(() {}))
      ..play();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller!.dispose();
    state.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: controller!.value.isInitialized && controller != null
              ? AspectRatio(
                  aspectRatio: controller!.value.aspectRatio,
                  child: Stack(
                    children: [
                      SizedBox(
                        child: VideoPlayer(controller!),
                      ),
                      Positioned.fill(
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            controller!.value.isInitialized &&
                                    controller != null
                                ? controller!.value.isPlaying
                                    ? controller!.pause()
                                    : controller!.play()
                                : null;
                          },
                          child: controller!.value.isInitialized &&
                                  controller != null
                              ? controller!.value.isPlaying
                                  ? SizedBox()
                                  : Icon(
                                      Icons.play_arrow,
                                      size: 60,
                                      color: Colors.black,
                                    )
                              : SizedBox(),
                        ),
                      ),
                    ],
                  ),
                )
              : CircularProgressIndicator()),
    );
  }
}
