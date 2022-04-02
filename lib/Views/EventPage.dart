import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:phpc_v2/Models/event_page_image_model.dart';

import 'package:phpc_v2/Models/event_page_model.dart';
import 'package:phpc_v2/Providers/event_page_image_provider.dart';
import 'package:phpc_v2/Services/api.dart';
import 'package:phpc_v2/Services/errors.dart';
import 'package:phpc_v2/Views/EventDetailsPage.dart';

class EventPage extends ConsumerStatefulWidget {
  const EventPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EventPageState();
}

class _EventPageState extends ConsumerState<EventPage>
    with AutomaticKeepAliveClientMixin {
  Future<List<EventsModel>> _refreshData(BuildContext context) async {
    setState(() {});
    return fetchEvents();
  }

  @override
  Widget build(BuildContext context) {
    AsyncValue<List<EventPageImageModel>> eventPageImage =
        ref.watch(eventPageImageProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Events'),
      ),
      //wraps the event list builder in a refresh indicator
      body: RefreshIndicator(
        onRefresh: () async => await _refreshData(context),
        child: FutureBuilder<List<EventsModel>>(
          future: fetchEvents(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return eventPageImage.when(
                error: (error, stackTrace) =>
                    Center(child: Text(error.toString())),
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
                data: (eventImage) {
                  return CustomScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    slivers: [
                      SliverToBoxAdapter(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: CachedNetworkImage(
                            imageUrl: eventImage[0].image.url,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            return EventListTile(
                              event: snapshot.data![index],
                              index: index,
                            );
                          },
                          childCount: snapshot.data?.length,
                        ),
                      ),
                    ],
                  );
                },
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
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
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
            child: const Text('Try Again'))
      ],
    ));
  }

  @override
  bool get wantKeepAlive => true;
}

// class EventPage2 extends StatefulWidget {
//   const EventPage2({Key? key}) : super(key: key);

//   @override
//   _EventPage2State createState() => _EventPage2State();
// }

// class _EventPage2State extends State<EventPage2>
//     with AutomaticKeepAliveClientMixin {
//   late List<EventsModel> filteredEventList;

//   Future<List<EventsModel>> _refreshData(BuildContext context) async {
//     setState(() {});
//     return fetchEvents();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Events'),
//       ),
//       //wraps the event list builder in a refresh indicator
//       body: RefreshIndicator(
//         onRefresh: () async => await _refreshData(context),
//         child: FutureBuilder<List<EventsModel>>(
//           future: fetchEvents(),
//           builder: (context, snapshot) {
//             if (snapshot.hasData) {
//               return CustomScrollView(
//                 physics: const AlwaysScrollableScrollPhysics(),
//                 slivers: [
//                   SliverToBoxAdapter(
//                     child: SizedBox(
//                       width: MediaQuery.of(context).size.width,
//                       child: Image.asset(
//                         'images/EventImage.png',
//                         fit: BoxFit.fitWidth,
//                       ),
//                     ),
//                   ),
//                   SliverList(
//                     delegate: SliverChildBuilderDelegate(
//                       (context, index) {
//                         return EventListTile(
//                           event: snapshot.data![index],
//                           index: index,
//                         );
//                       },
//                       childCount: snapshot.data?.length,
//                     ),
//                   ),
//                 ],
//               );
//             }
//             if (snapshot.hasError) {
//               if (snapshot.error is NoInternetException) {
//                 NoInternetException noInternetException =
//                     snapshot.error as NoInternetException;
//                 return showError(noInternetException.message);
//               }
//               if (snapshot.error is NoServiceFoundException) {
//                 NoServiceFoundException noServiceFoundException =
//                     snapshot.error as NoServiceFoundException;
//                 return showError(noServiceFoundException.message);
//               }
//               if (snapshot.error is InvalidFormatException) {
//                 InvalidFormatException invalidFormatException =
//                     snapshot.error as InvalidFormatException;
//                 return showError(invalidFormatException.message);
//               }
//               if (snapshot.error is FetchDataException) {
//                 AppException fetchDataException =
//                     snapshot.error as AppException;
//                 return showError(fetchDataException.toString());
//               }
//               if (snapshot.error is BadRequestException) {
//                 AppException badRequestException =
//                     snapshot.error as AppException;
//                 return showError(badRequestException.toString());
//               }
//               if (snapshot.error is UnauthorisedException) {
//                 AppException unauthorisedException =
//                     snapshot.error as AppException;
//                 return showError(unauthorisedException.toString());
//               }
//               if (snapshot.error is InvalidInputException) {
//                 AppException invalidInputException =
//                     snapshot.error as AppException;
//                 return showError(invalidInputException.toString());
//               }
//               UnknownException unknownException =
//                   snapshot.error as UnknownException;
//               return showError(unknownException.message);
//             }
//             return const Center(child: CircularProgressIndicator());
//           },
//         ),
//       ),
//     );
//   }

//   @override
//   bool get wantKeepAlive => true;

//   Widget showError(String message) {
//     return Center(
//         child: Column(
//       mainAxisSize: MainAxisSize.min,
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Text(
//           message,
//           textAlign: TextAlign.center,
//         ),
//         ElevatedButton(
//             onPressed: () {
//               _refreshData(context);
//             },
//             child: const Text('Try Again'))
//       ],
//     ));
//   }
// }

// class EventTopPicture extends StatelessWidget {
//   const EventTopPicture({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return const Text('test');
//   }
// }

class EventListTile extends StatelessWidget {
  const EventListTile({Key? key, required this.event, required this.index})
      : super(key: key);

  final EventsModel event;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: Column(
        children: [
          ListTile(
            leading: Hero(
              tag: 'Event_Image' + index.toString(),
              child: CachedNetworkImage(
                imageUrl: event.image.url,
                placeholder: (context, url) => const SizedBox(
                  width: 100,
                  height: 100,
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                fit: BoxFit.fill,
              ),
            ),
            /*Image.network(
              event.image.url,
              height: 100,
              width: 100,
              fit: BoxFit.fill,
            ),*/
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 18,
            ),
            title: Text(event.name),
            subtitle:
                Text(DateFormat.yMMMMd().format(event.startDateTime.toLocal())),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return EventDetailsPage(
                      event: event,
                      index: index,
                    );
                  },
                ),
              );
            },
          ),
          const Divider(
            height: 1,
          ),
        ],
      ),
    );
  }
}
