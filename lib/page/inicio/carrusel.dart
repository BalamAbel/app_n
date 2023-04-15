import 'package:banner_carousel/banner_carousel.dart';
import 'package:flutter/material.dart';

class Carrusel extends StatelessWidget {
  const Carrusel({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BannerCarousel(
        banners: listBanners,
        customizedIndicators: const IndicatorModel.animation(
            width: 20, height: 5, spaceBetween: 2, widthAnimation: 50),
        //height: 120,
        activeColor: Colors.amberAccent,
        disableColor: Colors.white,
        animation: true,
        //borderRadius: 10,
        width: double.infinity,
        indicatorBottom: false,
      ),
    );
  }
}

List<BannerModel> listBanners = [
  BannerModel(
      imagePath:
          "https://imagenes.lainformacion.com/files/image_656_370/uploads/imagenes/2018/12/15/5c14da80ed56f.jpeg",
      id: "1"),
  BannerModel(
      imagePath:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQWNkBAFB9BX4Xe9GVZyI33XRc_0ut0yLBW5g&usqp=CAU",
      id: "2"),
  BannerModel(
      imagePath:
          "https://www.vivaelcole.com/blog/wp-content/uploads/2022/12/LIQUIDACION-2022-blog.jpg",
      id: "3"),
  BannerModel(
      imagePath:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQKROIdi4VsTbCaaP4q3TtpQbr7OIokzRGfgtzBbWWclcdWRXNtORFOb7GWB-UFPIwz8jQ&usqp=CAU",
      id: "4"),
];
