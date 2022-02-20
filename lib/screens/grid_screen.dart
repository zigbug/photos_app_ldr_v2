import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photos_app_ldr_v2/screens/photo_screen_selected.dart';
import 'package:photos_app_ldr_v2/servises/fetch_photos_list.dart';

class GridScreenPhotos extends StatefulWidget {
  const GridScreenPhotos({Key? key}) : super(key: key);

  @override
  _GridScreenPhotosState createState() => _GridScreenPhotosState();
}

class _GridScreenPhotosState extends State<GridScreenPhotos> {
  late ScrollController _scrollController;

  int _itemsForNow = 10;
  int maxItems = photos.length;
  bool endOfStory = false;
  bool isLoading = false;
  late List<CachedNetworkImage> list;

  void _scrollListener2() async {
    if (_scrollController.offset ==
        _scrollController.position.maxScrollExtent) {
      setState(() {
        isLoading = true;
      });
      // Пришлось добавить задержку,
      // иначе слишком быстро подгружает, не видно лоадер
      await Future.delayed(const Duration(seconds: 1));
      if (_itemsForNow < maxItems) {
        for (int i = _itemsForNow; i < _itemsForNow + 10; i++) {
          list.add(CachedNetworkImage(
            imageUrl: photos[i],
            errorWidget: (context, url, error) => GestureDetector(
                onTap: () {}, child: Image.asset('noPhoto.png')),
          ));
          print(list.length);
        }
      }
      setState(() {
        if (_itemsForNow != maxItems) {
          _itemsForNow += 10;
        } else {
          endOfStory = true;
        }
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
        print('Reach the bottom');
      });
    }
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener2);
    list = [];
    for (int i = 0; i < _itemsForNow; i++) {
      list.add(CachedNetworkImage(
        imageUrl: photos[i],
        // progressIndicatorBuilder: (context, url, downloadProgress) => Center(
        //   child: CircularProgressIndicator(value: downloadProgress.progress),
        // ),
        errorWidget: (context, url, error) =>
            GestureDetector(onTap: () {}, child: Image.asset('noPhoto.png')),
      ));
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      controller: _scrollController,
      child: Column(
        children: [
          GridView.builder(
              shrinkWrap: true,
              itemCount: _itemsForNow,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, mainAxisSpacing: 8, crossAxisSpacing: 8),
              itemBuilder: (context, index) {
                return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  PhotoScreen(imagePath: photos[index])));
                    },
                    child: list[index]
                    // CachedNetworkImage(
                    //   imageUrl: photos[index],
                    //   progressIndicatorBuilder:
                    //       (context, url, downloadProgress) => Center(
                    //     child: CircularProgressIndicator(
                    //         value: downloadProgress.progress),
                    //   ),
                    //   errorWidget: (context, url, error) => GestureDetector(
                    //       onTap: () {}, child: Image.asset('noPhoto.png')),
                    // ),
                    );
              }),
          if (isLoading)
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: CircularProgressIndicator(),
            ),
          // ),
          // if (isLoading)
          //   const Padding(
          //     padding: EdgeInsets.all(10.0),
          //     child: CircularProgressIndicator(),
          //   ),
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
