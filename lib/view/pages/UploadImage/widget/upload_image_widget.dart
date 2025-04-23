import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../theme.dart';

class UploadImageWidget extends StatelessWidget {
  final Future<FilePickerResult?> Function() onTap;
  final FilePickerResult? image;
  final String title;
  final String? initialImage; // URL for the initial image

  const UploadImageWidget({
    super.key,
    required this.onTap,
    this.image,
    required this.title,
    this.initialImage, // URL is passed here for the initial image
  });

  @override
  Widget build(BuildContext context) {
    RxBool onHover = false.obs;
    return FormField<FilePickerResult>(
      validator: (filePickerResult) {
        if (filePickerResult == null && initialImage == null) {
          return 'يرجى اختيار صورة';
        }
        return null;
      },
      builder: (status) => Obx(() {
        return Tooltip(
          message: title,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: HeadLine1.apply(
                    color: status.hasError ? Colors.red : Colors.black),
              ),
              const SizedBox(
                height: 16,
              ),
              InkWell(
                onHover: (value) {
                  onHover.value = value;
                },
                onTap: () async {
                  var s = await onTap();
                  status.didChange(s);
                },
                child: Container(
                  height: 250,
                  width: context.width < 300 ? 150 : 400,
                  decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(blurRadius: 4, color: Colors.black54),
                    ],
                    color: onHover.value ? Colors.greenAccent : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: (image != null &&
                      image!.files.isNotEmpty &&
                      image!.files.single.bytes != null)
                      ? Image.memory(
                    image!.files.single.bytes!,
                    fit: BoxFit.contain,
                  )
                      : (initialImage != null)
                      ? Image.network(
                    initialImage!, // Display image from URL
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(
                        Icons.broken_image_outlined,
                        size: 150,
                        color: status.hasError ? Colors.red : Colors.black,
                      );
                    },
                  )
                      : Icon(
                    Icons.image_not_supported_outlined,
                    size: 150,
                    color: status.hasError ? Colors.red : Colors.black,
                  ),
                ),
              ),
              if (status.hasError)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    status.errorText ?? '',
                    style: const TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ),
            ],
          ),
        );
      }),
    );
  }
}
