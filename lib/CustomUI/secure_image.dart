import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class SecureImage extends StatefulWidget {
  final String imageUrl;
  final String token;

  const SecureImage({
    super.key,
    required this.imageUrl,
    required this.token,
  });

  @override
  State<SecureImage> createState() => _SecureImageState();
}

class _SecureImageState extends State<SecureImage> {
  Uint8List? imageBytes;
  bool isLoading = true;
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    _fetchImage();
  }

  Future<void> _fetchImage() async {
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
    } catch (e) {
      setState(() {
        hasError = true;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const SizedBox(
        height: 200,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (hasError || imageBytes == null) {
      return Image.asset(
        'assets/images/notfound.png',
        fit: BoxFit.fill,
      );
    }

    return Image.memory(
      imageBytes!,
      fit: BoxFit.cover,
      width: 1000.0,
    );
  }
}
