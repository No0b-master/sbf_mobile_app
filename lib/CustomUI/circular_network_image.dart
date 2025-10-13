
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class CircularNetworkImage extends StatefulWidget {
  final String imageUrl;
  final String fallbackImage;
  final double radius;
  final String token;

  const CircularNetworkImage({
    super.key,
    required this.imageUrl,
    required this.fallbackImage,
    required this.radius,
    required this.token,
  });

  @override
  State<CircularNetworkImage> createState() => _CircularNetworkImageState();
}

class _CircularNetworkImageState extends State<CircularNetworkImage> {
  Uint8List? imageBytes;
  bool hasError = false;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  Future<void> _loadImage() async {
    try {
      final dio = Dio();
      final response = await dio.get<List<int>>(
        widget.imageUrl,
        options: Options(
          responseType: ResponseType.bytes,
          headers: {
            'Authorization': 'Bearer ${widget.token}',
          },
        ),
      );

      setState(() {
        imageBytes = Uint8List.fromList(response.data!);
        isLoading = false;
      });
    } catch (_) {
      if(mounted){
        setState(() {
          hasError = true;
          isLoading = false;
        });
      }

    }
  }

  @override
  Widget build(BuildContext context) {
    final double size = widget.radius * 2;

    Widget imageWidget;
    if (hasError || imageBytes == null) {
      imageWidget = Image.asset(
        widget.fallbackImage,
        fit: BoxFit.cover,
        width: size,
        height: size,
      );
    } else {
      imageWidget = Image.memory(
        imageBytes!,
        fit: BoxFit.cover,
        width: size,
        height: size,
      );
    }

    return CircleAvatar(
      radius: widget.radius,
      backgroundColor: Colors.grey[200],
      child: ClipOval(child: imageWidget),
    );
  }
}
