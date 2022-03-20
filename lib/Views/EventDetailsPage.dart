import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:mailto/mailto.dart';
import 'package:phpc_v2/Models/event_page_model.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:phpc_v2/Services/add_to_calendar.dart';
import 'package:phpc_v2/Views/Webview.dart';
import 'package:share_plus/share_plus.dart';
import 'package:phpc_v2/globals.dart' as globals;
import 'package:url_launcher/url_launcher.dart';
import 'package:email_launcher/email_launcher.dart';

class EventDetailsPage extends StatelessWidget {
  final EventsModel event;
  final int index;

  const EventDetailsPage({Key? key, required this.event, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Stack(
                  children: [
                    Hero(
                        tag: 'Event_Image' + index.toString(),
                        child: CachedNetworkImage(imageUrl: event.image.url)),
                  ],
                );
              },
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 20, 8, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    event.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                      '${DateFormat.yMMMMd().format(event.startDateTime.toLocal())}  |  ${DateFormat.jm().format(event.startDateTime.toLocal())}'),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          onPressed: () =>
                              Add2Calendar.addEvent2Cal(EventToCalendar(event)),
                          icon: const FaIcon(
                            FontAwesomeIcons.calendarPlus,
                            size: 30,
                          ),
                        ),
                        IconButton(
                            onPressed: () => Share.share(
                                '${globals.eventBaseURL}${event.slug}'),
                            icon: const Icon(
                              Icons.ios_share,
                              size: 30,
                            )),
                      ],
                    ),
                  ),
                  const Divider(
                    thickness: 2,
                    indent: 40,
                    endIndent: 40,
                  ),
                  Html(
                      data: event.description,
                      onLinkTap: (url, context, attributes, element) async {
                        await launch(url!);
                      }),
                  if (event.rsvpLink != '')
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) {
                                return WebViewStack(url: event.rsvpLink);
                              },
                            ),
                          );
                        },
                        child: const Text('Register')),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
