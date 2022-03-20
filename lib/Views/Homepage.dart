import 'package:flutter/material.dart';
import 'package:phpc_v2/Models/home_page_model.dart';
import 'package:phpc_v2/Services/local_files.dart';
import 'package:phpc_v2/Views/LiveStreamPage.dart';
import 'package:phpc_v2/Views/Webview.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      /*drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              padding: EdgeInsets.zero,
              decoration: BoxDecoration(color: Theme.of(context).primaryColor),
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(0),
                  child: Image.asset(
                    'images/Logo.png',
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: Row(
                children: const [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Icon(
                      Icons.settings,
                      size: 25,
                    ),
                  ),
                  Text(
                    'About',
                    style: TextStyle(fontSize: 25),
                  )
                ],
              ),
            )
          ],
        ),
      ),*/
      body: FutureBuilder<List<HomePageModel>>(
        future: fetchHomePage(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return CustomScrollView(
              slivers: <Widget>[
                SliverToBoxAdapter(
                  child: InkWell(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Image.asset(
                        'images/WatchLive.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return const LiveStreamPage();
                      }));
                    },
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return HomePageTile(homePageItem: snapshot.data[index]);
                    },
                    childCount: snapshot.data.length,
                  ),
                ),
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class HomePageTile extends StatelessWidget {
  const HomePageTile({required this.homePageItem, Key? key}) : super(key: key);
  final HomePageModel homePageItem;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(homePageItem.name),
      subtitle: Text(homePageItem.subtitle),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 18,
      ),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return WebViewStack(url: homePageItem.url);
        }));
      },
    );
  }
}
