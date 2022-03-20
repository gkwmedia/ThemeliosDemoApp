import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:phpc_v2/Helpers/sermon_filter_helper.dart';
import 'package:phpc_v2/Models/preachers_model.dart';
import 'package:phpc_v2/Models/sermon_model.dart';

import 'package:phpc_v2/Models/sermon_series_model.dart';
import 'package:phpc_v2/Services/api.dart';
import 'package:phpc_v2/Services/errors.dart';
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
  List<SermonsModel> filteredSermons = [];
  /*Future<List<SermonsModel>> _refreshData(BuildContext context) {
    setState(() {});
    return fetchSermons();
  }*/

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

  /*Widget ErrorTypeCheck(AsyncSnapshot<List<dynamic>> snapshot) {
    if (snapshot.error is NoInternetException) {
      NoInternetException noInternetException =
          snapshot.error as NoInternetException;
      return showError(noInternetException.message);
    }
    if (snapshot.error is NoServiceFoundException) {
      NoServiceFoundException noServiceFoundException =
          snapshot.error as NoServiceFoundException;
      return showError(noServiceFoundException.message);
    }
    if (snapshot.error is InvalidFormatException) {
      InvalidFormatException invalidFormatException =
          snapshot.error as InvalidFormatException;
      return showError(invalidFormatException.message);
    }
    if (snapshot.error is FetchDataException) {
      AppException fetchDataException = snapshot.error as AppException;
      return showError(fetchDataException.toString());
    }
    if (snapshot.error is BadRequestException) {
      AppException badRequestException = snapshot.error as AppException;
      return showError(badRequestException.toString());
    }
    if (snapshot.error is UnauthorisedException) {
      AppException unauthorisedException = snapshot.error as AppException;
      return showError(unauthorisedException.toString());
    }
    if (snapshot.error is InvalidInputException) {
      AppException invalidInputException = snapshot.error as AppException;
      return showError(invalidInputException.toString());
    }
    UnknownException unknownException = snapshot.error as UnknownException;
    return showError(unknownException.message);
  }

  Widget showError(String message) {
    return Center(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          message,
          textAlign: TextAlign.center,
        ),
        ElevatedButton(
            onPressed: () {
              _refreshData(context);
            },
            child: Text('Try Again'))
      ],
    ));
  }*/
}

/*class sermonSeriesDetailPage extends StatelessWidget {
  const sermonSeriesDetailPage({required this.series, Key? key})
      : super(key: key);

  final SermonSeriesModel series;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: RefreshIndicator(
        onRefresh: () {
          return fetchSermons();
        },
        child: FutureBuilder(
          // fetchSermons is currently being limited to 15 items don't forget to remove that
          future:
              Future.wait<Object>([fetchSermons(), fetchPreachers()]),
          builder: (context, AsyncSnapshot<List> snapshot) {
            if (snapshot.hasError) {}
            if (snapshot.hasData) {
              List<SermonsModel> sermon = snapshot.data![0];
              List<PreachersModel> preachers = snapshot.data![1];

              return CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                      child: Image.network(series.seriesGraphic.url)),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return sermonsTile(
                          series: series,
                          sermons: sermon[index],
                          preachers: preachers,
                        );
                      },
                      childCount: sermon.length,
                    ),
                  ),
                ],
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}*/

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
            placeholder: (context, url) => Container(
              height: 100,
              width: 100,
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          trailing: const Icon(Icons.arrow_forward_ios, size: 18),
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
