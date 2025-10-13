import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:sbf_mobile_app/Constant.dart';
import 'package:sbf_mobile_app/CustomUI/Appbar.dart';
import 'package:sbf_mobile_app/CustomUI/CustomWidgets.dart';
import 'package:sbf_mobile_app/CustomUI/application_instructions.dart';
import 'package:sbf_mobile_app/CustomUI/form_field.dart';
import 'package:sbf_mobile_app/CustomUI/snackBar.dart';
import 'package:sbf_mobile_app/Screens/SBF/volunteerForm/volunteer_preferences.dart';
import 'package:sbf_mobile_app/Util/http_request.dart';
import 'package:sbf_mobile_app/preferences/preferences.dart';
import 'package:sbf_mobile_app/webservices.dart';
import 'package:intl/intl.dart';

class VolunteerBasicDetails extends StatefulWidget {
  const VolunteerBasicDetails({super.key});



  @override
  State<VolunteerBasicDetails> createState() => _VolunteerBasicDetailsState();

}





class _VolunteerBasicDetailsState extends State<VolunteerBasicDetails> {
  final _formKey = GlobalKey<FormBuilderState>();
  DateFormat dateFormat = DateFormat("dd/MM/yyyy");
  final Dio dio = Dio();

  List<String> states = [
    'Assam North',
    'Assam South',
    'Bihar',
    'Chattisgarh',
    'Delhi',
    'Gujarat',
    'Haryana',
    'Jharkhand',
    'Telangana',
    'Madhya Pradesh',
    'Punjab',
    'Rajasthan',
    'UP east',
    'UP west',
    'Utrakhand',
    'West Bengal'
  ];


  @override
  Widget build(BuildContext context) {
  return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            appBar(context),
            Container(color: Colors.green,width: double.infinity,height: 50,
              child:const Center(child:  Text("Volunteer Application 1/3",style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),)),
            ),
            instruction(),

            FutureBuilder(future: fetchData(), builder: (BuildContext context, snapshot){
              if(snapshot.connectionState==ConnectionState.done){
               if(snapshot.hasData){
                 final f1 = jsonEncode(snapshot.data);
                 final initialData = jsonDecode(f1);
                 print(initialData);
                 bool enabled = false ;
                 if(initialData.isNotEmpty){
                   enabled = true ;
                 }
                 return FormBuilder(
                   enabled: !enabled,
                   key: _formKey,
                   child: Column(
                     children: [
                       //   formField(enabled:false,label: 'SBF id', name : 'id'),
                       formField(enabled:false,label: 'SBF id', name : 'SBF_id',initialValue : SessionManager.getString(Constant.SBFID)),
                       formField(label: 'Name', name : 'name',initialValue : SessionManager.getString(Constant.name)),
                       const SizedBox(height: 10),
                       formField(label: 'Email', name : 'email',initialValue: SessionManager.getString(Constant.email)),
                       const SizedBox(height: 10),
                       dateField(label: 'Date of birth', name : 'dob',initialValue: initialData.isEmpty?null:dateFormat.parse(initialData["dob"] )),
                       const SizedBox(height: 10),
                       dropDownField(
                         required:  false,

                           label: 'Blood Group', name : 'blood_group', items: [
                         "A+",
                         "A-",
                         "B+",
                         "B-",
                         "AB+",
                         "AB-",
                         "O+",
                         "O-"
                       ],
                           initialValue: initialData?["blood_group"]
                       ),
                       const SizedBox(height: 10),
                       formField(label: 'Contact Number', name : 'contact_no', type: TextInputType.number,
                           initialValue: initialData?["contact_no"].toString()
                       ),
                       const SizedBox(height: 10),
                       formField(label: 'Whatsapp Number', name : 'whatsapp_no', type: TextInputType.number,
                           initialValue: initialData?["whatsapp_no"].toString()
                       ),

                       const SizedBox(height: 10),
                       formField(label: 'Block/Tehsil/Ward', name : 'block',initialValue:initialData?["block"]),


                       const SizedBox(height: 10),
                       formField(label: 'District', name : 'district',initialValue:initialData?["district"]),

                       const SizedBox(height: 10),
                       dropDownField(label: 'State', name : 'state',initialValue:initialData?["state"], items: states ),

                       const SizedBox(height: 10),
                       formField(label: 'Pin code', name : 'pin_code', type: TextInputType.number,initialValue:initialData?["pin_code"].toString()),
                       const SizedBox(height: 10),
                       const SizedBox(height: 20),
                       enabled ?
                       CustomWidget().basicButton(text: 'Next', onTap: (){
                         Navigator.push(context,
                             MaterialPageRoute(builder: (context) => const VolunteerPreferences()));
                       },
                           color: Colors.green, context: context
                       ):
                       CustomWidget().basicButton(text: 'Save', onTap: (){
                         _formKey.currentState?.saveAndValidate();

                         // On another side, can access all field values without saving form with instantValues
                         _formKey.currentState?.validate();
                         if(_formKey.currentState!.isValid) {
                           saveData();
                         }

                       }, context: context),
                       const SizedBox(height: 50)
                     ],
                   ),
                 );
               }
               else if (snapshot.hasError) {
                 return const Center(child: Text("Some error occured"));
               }

              }
              return const CircularProgressIndicator();


            })
          ],
        ),
      ),
    ));
  }

  Future<void> saveData() async {
    Map<String,dynamic> payload = _formKey.currentState!.value;
    postRequest(payload: payload, endPoint: Webservices.basicDetails, 
        bearerToken: SessionManager.getString(Constant.access_token)
        ,onSuccess: (res){
      showSnackBar(context: context, text: res["message"]);
      if(res["status"]==true){
       setState(() {
         Navigator.push(context,
             MaterialPageRoute(builder: (context) =>  VolunteerPreferences()));
       });
      }

    },
        onError: (res){
          showSnackBar(context: context, text: res["message"]);

        },
        context: context);
  }

  Future<Map<String, dynamic>?> fetchData() async {
    try {
      print(Webservices.getVolunteer);
      Response response = await dio.get(Webservices.getVolunteer,
          options: Options(headers: {
            "Authorization": "Bearer ${SessionManager.getString(Constant.access_token)}"
          }),
          data: {"SBF_id": SessionManager.getString(Constant.SBFID)});
      if (response.statusCode == 200 || response.statusCode == 201) {

        if (response.data["status"] == true) {
          return response.data["data"]["basicDetails"];
        } else {
          return {};
        }
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print(e);
      // Handle Dio errors
      if (e is DioException) {
        // Handle Dio-specific errors
        if (e.response != null) {
          print('Dio error: ${e.response?.data}');
          print('Dio error: ${e.response?.headers}');
          print('Dio error: ${e.response?.requestOptions}');
        } else {
          // Something happened in setting up or sending the request that triggered an Error
          print('Dio error: ${e.message}');
        }
      } else {
        // Handle general errors
        print('Error: $e');
      }
      return null;
    }
  }
  // getData(){
  //   postRequest(payload: {"SBF_id":SessionManager.getString(Constant.SBFID)}, endPoint: Webservices.isBasicDetailsFilled, onSuccess: (res){
  //
  //       setState(() {
  //         initialData = res["data"];
  //         if(res["data"].isNotEmpty){
  //           saved = true;
  //         }
  //       });
  //
  //
  //
  //   },
  //       onError: (res){
  //         showSnackBar(context: context, text: res["message"]);
  //
  //       },
  //       context: context);
  // }
}
