import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:photo_view/photo_view.dart';

class GalleryPhotoViewWrapper extends StatefulWidget {
  GalleryPhotoViewWrapper({
    Key? key,
    this.loadingBuilder,
    this.backgroundDecoration,
    this.minScale,
    this.maxScale,
    this.initialIndex = 0,
    required this.galleryItems,
    this.scrollDirection = Axis.horizontal,
  })  : pageController = PageController(initialPage: initialIndex),
        super(key: key);

  final LoadingBuilder? loadingBuilder;
  final BoxDecoration? backgroundDecoration;
  final dynamic minScale;
  final dynamic maxScale;
  final int initialIndex;
  final PageController pageController;
  final galleryItems;
  final Axis scrollDirection;

  @override
  State<StatefulWidget> createState() {
    return _GalleryPhotoViewWrapperState();
  }
}

class _GalleryPhotoViewWrapperState extends State<GalleryPhotoViewWrapper> {
  late int currentIndex = widget.initialIndex;

  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_outlined,
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: Container(
        decoration: widget.backgroundDecoration,
        constraints: BoxConstraints.expand(
          height: MediaQuery.of(context).size.height,
        ),
        child: Stack(
          alignment: Alignment.bottomRight,
          children: <Widget>[
            PhotoViewGallery(
              pageOptions: [_buildItem()],
              // scrollPhysics: const BouncingScrollPhysics(),

              // itemCount: widget.galleryItems.length,
              // loadingBuilder: widget.loadingBuilder,
              backgroundDecoration: widget.backgroundDecoration,
              // pageController: widget.pageController,
              // onPageChanged: onPageChanged,
              // scrollDirection: widget.scrollDirection,
            ),
            Container(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "Image",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17.0,
                  decoration: null,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  PhotoViewGalleryPageOptions _buildItem() {
    final item = widget.galleryItems;
    return
        // item.isSvg
        PhotoViewGalleryPageOptions.customChild(
      child: Container(
        // width: 300,
        // height: 300,
        child: CachedNetworkImage(
          imageUrl: item,
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                image: imageProvider,
                // fit: BoxFit.cover,
              ),
            ),
          ),
          placeholder: (context, url) => const Center(
              child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
          )),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
      ),
      // childSize: const Size(300, 300),
      initialScale: PhotoViewComputedScale.contained,
      minScale: PhotoViewComputedScale.contained * (0.5 + 0 / 10),
      maxScale: PhotoViewComputedScale.covered * 4.1,
      heroAttributes: PhotoViewHeroAttributes(tag: item),
    );
    //   :
    //     PhotoViewGalleryPageOptions(
    //   imageProvider: CachedNetworkImage(
    //     imageUrl: item,
    //     imageBuilder: (context, imageProvider) =>
    //         Container(
    //           decoration: BoxDecoration(
    //             borderRadius:
    //             BorderRadius.circular(15),
    //             image: DecorationImage(
    //               image: imageProvider,
    //               fit: BoxFit.cover,
    //             ),
    //           ),
    //         ),
    //     placeholder: (context, url) => Center(
    //         child: CircularProgressIndicator(
    //           valueColor:
    //           new AlwaysStoppedAnimation<Color>(
    //               kPrimaryColor),
    //         )),
    //     errorWidget: (context, url, error) =>
    //         Icon(Icons.error),
    //   ),
    //   initialScale: PhotoViewComputedScale.contained,
    //   minScale: PhotoViewComputedScale.contained * (0.5 + index / 10),
    //   maxScale: PhotoViewComputedScale.covered * 4.1,
    //   heroAttributes: PhotoViewHeroAttributes(tag: item),
    // );
  }
}
