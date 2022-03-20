import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:phpc_v2/Models/preachers_model.dart';
import 'package:phpc_v2/Models/sermon_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:share_plus/share_plus.dart';

class SermonPage extends StatefulWidget {
  const SermonPage({required this.sermon, required this.preacher, Key? key})
      : super(key: key);
  final SermonsModel sermon;
  final PreachersModel preacher;

  @override
  _SermonPageState createState() => _SermonPageState();
}

class _SermonPageState extends State<SermonPage> {
  late YoutubePlayerController _videoController;

  @override
  void initState() {
    _videoController = YoutubePlayerController(
      initialVideoId:
          YoutubePlayer.convertUrlToId(widget.sermon.videoEmbedd.url)!,
      flags: const YoutubePlayerFlags(autoPlay: false),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
        player: YoutubePlayer(
          controller: _videoController,
          bottomActions: [
            CurrentPosition(),
            ProgressBar(isExpanded: true),
            FullScreenButton()
          ],
        ),
        builder: (context, player) {
          return Scaffold(
            appBar: AppBar(),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  player,
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 15, 15, 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.sermon.name,
                          style: const TextStyle(
                            fontSize: 26,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: Text(
                            widget.preacher.name,
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Column(
                                children: [
                                  IconButton(
                                    onPressed: () => Share.share(
                                        widget.sermon.videoEmbedd.url),
                                    icon: const Icon(Icons.ios_share),
                                    iconSize: 35,
                                  ),
                                  const Text('Share')
                                ],
                              ),
                              Column(
                                children: [
                                  IconButton(
                                    onPressed: () => launch(
                                        widget.sermon.videoEmbedd.url,
                                        forceSafariVC: false),
                                    icon: const FaIcon(
                                      FontAwesomeIcons.youtube,
                                      size: 35,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 60,
                                    child: Text(
                                      'Watch in YouTube',
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
