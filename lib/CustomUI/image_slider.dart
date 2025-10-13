import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sbf_mobile_app/CustomUI/secure_image.dart';
import 'package:sbf_mobile_app/CustomUI/snackBar.dart';
import 'package:sbf_mobile_app/Util/http_request.dart';
import 'package:sbf_mobile_app/Util/path.dart';
import 'package:sbf_mobile_app/webservices.dart';

import '../Constant.dart';
import '../preferences/preferences.dart';

class ComplicatedImageDemo extends StatelessWidget {
  final List imagesList;
  final String SBF_id;
  final Function() onUplaodDone;

  const ComplicatedImageDemo(
      {super.key,
      required this.imagesList,
      required this.SBF_id,
      required this.onUplaodDone});

  @override
  Widget build(BuildContext context) {
    print(SBF_id);
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: false,
        aspectRatio: 1.0,
        enlargeCenterPage: true,
      ),
      items: imagesList
          .map((item) => Container(
                margin: const EdgeInsets.all(5.0),
                child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                    child: Stack(
                      children: <Widget>[
                        SecureImage(
                            imageUrl: getPath(path: "$SBF_id/" + item['key']),
                            token: SessionManager.getString(
                                Constant.access_token)),

                        // Image.network(
                        //   getPath(path: "$SBF_id/" +item['key']),
                        //   fit: BoxFit.cover,
                        //   width: 1000.0,
                        //   errorBuilder: (BuildContext context, Object error,
                        //       StackTrace? stackTrace) {
                        //     return Image.asset(
                        //       'assets/images/notfound.png',
                        //       fit: BoxFit.cover,
                        //     );
                        //   },
                        // ),
                        Positioned(
                          bottom: 0.0,
                          left: 0.0,
                          right: 0.0,
                          child: Container(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color.fromARGB(200, 0, 0, 0),
                                  Color.fromARGB(0, 0, 0, 0)
                                ],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 20.0),
                            child: Text(
                              item['label'].toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SessionManager.getString(Constant.userType) == '0'
                            ? Positioned(
                                right: 1,
                                child: GestureDetector(
                                  onTap: () {
                                    showModalBottomSheet(
                                        constraints: const BoxConstraints(
                                            maxHeight: 150),
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                GestureDetector(
                                                  onTap: () async {
                                                    XFile? image =
                                                        await ImagePicker()
                                                            .pickImage(
                                                                source:
                                                                    ImageSource
                                                                        .camera);

                                                    var formData =
                                                        FormData.fromMap({
                                                      'document':
                                                          await MultipartFile
                                                              .fromFile(
                                                                  image!.path,
                                                                  filename: image
                                                                      .name),
                                                    });
                                                    final dio = Dio();

                                                    Response response =
                                                        await dio.post(
                                                            '${Webservices.updateDocuments}?sbf_id=$SBF_id&documentType=${item["key"]}',
                                                            data: formData);

                                                    if (response.statusCode ==
                                                            200 ||
                                                        response.statusCode ==
                                                            201) {
                                                      Navigator.pop(context);
                                                      String msg = response
                                                          .data['message'];
                                                      showSnackBar(
                                                          context: context,
                                                          text: msg);
                                                      onUplaodDone();
                                                    } else {
                                                      Navigator.pop(context);
                                                      showSnackBar(
                                                          context: context,
                                                          text:
                                                              'Error Occured');
                                                    }
                                                  },
                                                  child: const Padding(
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    child: Row(
                                                      children: [
                                                        Icon(Icons.camera),
                                                        SizedBox(width: 10),
                                                        Text('Camera')
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 20),
                                                GestureDetector(
                                                  onTap: () async {
                                                    XFile? image =
                                                        await ImagePicker()
                                                            .pickImage(
                                                                source:
                                                                    ImageSource
                                                                        .gallery);

                                                    var formData =
                                                        FormData.fromMap({
                                                      'document':
                                                          await MultipartFile
                                                              .fromFile(
                                                                  image!.path,
                                                                  filename: image
                                                                      .name),
                                                    });
                                                    final dio = Dio();

                                                    Response response =
                                                        await dio.post(
                                                            '${Webservices.updateDocuments}?sbf_id=$SBF_id&documentType=${item["key"]}',
                                                            data: formData);

                                                    if (response.statusCode ==
                                                            200 ||
                                                        response.statusCode ==
                                                            201) {
                                                      Navigator.pop(context);
                                                      String msg = response
                                                          .data['message'];
                                                      showSnackBar(
                                                          context: context,
                                                          text: msg);
                                                      onUplaodDone();
                                                    } else {
                                                      Navigator.pop(context);
                                                      showSnackBar(
                                                          context: context,
                                                          text:
                                                              'Error Occured');
                                                    }
                                                  },
                                                  child: const Padding(
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    child: Row(
                                                      children: [
                                                        Icon(Icons.upload),
                                                        SizedBox(width: 10),
                                                        Text('Upload')
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          );
                                        });
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      child: Icon(
                                        Icons.edit,
                                        size: 20,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : Container(),
                        // GestureDetector(
                        //   onTap: onUplaodDone,
                        //   child: const Padding(
                        //     padding: EdgeInsets.all(8.0),
                        //     child: CircleAvatar(
                        //       backgroundColor: Colors.white,
                        //       child: Icon(
                        //         Icons.edit,
                        //         size: 20,
                        //         color: Colors.blue,
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    )),
              ))
          .toList(),
    );
  }
}
