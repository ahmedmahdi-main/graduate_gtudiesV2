import 'package:get/get.dart';

class PageStatus {
  String name;
  int index;
  RxBool isFull;

  PageStatus({
    required this.name,
    required this.index,
    required bool isFull,
  }) : isFull = RxBool(isFull);

  static String getClassName(Type type) {
    return type.toString();
  }

  static PageStatus fromType({
    required Type type,
    required int index,
    required bool isFull,
  }) {
    return PageStatus(
      name: getClassName(type),
      index: index,
      isFull: isFull,
    );
  }
}