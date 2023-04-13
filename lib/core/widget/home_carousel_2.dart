// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
//
//
// import 'Carousel.dart';
//
// class HomeCarouselHomePage extends StatefulWidget {
//   HomeViewModel? homeViewModel;
//   HomeCarouselHomePage(this.homeViewModel, {super.key});
//
//   @override
//   HomeCarousel1 createState() => HomeCarousel1();
// }
//
// class HomeCarousel1 extends State<HomeCarouselHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: MediaQuery.of(context).size.width,
//       height: 180.0,
//       child: ClipRRect(
//           borderRadius: BorderRadius.circular(10),
//           child: widget.homeViewModel!.homeCoreModel!.sliders!.isNotEmpty
//               ? Carousel(
//                   overlayShadow: false,
//                   borderRadius: true,
//                   boxFit: BoxFit.none,
//                   overlayShadowColors: Colors.transparent,
//                   dotBgColor: Colors.transparent,
//                   dotColor: Colors.white,
//                   dotIncreasedColor: Colors.black,
//                   dotIncreaseSize: 5.0,
//                   showIndicator: true,
//                   dotSpacing: 10,
//                   autoplay: true,
//                   dotSize: double.parse(widget
//                       .homeViewModel!.homeCoreModel!.sliders!.length
//                       .toString()),
//                   images: widget.homeViewModel!.homeCoreModel!.sliders!
//                       .map((element) {
//                     return Builder(
//                       builder: (BuildContext context) {
//                         return Container(
//                             width: MediaQuery.of(context).size.width,
//                             margin: const EdgeInsets.symmetric(horizontal: 5.0),
//                             decoration:
//                                 const BoxDecoration(color: Colors.transparent),
//                             child: FittedBox(
//                               fit: BoxFit.fill,
//                               child: CachedNetworkImage(
//                                 imageUrl: element.image!,
//                                 errorWidget: (context, url, error) =>
//                                     const Icon(Icons.error),
//                               ),
//                             ));
//                       },
//                     );
//                   }).toList(),
//                 )
//               : ClipRRect(
//             child: Image.network(
//               "https://karazonline.com/public/upload/slider/202212272110578409647.jpg",height: 200,  fit: BoxFit.fill,),
//           )),
//     );
//   }
//
//   void imgg(int g) {}
// }
