import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:sbf_mobile_app/CustomUI/Appbar.dart';
import 'package:sbf_mobile_app/Screens/SBF/volunteerForm/volunteer_documents.dart';

import '../../../Constant.dart';
import '../../../CustomUI/CustomWidgets.dart';
import '../../../CustomUI/form_field.dart';
import '../../../CustomUI/snackBar.dart';
import '../../../Util/http_request.dart';
import '../../../preferences/preferences.dart';
import '../../../webservices.dart';

class VolunteerPreferences extends StatefulWidget {
  const VolunteerPreferences({super.key});

  @override
  State<VolunteerPreferences> createState() => _VolunteerPreferencesState();
}

class _VolunteerPreferencesState extends State<VolunteerPreferences> {
  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic>? initialData;
  final Dio dio = Dio();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            appBar(context),
            Container(
              color: Colors.green,
              width: double.infinity,
              height: 50,
              child: const Center(
                  child: Text(
                "Volunteer Application 2/3",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              )),
            ),
            // initialData == null ?const CircularProgressIndicator():
            FutureBuilder(
                future: fetchData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      final f1 = jsonEncode(snapshot.data);
                      final fetchedData = jsonDecode(f1);
                      print(' data== > ${fetchedData["status"]}');
                      bool enabled = false ;
                      if(fetchedData["status"] == null ){
                        enabled = true ;
                      }

                      return FormBuilder(
                          enabled: !enabled,
                          key: _formKey,
                          child: Column(children: [
                            const SizedBox(height: 20),
                            formField(
                              enabled: false,
                                label: 'SBF id',
                                name: 'SBF_id',
                                initialValue:
                                    SessionManager.getString(Constant.SBFID)),
                            const SizedBox(height: 30),
                            checkBoxField(
                              key: _formKey,
                                initialValue: fetchedData["qualification"],
                                label: "Qualifications",
                                name: "qualification",
                                options: [
                                  "10th",
                                  "12th",
                                  "Diploma",
                                  "Graduation",
                                  "Post Graduation",
                                  "PhD",
                                  "Others"
                                ]),
                            const SizedBox(height: 30),

                            checkBoxMultipleField(
                                initialValue: fetchedData["skill"],
                                label: "Skills",
                                name: 'skill',
                                options: [
                                  "Driving",
                                  "Swimming",
                                  "Electrician",
                                  "Plumbing",
                                  "Acting",
                                  "Singing",
                                  "Public Speaking",
                                  "Writing",
                                  "IT Proficient",
                                  "Graphic Designer"
                                ]),
                            const SizedBox(height: 30),

                            checkBoxField(
                              initialValue: fetchedData["day_of_week"],
                              label:
                                  "What day of the week would you like to be part of ?",
                              name: 'day_of_week',
                              options: ["Week Days", "Weekends"],
                              key: _formKey,
                            ),
                            const SizedBox(height: 30),

                            checkBoxField(
                              initialValue:
                                  fetchedData["can__work_in_austere_condition"],
                              label:
                                  "Are you comfortable in practicing in austere condition ?",
                              name: 'can__work_in_austere_condition',
                              options: ["Yes", "No"],
                              key: _formKey,
                            ),
                            const SizedBox(height: 30),

                            checkBoxField(
                              initialValue: fetchedData["deployment_duration"],
                              label:
                                  "How long can you be deployed during any calamity ?",
                              name: 'deployment_duration',
                              options: ["One Week", "Two Weeks", "One Month"],
                              key: _formKey,
                            ),
                            const SizedBox(height: 30),

                            checkBoxField(
                              initialValue: fetchedData["deployment_notice"],
                              label:
                                  "How long before deployment should you get notice ?",
                              name: 'deployment_notice',
                              options: [
                                "24 Hours",
                                "48 Hours",
                                "2 to 5 days",
                                "7 to 10 days"
                              ],
                              key: _formKey,
                            ),
                            const SizedBox(height: 30),

                            checkBoxField(
                              initialValue: fetchedData["evacuation_period"],
                              label:
                                  "if a disaster occurred today, how soon can you pack and leave ?",
                              name: 'evacuation_period',
                              options: [
                                "Anytime",
                                "Within 24 Hours",
                                "48 Hours",
                                "2 days",
                                "5 days",
                                "7 days"
                              ],
                              key: _formKey,
                            ),
                            enabled
                                ? CustomWidget().basicButton(
                                    text: 'Next',
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const VolunteerDocuments()));
                                    },
                                    color: Colors.green, context: context)
                                : CustomWidget().basicButton(
                                    text: 'Save',
                                    onTap: () {


                                      // On another side, can access all field values without saving form with instantValues

                                        _formKey.currentState?.saveAndValidate();
                                        _formKey.currentState?.validate();

                                      if (_formKey.currentState!.isValid) {
                                        savePreference();
                                      }
                                    }, context: context),
                            const SizedBox(height: 50)
                          ]));
                    } else if (snapshot.hasError) {
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

  void savePreference() {
    Map<String, dynamic> payload = _formKey.currentState!.value;
   // print(payload);
    postRequest(
        payload: payload,
        bearerToken: SessionManager.getString(Constant.access_token),

        endPoint: Webservices.preferences,
        onSuccess: (res) {
          showSnackBar(context: context, text: res["message"]);
          if (res["status"] == true) {
            setState(() {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const VolunteerDocuments()));
            });
          }
        },
        onError: (res) {
          showSnackBar(context: context, text: "error ${res["message"]}");
        },
        context: context);
  }

  Future<Map<String, dynamic>?> fetchData() async {
    try {
      Response response = await dio.post(Webservices.getPreferences,
          options: Options(headers: {
            "Authorization": "Bearer ${SessionManager.getString(Constant.access_token)}"
          }),
          data: {"SBF_id": SessionManager.getString(Constant.SBFID)});
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data["status"] == true) {
          return response.data["data"];
        } else {
          return response.data;
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

  // Future<Map<String, dynamic>?> getData() async {
  //   postRequest(
  //       payload: {"SBF_id": SessionManager.getString(Constant.SBFID)},
  //       endPoint: Webservices.getPreferences,
  //       onSuccess: (res) {
  //         if (res["status"] == true) {
  //
  //             if (res["data"].isNotEmpty) {
  //               initialData = res["data"];
  //               saved = true;
  //             }
  //             print('initial data $initialData');
  //
  //         }
  //       },
  //       onError: (res) {
  //         showSnackBar(context: context, text: res["message"]);
  //       },
  //       context: context);
  //   return initialData ;
  // }
}
