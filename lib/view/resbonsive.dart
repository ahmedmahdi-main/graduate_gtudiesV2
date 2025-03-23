// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'package:flutter/material.dart';

enum DeviceType { Desktop, Tablet, Mobile }

class DeviceInfo {
  final Orientation? orientation;
  final DeviceType? deviceType;
  final double? screenWidth;
  final double? ScrrenHeight;
  final double? localWidth;
  final double? localHeight;
  DeviceInfo(
      {this.ScrrenHeight,
      this.deviceType,
      this.localHeight,
      this.localWidth,
      this.orientation,
      this.screenWidth});
}

DeviceType getDeviceType(MediaQueryData mediaQueryData) {
  Orientation orientation = mediaQueryData.orientation;
  double width = 0;
  if (orientation == Orientation.landscape) {
    width = mediaQueryData.size.height;
  } else {
    width = mediaQueryData.size.width;
  }
  if (width > 950) {
    return DeviceType.Desktop;
  } else if (width > 600) {
    return DeviceType.Tablet;
  } else {
    return DeviceType.Mobile;
  }
}

class infoWidget extends StatelessWidget {
  final Widget Function(BuildContext context, DeviceInfo deviceInfo) builder;
  const infoWidget({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constrains) {
      var mediaQueryData = MediaQuery.of(context);
      var deviceInfo = DeviceInfo(
          ScrrenHeight: mediaQueryData.size.height,
          deviceType: getDeviceType(mediaQueryData),
          localHeight: constrains.maxHeight,
          localWidth: constrains.maxWidth,
          orientation: mediaQueryData.orientation,
          screenWidth: mediaQueryData.size.width);
      return builder(context, deviceInfo);
    });
  }
}

class Resbonsive extends StatelessWidget {
  final Widget Desktop;
  final Widget Tablet;
  final Widget Mobile;
  const Resbonsive(
      {super.key,
      required this.Desktop,
      required this.Mobile,
      required this.Tablet});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return Mobile;
        }
        if (constraints.maxWidth < 1100) {
          return Tablet;
        } else {
          return Desktop;
        }
      },
    );
  }
}
