import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:logo_n_spinner/logo_n_spinner.dart';
import 'package:sbf_mobile_app/Constant.dart';
import 'package:sbf_mobile_app/CustomUI/Appbar.dart';
import 'package:sbf_mobile_app/CustomUI/loader.dart';
import 'package:sbf_mobile_app/CustomUI/profile_widget.dart';
import 'package:sbf_mobile_app/CustomUI/snackBar.dart';
import 'package:sbf_mobile_app/Screens/admin/volunteer_profile_widget.dart';
import 'package:sbf_mobile_app/preferences/preferences.dart';
import 'package:sbf_mobile_app/webservices.dart';
import 'package:url_launcher/url_launcher.dart';

class VolunteerApplication extends StatefulWidget {
  final String id;
  const VolunteerApplication({super.key, required this.id});

  @override
  State<VolunteerApplication> createState() => _VolunteerApplicationState();
}

class _VolunteerApplicationState extends State<VolunteerApplication> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            appBar(context),
            FutureBuilder<dynamic>(
              future: fetchData(context,
                  widget.id), // This is your Future task that fetches data
              builder: (BuildContext context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return VolunteerProfileDetails(
                      basicDetails: snapshot.data["basicDetails"],
                      documents: snapshot.data["documents"] ?? {},
                      step: getActiveStep(snapshot.data["statuses"]),
                      context: context,
                      onTap: () {
                        downloadId(context, snapshot.data["basicDetails"]["SBF_id"]) ;

                      },
                      onRefresh: () {
                        setState(() {});
                      },
                      localLevel: () {
                        localLevel(context, snapshot.data["basicDetails"]["SBF_id"]);
                      },
                      stateLevel: () {
                        stateLevel(context, snapshot.data["basicDetails"]["SBF_id"]);
                      },
                      nationalLevel: () {
                        nationalLevel(
                            context, snapshot.data["basicDetails"]["SBF_id"]);
                      });
                  // While the task is happening, show a loading spinner
                } else if (snapshot.hasError) {
                  // If there's an error, display an error message
                  return Text('Error: ${snapshot.error}');
                } else {
                  return const LogoandSpinner(
                    imageAssets: 'assets/images/SBF_logo.png',
                    reverse: true,
                    arcColor: Colors.orange,
                    spinSpeed: Duration(milliseconds: 500),
                  );
                }
              },
            )
          ],
        ),
      ),
    ));
  }

  int getActiveStep(Map<String,dynamic>status) {



    if (status["national_level"] == true) {
      return 3;
    } else if (status["state_level"] == true) {
      return 2;
    } else if (status["local_level"] == true) {
      return 1;
    }

    return 0;
  }

  Future<Map<String, dynamic>?> fetchData(
      BuildContext context, String id) async {
    final dio = Dio();
    Response response = await dio.get(Webservices.getVolunteer,
        data: {'SBF_id': id},
        options: Options(headers: {
          "Authorization":
              "Bearer ${SessionManager.getString(Constant.access_token)}"
        }));

    Response approvalStatus = await dio.post(Webservices.getApprovalStatus,
        data: {'SBF_id': id},
        options: Options(headers: {
          "Authorization":
              "Bearer ${SessionManager.getString(Constant.access_token)}"
        }));
    if (response.statusCode == 200 && approvalStatus.statusCode == 200) {
      return {
        "basicDetails": response.data["data"]["basicDetails"],
        "documents": response.data["data"]["documents"],

        "statuses": approvalStatus.data["data"]
      };
    } else {
      if (context.mounted)
        showSnackBar(context: context, text: response.data["message"]);
      return null;
    }
    // Replace this URL with your API endpoint
  }

  Future<void> downloadId(BuildContext context, String id) async {
    try {
      customLoader(context);
      final dio = Dio();
      Response response =
          await dio.post(Webservices.downloadId, data: {'SBF_id': id},
              options: Options(headers: {
                "Authorization": "Bearer ${SessionManager.getString(Constant.access_token)}"
              })
          );
      if (response.statusCode == 200) {
        if (context.mounted) {
          Navigator.pop(context);
          showSnackBar(
              context: context, text: response.data["message"]);

          downloadPdf(context, response.data["path"], 'IdCard.pdf');
        }
      } else {
        if (context.mounted) {
          Navigator.pop(context);
          showSnackBar(context: context, text: response.data["message"]);
        }
      }
    } catch (e) {
      if (context.mounted) {
        Navigator.pop(context);
        showSnackBar(context: context, text: e.toString());
      }
    }
    // Replace this URL with your API endpoint
  }

  Future<void> localLevel(BuildContext context, String id) async {
    try {
      customLoader(context);
      final dio = Dio();
      Response response =
          await dio.post(Webservices.localLevel, data: {'SBF_id': id},
              options: Options(headers: {
                "Authorization": "Bearer ${SessionManager.getString(Constant.access_token)}"
              })
          );
      if (response.statusCode == 200) {
        if (context.mounted) {
          Navigator.pop(context);
          showSnackBar(
              context: context, text: response.data["message"]);
          setState(() {});
        }
      } else {
        if (context.mounted) {
          Navigator.pop(context);
          showSnackBar(context: context, text: response.data["message"]);
        }
      }
    } catch (e) {
      if (context.mounted) {
        Navigator.pop(context);
        showSnackBar(context: context, text: e.toString());
      }
    }
    // Replace this URL with your API endpoint
  }

  Future<void> stateLevel(BuildContext context, String id) async {
    try {
      customLoader(context);
      final dio = Dio();
      Response response =
          await dio.post(Webservices.stateLevel, data: {'SBF_id': id},
              options: Options(headers: {
                "Authorization": "Bearer ${SessionManager.getString(Constant.access_token)}"
              })
          );
      if (response.statusCode == 200) {
        if (context.mounted) {
          Navigator.pop(context);
          showSnackBar(
              context: context, text: response.data["message"]);
          setState(() {});
        }
      } else {
        if (context.mounted) {
          Navigator.pop(context);
          showSnackBar(context: context, text: response.data["message"]);
        }
      }
    } catch (e) {
      if (context.mounted) {
        Navigator.pop(context);
        showSnackBar(context: context, text: e.toString());
      }
    }
    // Replace this URL with your API endpoint
  }

  Future<void> nationalLevel(BuildContext context, String id) async {
    try {
      customLoader(context);
      final dio = Dio();
      Response response =
          await dio.post(Webservices.nationalLevel, data: {'SBF_id': id},

              options: Options(headers: {
                "Authorization": "Bearer ${SessionManager.getString(Constant.access_token)}"
              })
          );
      if (response.statusCode == 200) {
        if (context.mounted) {
          Navigator.pop(context);
          showSnackBar(
              context: context, text: response.data["message"]);
          setState(() {});
        }
      } else {
        if (context.mounted) {
          Navigator.pop(context);
          showSnackBar(context: context, text: response.data["message"]);
        }
      }
    } catch (e) {
      if (context.mounted) {
        Navigator.pop(context);
        showSnackBar(context: context, text: e.toString());
      }
    }
    // Replace this URL with your API endpoint
  }

  Future<void> downloadPdf(
      BuildContext context, String url, String fileName) async {
    try {
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
      } else {
        print('Could not launch $url');
      }
    } catch (e) {
      print('Error: $e');
      showSnackBar(context: context, text: 'Failed to download');
      // Open the URL in the default browser as a fallback
    }
  }
}
