import 'package:dio/dio.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sbf_mobile_app/Constant.dart';
import 'package:sbf_mobile_app/CustomUI/CustomWidgets.dart';
import 'package:sbf_mobile_app/CustomUI/image_slider.dart';
import 'package:sbf_mobile_app/Util/isSimilar.dart';
import 'package:sbf_mobile_app/Util/path.dart';
import 'package:sbf_mobile_app/preferences/preferences.dart';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../../CustomUI/circular_network_image.dart';
import '../../CustomUI/snackBar.dart';
import '../../webservices.dart';

Widget VolunteerProfileDetails(
{
  required Map<String,dynamic> basicDetails,
  required Map<String,dynamic> documents ,

  required int step,
  required BuildContext context,
  required Function() onTap,
  required Function() onRefresh,
  required Function() localLevel,
  required Function() stateLevel,
  required Function() nationalLevel
}


    ) {
  TextStyle detailsStyle = const TextStyle(fontSize: 13);
  TextStyle active = const TextStyle(
      color: Colors.green, fontSize: 14, fontWeight: FontWeight.bold);
  TextStyle inactive = const TextStyle(
      color: Colors.red, fontSize: 14, fontWeight: FontWeight.bold);
  int? activeStep = step;
  bool canApproveState = isStringSimilar(
      basicDetails["state"].toString(), SessionManager.getString(Constant.state));


  print(step);
  return basicDetails.isEmpty
      ? const Center(
          child: Center(
              child: Text("You haven't applied for volunteer application")),
        )
      : Column(
          children: [
            Container(
              color: Colors.green,
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: const Center(
                  child: Text(
                "Volunteer Application",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              )),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        basicDetails["isActive"] == true
                            ? Text('Active', style: active)
                            : Text('Inactive', style: inactive),
                        Text('SBF id : ${basicDetails["SBF_id"].toString()}',
                            style: detailsStyle),
                        Text('Name : ${basicDetails["name"].toString()}',
                            style: detailsStyle),
                        Text('Date of Birth : ${basicDetails["dob"].toString()}',
                            style: detailsStyle),
                        Text('Blood group : ${basicDetails["blood_group"].toString()}',
                            style: detailsStyle),
                        Text('State : ${basicDetails["state"].toString()}',
                            style: detailsStyle),
                        Text('District : ${basicDetails["district"].toString()}',
                            style: detailsStyle),
                        Text('Pin code : ${basicDetails["pin_code"].toString()}',
                            style: detailsStyle),
                        Text(
                            'Contact Number : ${basicDetails["contact_no"].toString()}',
                            style: detailsStyle),
                        SizedBox(
                          width: 200,
                          child: Text(
                            'Whatsapp Number : ${basicDetails["whatsapp_no"].toString()}',
                            style: detailsStyle,
                            overflow: TextOverflow.clip,
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          child: Text(
                            'Email : ${basicDetails["email"].toString()}',
                            style: detailsStyle,
                            overflow: TextOverflow.clip,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        CircularNetworkImage(
                            imageUrl: getPath(path: basicDetails["SBF_id"]+"/photo",
                            ),
                            

                            fallbackImage: 'assets/images/user.png',
                            radius: 70, token: SessionManager.getString(Constant.access_token),),
                        SizedBox(height: 10),
                        SessionManager.getString(Constant.userType) == '0'
                            ? CustomWidget().basicButton(
                                width: 100,
                                height: 30,
                                text: 'Edit',
                                context: context,
                                onTap: () {
                                  showModalBottomSheet(
                                      constraints:
                                          const BoxConstraints(maxHeight: 150),
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
                                                                filename:
                                                                    image.name),
                                                  });
                                                  final dio = Dio();

                                                  Response response =
                                                      await dio.post(
                                                          '${Webservices.updateDocuments}?sbf_id=${basicDetails['SBF_id']}&documentType=photo',
                                                          data: formData);

                                                  if (response.statusCode ==
                                                          200 ||
                                                      response.statusCode ==
                                                          201) {
                                                    Navigator.pop(context);
                                                    String msg =
                                                        response.data["data"]
                                                            ['message'];
                                                    showSnackBar(
                                                        context: context,
                                                        text: msg);
                                                    onRefresh();
                                                  } else {
                                                    Navigator.pop(context);
                                                    showSnackBar(
                                                        context: context,
                                                        text: 'Error Occured');
                                                  }
                                                },
                                                child: const Padding(
                                                  padding: EdgeInsets.all(8.0),
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
                                                                filename:
                                                                    image.name),
                                                  });
                                                  final dio = Dio();

                                                  Response response =
                                                      await dio.post(
                                                          '${Webservices.updateDocuments}?sbf_id=${basicDetails['SBF_id']}&documentType=photo',
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
                                                    onRefresh();
                                                  } else {
                                                    Navigator.pop(context);
                                                    showSnackBar(
                                                        context: context,
                                                        text: 'Error Occured');
                                                  }
                                                },
                                                child: const Padding(
                                                  padding: EdgeInsets.all(8.0),
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
                                })
                            : Container()
                      ],
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Divider(thickness: 1),
            EasyStepper(
              activeStep: activeStep,
              activeStepTextColor: Colors.black87,
              finishedStepTextColor: Colors.black87,
              internalPadding: 30,
              fitWidth: true,
              finishedStepBackgroundColor: Colors.green,
              showLoadingAnimation: false,
              stepRadius: 15,
              showStepBorder: false,
              steps: [
                EasyStep(
                  customStep: CircleAvatar(
                    radius: 8,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 7,
                      backgroundColor:
                          activeStep >= 0 ? Colors.orange : Colors.white,
                    ),
                  ),
                  title: 'Local Level    ',
                ),
                EasyStep(
                  customStep: CircleAvatar(
                    radius: 8,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 7,
                      backgroundColor:
                          activeStep >= 1 ? Colors.orange : Colors.white,
                    ),
                  ),
                  title: 'State Level',
                  topTitle: false,
                ),
                EasyStep(
                  customStep: CircleAvatar(
                    radius: 8,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 7,
                      backgroundColor:
                          activeStep >= 2 ? Colors.orange : Colors.white,
                    ),
                  ),
                  title: 'National Level',
                ),
              ],
            ),
            const SizedBox(height: 10),
            activeStep > 2
                ? CustomWidget().basicButton(
                    text: "Download Id Card", onTap: onTap, context: context)
                : Container(),
            const SizedBox(height: 10),
            CustomWidget().basicButton(
                color: activeStep >= 1 ? Colors.green : Colors.orangeAccent,
                isConfirmation: true,
                text: 'Approve Local Level',
                context: context,
                onTap: localLevel),
            const SizedBox(height: 10),
            CustomWidget().basicButton(
                color: activeStep >= 2 ? Colors.green : Colors.orangeAccent,
                disabled: SessionManager.getString(Constant.userType) == '1'
                    ? true
                    : !canApproveState,
                isConfirmation: true,
                text: 'Approve State Level',
                context: context,
                onTap: stateLevel),
            const SizedBox(height: 10),
            CustomWidget().basicButton(
                color: activeStep >= 3 ? Colors.green : Colors.orangeAccent,
                disabled:
                    int.parse(SessionManager.getString(Constant.userType)) != 0,
                isConfirmation: true,
                text: 'Approve National Level',
                context: context,
                onTap: nationalLevel),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Documents',
                style: TextStyle(
                    color: Colors.purple,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            ComplicatedImageDemo(
                onUplaodDone: onRefresh,
                SBF_id: basicDetails["SBF_id"].toString(),
                imagesList: [
                  {
                    'label': 'Aadhaar Card',
                    'key': 'adhaar_card',
                    'file': documents["adhaar_card"].toString(),
                  },
                  {
                    'label': 'Qualification Documents',
                    'key': 'qualification_doc',
                    'file': documents["qualification_doc"].toString()
                  },
                  {
                    'label': 'Pan Card',
                    "key": "pan_card",
                    "file": documents["pan_card"].toString()
                  },
                  {
                    'label': 'Character Certificate',
                    'key': 'character_certificate',
                    "file": documents["character_certificate"].toString()
                  }
                ]),
            const SizedBox(height: 10),
          ],
        );
}



