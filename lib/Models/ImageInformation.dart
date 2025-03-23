
import 'package:dio/dio.dart' as dioo;
class ImageInformation{
  final String imageName;
  final dioo.MultipartFile? image;

  ImageInformation(this.imageName, this.image);

}