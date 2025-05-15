import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// A responsive image upload widget that adapts to different screen sizes.
///
/// To display multiple widgets in a row on larger screens, use this widget
/// inside a GridView or Wrap widget with appropriate constraints.
///
/// Example usage in a responsive grid:
/// ```dart
/// GridView.builder(
///   gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
///     maxCrossAxisExtent: 400, // Adjust based on desired width
///     childAspectRatio: 0.8,
///     crossAxisSpacing: 16,
///     mainAxisSpacing: 16,
///   ),
///   itemCount: imageWidgets.length,
///   itemBuilder: (context, index) => imageWidgets[index],
/// )
/// ```
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
    // Get screen width to determine responsive behavior
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;
    final isMediumScreen = screenWidth >= 600 && screenWidth < 1200;
    final isLargeScreen = screenWidth >= 1200;

    // Calculate appropriate dimensions based on screen size
    // For desktop/web (large screens): 3 in a row
    // For tablet (medium screens): 2 in a row
    // For mobile (small screens): 1 in a row
    final cardWidth = isSmallScreen
        ? screenWidth * 0.9 // Mobile: 90% of screen width (1 per row)
        : isMediumScreen
            ? (screenWidth / 2) -
                24 // Tablet: 50% of screen width minus spacing (2 per row)
            : (screenWidth / 3) -
                32; // Desktop: 33% of screen width minus spacing (3 per row)

    final imageHeight = isSmallScreen ? 200.0 : 220.0;
    final fontSize = isSmallScreen ? 14.0 : 16.0;

    RxBool onHover = false.obs;
    return FormField<FilePickerResult>(
      validator: (filePickerResult) {
        if (filePickerResult == null && initialImage == null) {
          return 'يرجى اختيار صورة';
        }
        return null;
      },
      builder: (status) => Obx(() {
        final bool hasImage = image != null &&
            image!.files.isNotEmpty &&
            image!.files.single.bytes != null;
        final bool hasInitialImage = initialImage != null;
        final bool hasError = status.hasError;

        return Card(
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Container(
            width: cardWidth,
            constraints: BoxConstraints(
              maxWidth: 350, // Maximum width for any screen size
              minHeight: isSmallScreen ? 350 : 380,
            ),
            padding: EdgeInsets.all(isSmallScreen ? 12.0 : 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title section with icon
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.photo_library,
                        color: hasError ? Colors.red : Colors.green[700],
                        size: isSmallScreen ? 20 : 24,
                      ),
                      SizedBox(width: isSmallScreen ? 8 : 12),
                      Expanded(
                        child: Text(
                          title,
                          style: TextStyle(
                            fontSize: fontSize,
                            fontWeight: FontWeight.bold,
                            color: hasError ? Colors.red : Colors.black87,
                          ),
                        ),
                      ),
                      if (hasImage || hasInitialImage)
                        Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: isSmallScreen ? 16 : 20,
                        ),
                    ],
                  ),
                ),
                SizedBox(height: isSmallScreen ? 12 : 16),
                // Image container
                InkWell(
                  onHover: (value) {
                    onHover.value = value;
                  },
                  onTap: () async {
                    var s = await onTap();
                    status.didChange(s);
                  },
                  child: Container(
                    height: imageHeight,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(blurRadius: 4, color: Colors.black26),
                      ],
                      color: onHover.value ? Colors.green[50] : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: onHover.value
                            ? Colors.green
                            : (hasError ? Colors.red[300]! : Colors.grey[300]!),
                        width: 2,
                      ),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Image display
                        if (hasImage)
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.memory(
                              image!.files.single.bytes!,
                              fit: BoxFit.contain,
                            ),
                          )
                        else if (hasInitialImage)
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              initialImage!,
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.broken_image_outlined,
                                      size: 80,
                                      color: hasError
                                          ? Colors.red
                                          : Colors.grey[600],
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      'تعذر تحميل الصورة',
                                      style: TextStyle(color: Colors.grey[700]),
                                    ),
                                  ],
                                );
                              },
                            ),
                          )
                        else
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add_photo_alternate_outlined,
                                size: 80,
                                color: hasError
                                    ? Colors.red[400]
                                    : Colors.grey[400],
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'اضغط لاختيار صورة',
                                style: TextStyle(
                                  color:
                                      hasError ? Colors.red : Colors.grey[700],
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),

                        // Hover overlay
                        if (onHover.value)
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 16),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                        hasImage || hasInitialImage
                                            ? Icons.edit
                                            : Icons.add_photo_alternate,
                                        color: Colors.green[700]),
                                    const SizedBox(width: 8),
                                    Text(
                                      hasImage || hasInitialImage
                                          ? 'تغيير الصورة'
                                          : 'اختيار صورة',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green[700],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                // Error message
                if (hasError)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      children: [
                        const Icon(Icons.error_outline,
                            color: Colors.red, size: 16),
                        const SizedBox(width: 8),
                        Text(
                          status.errorText ?? '',
                          style:
                              const TextStyle(color: Colors.red, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                // Help text
                if (!hasError)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      hasImage || hasInitialImage
                          ? 'اضغط على الصورة لتغييرها'
                          : 'يرجى اختيار صورة بصيغة JPG أو PNG',
                      style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: isSmallScreen ? 10 : 12),
                      textAlign: TextAlign.center,
                    ),
                  ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
