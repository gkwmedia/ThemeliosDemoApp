import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phpc_v2/Models/front_page_image_model.dart';
import 'package:phpc_v2/Models/front_page_model.dart';
import 'package:phpc_v2/Providers/front_page_image_provider.dart';
import 'package:phpc_v2/Providers/front_page_provider.dart';
import 'package:phpc_v2/Views/LiveStreamPage.dart';
import 'package:phpc_v2/Views/Webview.dart';

class FrontPage extends ConsumerStatefulWidget {
  const FrontPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FrontPageState();
}

class _FrontPageState extends ConsumerState<FrontPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    AsyncValue<List<FrontPageModel>> frontPageList =
        ref.watch(frontPageProvider);
    AsyncValue<List<FrontPageImageModel>> frontPageImage =
        ref.watch(frontPageImageProvider);

    return frontPageList.when(
        error: (error, stackTrace) => Center(child: Text(error.toString())),
        loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
        data: (frontPageList) {
          return frontPageImage.when(
              error: (error, stackTrace) => Center(
                    child: Text(error.toString()),
                  ),
              loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
              data: (frontPageImage) {
                return Scaffold(
                  appBar: AppBar(
                    title: const Text('Home'),
                  ),
                  body: CustomScrollView(
                    slivers: <Widget>[
                      SliverToBoxAdapter(
                        child: InkWell(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: CachedNetworkImage(
                              imageUrl: frontPageImage[0].image.url,
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
                            // return HomePageTile(homePageItem: frontPageList[index]);
                            return frontPageTile(context, frontPageList[index]);
                          },
                          childCount: frontPageList.length,
                        ),
                      ),
                    ],
                  ),
                );
              });
        });
  }

  @override
  bool get wantKeepAlive => true;
}

Widget frontPageTile(BuildContext context, FrontPageModel frontPageItem) {
  return ListTile(
    title: Text(frontPageItem.name),
    subtitle: Text(frontPageItem.subtitle),
    trailing: const Icon(
      Icons.arrow_forward_ios,
      size: 18,
    ),
    onTap: () {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return WebViewStack(url: frontPageItem.link);
      }));
    },
  );
}
