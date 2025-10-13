import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:sbf_mobile_app/Constant.dart';
import 'package:sbf_mobile_app/CustomUI/CustomWidgets.dart';
import 'package:sbf_mobile_app/CustomUI/form_field.dart';
import 'package:sbf_mobile_app/CustomUI/nav_bar.dart';
import 'package:sbf_mobile_app/preferences/preferences.dart';

import '../../../CustomUI/Appbar.dart';
import '../../../CustomUI/snackBar.dart';
import '../../../Home.dart';
import '../../../Util/http_request.dart';
import '../../../webservices.dart';



class VolunteerDocuments extends StatefulWidget {
  const VolunteerDocuments({super.key});

  @override
  State<VolunteerDocuments> createState() => _VolunteerDocumentsState();
}

class _VolunteerDocumentsState extends State<VolunteerDocuments> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                appBar(context),
                Container(color: Colors.green,width: double.infinity,height: 50,
                  child:const Center(child:  Text("Volunteer Application 3/3",style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),)),
                ),
                FormBuilder(
                  key: _formKey,
                  child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [

                      Row(
                        children: [
                          fileUploadField(required: true, name: 'photo', label: "Photo", context: context),

                          fileUploadField( required: true, name: 'qualification_doc', label: "Qualification Docs", context: context),

                        ],
                      ),
                     Row(
                       children: [
                         fileUploadField(name: 'pan_card', label: "Pan Card", context: context),
                         fileUploadField(required: true, name: 'adhaar_card', label: "Aadhaar Card", context: context),

                       ],
                     ),
                     Row(
                       children: [
                         fileUploadField(name: 'character_certificate', label: "Character Certificate ", context: context),
//$2b$10$jfGmsJkxuSpsuK2hbW7uL.ET2WcbIsGbKYsZSzLt2e4ZoZhOK6e06
                       ],
                     ),
                     const SizedBox(height: 40),
                     Align(
                       alignment: Alignment.center,
                       child: CustomWidget().basicButton(text: "Save", onTap: (){
                         _formKey.currentState?.save();
                         _formKey.currentState?.validate();
                         print(_formKey.currentState?.isValid);




                         if (_formKey.currentState!.isValid) {
                           saveData(SessionManager.getString(Constant.SBFID));
                         }
                         else {
                           showSnackBar(context: context, text: 'Upload All the files');
                         }
                       }, context: context),
                     )
                   ],
                  ),
                )
              ],
            ),
          ),
        ));
  }

  saveData(id)async{
    Map<String, dynamic>? files = _formKey.currentState!.instantValue;
    var formData = FormData.fromMap({
      'photo': await MultipartFile.fromFile(files["photo"][0].path, filename:files["photo"][0].name ),
      'pan_card': files["pan_card"]==null ? 'null' : await MultipartFile.fromFile(files["pan_card"]?[0].path, filename:files["pan_card"]?[0].name ),
      'adhaar_card': await MultipartFile.fromFile(files["adhaar_card"][0].path, filename:files["adhaar_card"][0].name ),
      'character_certificate': files["character_certificate"]==null ? 'null' :await MultipartFile.fromFile(files["character_certificate"]?[0].path, filename:files["character_certificate"]?[0].name ),
      'qualification_doc': await MultipartFile.fromFile(files["qualification_doc"][0].path, filename:files["qualification_doc"][0].name ),
      'SBF_id': id
    });

    try{
      print('${Webservices.uploadDocuments}$id');
      final response = await Dio().post(
        options: Options(headers: {
          "Authorization": "Bearer ${SessionManager.getString(Constant.access_token)}"
        }),
        '${Webservices.uploadDocuments}?id=$id',
        data: formData,
      );
      if (response.statusCode == 200 || response.statusCode==201) {
        var map = response.data as Map;
        if (map['status'] == true) {
          showSnackBar(context: context, text: map["message"]);
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const NavBar(initialPage: 1,)),
                  (Route<dynamic> route) => false);
          return true;
        } else {
          showSnackBar(context: context, text: map["message"]);
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const NavBar(initialPage: 1,)),
                  (Route<dynamic> route) => false);
          return false;
        }
      } else {
        //BotToast is a package for toasts available on pub.dev
        showSnackBar(context: context, text: 'Error');
        throw Exception('Error');
        return false;
      }
    }catch (e) {

      // Handle Dio errors
      if (e is DioException) {
        // Handle Dio-specific errors
        if (e.response != null) {
          showSnackBar(context: context, text: e.response!.data["message"]);
        } else {
          // Something happened in setting up or sending the request that triggered an Error
          showSnackBar(context: context, text: e.message!);

        }
      } else {
        // Handle general errors
        print('Error: $e');
      }
      return null;
    }




  }
}



















