import 'dart:convert';

import 'package:extended_image/extended_image.dart';
import 'package:ganglong_shop_app/common_import.dart';
import 'package:ganglong_shop_app/data_model/goods_model.dart';
import 'package:ganglong_shop_app/models/goodsGalleryItem.dart';
import 'package:ganglong_shop_app/page/components/my_extended_image.dart';
import 'package:ganglong_shop_app/routes/application.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';

class GoodsTopSwiper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Consumer<GoodsModel>(
        builder: (BuildContext context, GoodsModel goodsModel, _) {
          return Swiper(
            itemCount: goodsModel.extraGoodsInfo.goods_gallery.length,
            autoplay: true,
            pagination: SwiperPagination(),
            itemBuilder: (BuildContext context, int index) {
              return MyExtendedImage.network(
                goodsModel.extraGoodsInfo.goods_gallery[index].img_url,
                fit: BoxFit.fitHeight,
              );
            },
            onTap: (index) {
              if (goodsModel.extraGoodsInfo.goods_gallery.length > 0) {
                List<Map<String, String>> imgUrlList = goodsModel
                    .extraGoodsInfo.goods_gallery
                    .map((GoodsGalleryItem galleryItem) {
                  return {"url": galleryItem.img_url};
                }).toList();
                String imgUrlListJson = jsonEncode(imgUrlList);
                Application.router.navigateTo(context,
                    '/pic_swiper?index=$index&imgUrlListCode=${base64UrlEncode(utf8.encode(imgUrlListJson))}');
              }
            },
          );
        },
      ),
    );
  }
}
