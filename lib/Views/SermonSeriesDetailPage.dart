import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:phpc_v2/Models/preachers_model.dart';
import 'package:phpc_v2/Models/sermon_model.dart';

import 'package:phpc_v2/Models/sermon_series_model.dart';
import 'package:phpc_v2/Views/SermonPage.dart';
import 'package:phpc_v2/Views/Webview.dart';
import 'package:phpc_v2/globals.dart' as globals;

class SermonSeriesDetailPage extends StatefulWidget {
  const SermonSeriesDetailPage(
      {required this.series,
      required this.sermons,
      required this.preachers,
      Key? key})
      : super(key: key);

  final SermonSeriesModel series;
  final List<SermonsModel> sermons;
  final List<PreachersModel> preachers;

  @override
  State<SermonSeriesDetailPage> createState() => _SermonSeriesDetailPageState();
}

class _SermonSeriesDetailPageState extends State<SermonSeriesDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
                child: CachedNetworkImage(
              imageUrl: widget.series.seriesGraphic.url,
              placeholder: (context, url) => Container(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            )),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return sermonsTile(
                    series: widget.series,
                    sermons: widget.sermons[index],
                    preachers: widget.preachers,
                  );
                },
                childCount: widget.sermons.length,
              ),
            ),
          ],
        ));
  }
}

class sermonsTile extends StatelessWidget {
  const sermonsTile(
      {required this.series,
      required this.sermons,
      required this.preachers,
      Key? key})
      : super(key: key);
  final SermonSeriesModel series;
  final SermonsModel sermons;
  final List<PreachersModel> preachers;

  @override
  Widget build(BuildContext context) {
    int preacherIndex =
        preachers.indexWhere((preacher) => preacher.id == sermons.preacher);
    return Column(
      children: [
        ListTile(
          minVerticalPadding: 25,
          title: Text(sermons.name),
          subtitle: Text(preachers[preacherIndex].name),
          leading: CachedNetworkImage(
            imageUrl: series.seriesGraphic.url,
            placeholder: (context, url) => const SizedBox(
              height: 100,
              width: 100,
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.arrow_forward_ios, size: 18),
            ],
          ),
          onTap: () {
            Navigator.of(context, rootNavigator: true).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  if (Uri.parse(sermons.videoEmbedd.url).host == 'youtu.be' ||
                      Uri.parse(sermons.videoEmbedd.url).host ==
                          'www.youtube.com') {
                    return SermonPage(
                      sermon: sermons,
                      preacher: preachers[preacherIndex],
                    );
                  } else {
                    return WebViewStack(
                        url: '${globals.sermonBaseURL}${sermons.slug}');
                  }
                },
                fullscreenDialog: true,
              ),
            );
          },
        ),
        const Divider(
          height: 1,
        )
      ],
    );
  }
}
