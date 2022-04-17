import 'package:flutter/cupertino.dart';
import 'package:have_you_heard/constants/values.dart';

enum LayoutReference {
  xSmallPhone,
  smallPhone,
  phone,
  largePhone,
  portraitTablet,
  landscapeTablet
}

class LayoutUtility {
  const LayoutUtility(this.query);

  final MediaQueryData query;

  LayoutReference getScreenReference() {
    if (query.size.width < kSmallPhoneWidth) {
      return LayoutReference.xSmallPhone;
    } else if (query.size.width < kPhoneWidth) {
      return LayoutReference.smallPhone;
    } else if (query.size.width < kLargePhoneWidth) {
      return LayoutReference.phone;
    } else if (query.size.width < kPortraitTabletWidth) {
      return LayoutReference.largePhone;
    } else {
      return (query.orientation == Orientation.landscape)
          ? LayoutReference.landscapeTablet
          : LayoutReference.portraitTablet;
    }
  }

  bool isTablet() {
    if (query.size.width >= 600) {
      //in android ref 99.96% of phones in portrait is smaller than 600
      return true;
    }
    return false;
  }

  double getWidthScale() {
    final reference = getScreenReference();
    final queryWidth = query.size.width;
    switch (reference) {
      case LayoutReference.xSmallPhone:
        return queryWidth / kXSmallPhoneWidth;
      case LayoutReference.smallPhone:
        return queryWidth / kSmallPhoneWidth;
      case LayoutReference.phone:
        return queryWidth / kPhoneWidth;
      case LayoutReference.largePhone:
        return queryWidth / kLargePhoneWidth;
      case LayoutReference.portraitTablet:
        return queryWidth / kPortraitTabletWidth;
      case LayoutReference.landscapeTablet:
        return queryWidth / kLandscapeTabletWidth;
    }
  }

  double getHeightScale() {
    final reference = getScreenReference();
    final queryHeight = query.size.height;
    switch (reference) {
      case LayoutReference.xSmallPhone:
        return queryHeight / kXSmallPhoneHeight;
      case LayoutReference.smallPhone:
        return queryHeight / kSmallPhoneHeight;
      case LayoutReference.phone:
        return queryHeight / kPhoneHeight;
      case LayoutReference.largePhone:
        return queryHeight / kLargePhoneHeight;
      case LayoutReference.portraitTablet:
        return queryHeight / kPortraitTabletHeight;
      case LayoutReference.landscapeTablet:
        return queryHeight / kLandscapeTabletHeight;
    }
  }
}
