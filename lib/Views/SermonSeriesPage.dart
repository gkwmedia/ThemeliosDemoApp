import 'package:flutter/material.dart';
import 'package:phpc_v2/Helpers/sermon_filter_helper.dart';
import 'package:phpc_v2/Models/preachers_model.dart';
import 'package:phpc_v2/Models/sermon_model.dart';
import 'package:phpc_v2/Models/sermon_series_model.dart';
import 'package:phpc_v2/Services/api.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:phpc_v2/Services/errors.dart';
import 'package:phpc_v2/Views/SermonSeriesDetailPage.dart';

class SermonSeriesPage extends StatefulWidget {
  const SermonSeriesPage({Key? key}) : super(key: key);

  @override
  _SermonSeriesPageState createState() => _SermonSeriesPageState();
}

class _SermonSeriesPageState extends State<SermonSeriesPage>
    with AutomaticKeepAliveClientMixin {
  Future<List<Object>> _refreshData(BuildContext context) async {
    setState(() {});

    return [fetchSermonSeries(), fetchSermons(), fetchPreachers()];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sermon Series'),
      ),
      body: RefreshIndicator(
        onRefresh: () => _refreshData(context),
        child: FutureBuilder(
          future: Future.wait<Object>(
              [fetchSermonSeries(), fetchSermons(), fetchPreachers()]),
          builder: (context, AsyncSnapshot<List> snapshot) {
            if (snapshot.hasData) {
              List<SermonSeriesModel> sermonSeriesList = snapshot.data![0];
              List<SermonsModel> sermonsList = snapshot.data![1];
              List<PreachersModel> preacherList = snapshot.data![2];

              return CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        //return SermonSeriesTile(series: snapshot.data![index]);
                        return SermonTile(context, sermonSeriesList[index],
                            sermonsList, preacherList);
                      },
                      addAutomaticKeepAlives: true,
                      childCount: sermonSeriesList.length,
                    ),
                  ),
                ],
              );
            }
            if (snapshot.hasError) {
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
                AppException fetchDataException =
                    snapshot.error as AppException;
                return showError(fetchDataException.toString());
              }
              if (snapshot.error is BadRequestException) {
                AppException badRequestException =
                    snapshot.error as AppException;
                return showError(badRequestException.toString());
              }
              if (snapshot.error is UnauthorisedException) {
                AppException unauthorisedException =
                    snapshot.error as AppException;
                return showError(unauthorisedException.toString());
              }
              if (snapshot.error is InvalidInputException) {
                AppException invalidInputException =
                    snapshot.error as AppException;
                return showError(invalidInputException.toString());
              }
              UnknownException unknownException =
                  snapshot.error as UnknownException;
              return showError(unknownException.message);
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

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
  }
}

Widget SermonTile(BuildContext context, SermonSeriesModel series,
    List<SermonsModel> sermonsList, List<PreachersModel> preacherList) {
  return Column(
    children: [
      InkWell(
          child: CachedNetworkImage(
            imageUrl: series.seriesGraphic.url,
            placeholder: (
              context,
              url,
            ) =>
                AspectRatio(aspectRatio: 16 / 9, child: Container()),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          onTap: () {
            List<SermonsModel> filteredSermons =
                filterSermons(series.id, sermonsList);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return SermonSeriesDetailPage(
                    series: series,
                    sermons: filteredSermons,
                    preachers: preacherList,
                  );
                },
              ),
            );
          }),
    ],
  );
}
