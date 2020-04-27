import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:ganglong_shop_app/common_import.dart';
import 'package:loading_indicator/loading_indicator.dart';

class MyExtendedImage {
  static Widget network(String url,
      {BoxFit fit,
      double width,
      double height,
      double loadingWidth = SO_SMALL_FONT_SIZE,
      double loadingHeight = SO_SMALL_FONT_SIZE}) {
    return ExtendedImage.network(
      url,
      width: width,
      height: height,
      cache: !DEBUG,
      fit: fit,
      loadStateChanged: (ExtendedImageState state) {
        switch (state.extendedImageLoadState) {
          case LoadState.loading:
            // TODO: Handle this case.
            return Container(
              color: Colors.black12,
            );
            break;
          case LoadState.completed:
            // TODO: Handle this case.
            return null;
            break;
          case LoadState.failed:
            // TODO: Handle this case.
            return GestureDetector(
              child: Image.asset('static_images/img_error.png'),
              onTap: () {
                state.reLoadImage();
              },
            );
            break;
          default:
            return null;
        }
      },
    );
  }

  static Widget asset(String url, {BoxFit fit, double width, double height}) {
    return ExtendedImage.asset(
      url,
      width: width,
      height: height,
      fit: fit,
      loadStateChanged: (ExtendedImageState state) {
        final double loadingWidth = width != null ? width : SO_SMALL_FONT_SIZE;
        switch (state.extendedImageLoadState) {
          case LoadState.loading:
            // TODO: Handle this case.
            return Container(
              width: loadingWidth,
              height: loadingWidth,
              child: LoadingIndicator(
                indicatorType: Indicator.ballClipRotatePulse,
                color: Colors.orange,
              ),
            );
            break;
          case LoadState.completed:
            // TODO: Handle this case.
            return null;
            break;
          case LoadState.failed:
            // TODO: Handle this case.
            return GestureDetector(
              child: Text(
                "",
                style: TextStyle(
                    fontSize: SO_SMALL_FONT_SIZE, color: Colors.black54),
                textAlign: TextAlign.center,
              ),
              onTap: () {
                state.reLoadImage();
              },
            );
            break;
          default:
            return null;
        }
      },
    );
  }
}
