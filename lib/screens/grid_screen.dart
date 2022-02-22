import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:photos_app_ldr_v2/screens/photo_screen_selected.dart';
import 'package:photos_app_ldr_v2/servises/fetch_photos_list.dart';
import 'package:photos_app_ldr_v2/servises/precash_img.dart';

class GridScreenPhotos extends StatefulWidget {
  const GridScreenPhotos({Key? key}) : super(key: key);

  @override
  _GridScreenPhotosState createState() => _GridScreenPhotosState();
}

class _GridScreenPhotosState extends State<GridScreenPhotos> {
  late ScrollController _scrollController;

  int _itemsForNow = 10;
  bool endOfStory = false;
  bool isLoading = false;
  bool isFirstLoading = false;

  loadData() async {
    setState(() {
      isFirstLoading = true;
    });
    print(pht.length);

    await Future.wait(
        pht.map((photo) => PreCacheUtil.cacheImages(context, photo)).toList());

    //await Future.delayed(const Duration(seconds: 2));
    setState(() {
      isFirstLoading = false;
    });
  }

  void _scrollListener2() async {
    if (_scrollController.offset ==
        _scrollController.position.maxScrollExtent) {
      setState(() {
        isLoading = true;
      });

      // Пришлось добавить задержку,
      // иначе слишком быстро подгружает, не видно лоадер
      await Future.delayed(const Duration(seconds: 2));

      if (_itemsForNow != pht.length) {
        _itemsForNow += 10;
        print('_items++');
      } else {
        endOfStory = true;
      }
      isLoading = false;
      setState(() {});
    }
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener2);
    WidgetsBinding.instance?.addPostFrameCallback((_) => loadData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      controller: _scrollController,
      child: Column(
        children: [
          isFirstLoading
              ? const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(),
                )
              : GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: _itemsForNow, //_itemsForNow,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    PhotoScreen(imagePath: pht[index])));
                      },
                      child: CachedNetworkImage(
                        imageUrl: pht[index],
                        errorWidget: (context, url, error) => GestureDetector(
                            onTap: () {}, child: Image.asset('noPhoto.png')),
                      ),
                    );
                  }),
          if (isLoading)
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: CircularProgressIndicator(),
            ),
          Container(
            height: 60,
          ),
          if (endOfStory)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(
                  child: SizedBox(
                      height: 40,
                      child: Material(child: Text('End Of Story :((')))),
            )
        ],
      ),
    );
  }
}
