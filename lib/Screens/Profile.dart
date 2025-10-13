import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:logo_n_spinner/logo_n_spinner.dart';
import 'package:sbf_mobile_app/Constant.dart';
import 'package:sbf_mobile_app/CustomUI/Appbar.dart';
import 'package:sbf_mobile_app/CustomUI/loader.dart';
import 'package:sbf_mobile_app/CustomUI/profile_widget.dart';
import 'package:sbf_mobile_app/CustomUI/snackBar.dart';
import 'package:sbf_mobile_app/preferences/preferences.dart';
import 'package:sbf_mobile_app/webservices.dart';
import 'package:url_launcher/url_launcher.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});
  @override
  Widget build(BuildContext context) {
    return  SafeArea(child: Scaffold(
    body: Column(
      children: [
        appBar(context),
        FutureBuilder<dynamic>(
          future: fetchData(context,SessionManager.getString(Constant.SBFID)), // This is your Future task that fetches data
          builder: (BuildContext context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // While the task is happening, show a loading spinner
              return const LogoandSpinner(
                imageAssets: 'assets/images/SBF_logo.png',
                reverse: true,
                arcColor: Colors.orange,
                spinSpeed: Duration(milliseconds: 500),
              ) ;
            } else if (snapshot.hasError) {
              // If there's an error, display an error message
              return Text('Error: ${snapshot.error}');
            } else {
              return ProfileDetails(snapshot.data["details"],getActiveStep(snapshot.data["statuses"]),context,(){
                downloadId(context, snapshot.data["details"]["SBF_id"]);
              });
            }
          },
        )


      ],
    ),
    ));
  }

  int getActiveStep(Map<String,dynamic> status){
    if(status["national_level"] == 1 ){
      return 3 ;
    }
    else if(status["state_level"] == 1 ){
      return 2 ;
    }
    else if(status["local_level"] == 1 ){
      return 1 ;
    }
    return 0 ;
  }

  Future<Map<String,dynamic>?> fetchData( BuildContext context, String id) async {
    final dio = Dio();

    Response response = await dio.get(Webservices.getVolunteer, data: {'SBF_id':id},
        options: Options(headers: {
          "Authorization": "Bearer ${SessionManager.getString(Constant.access_token)}"
        })
    );
    Response approvalStatus = await dio.post(Webservices.getApprovalStatus, data: {'SBF_id':id},
        options: Options(headers: {
          "Authorization": "Bearer ${SessionManager.getString(Constant.access_token)}"
        })
    );
    if(response.statusCode==200 && approvalStatus.statusCode==200){
      return {
        "details" : response.data["data"]["basicDetails"] ,
        "statuses" :approvalStatus.data["data"]
      };
    }
    else {
      if(context.mounted) showSnackBar(context: context, text: response.data["message"]);
      return null ;
    }
    // Replace this URL with your API endpoint
  }

  Future<void> downloadId( BuildContext context, String id) async {
    try{
      customLoader(context);
      final dio = Dio();
      Response response = await dio.post(Webservices.downloadId, data: {'SBF_id':id});
      print(response.data);
      if(response.statusCode==200){
        if(context.mounted) {
          Navigator.pop(context);
          showSnackBar(
              context: context, text: response.data["data"]["message"]);

          downloadPdf(context, response.data["data"]["path"], 'IdCard.pdf') ;
          
        }
      }
      else {

        if(context.mounted) {
          Navigator.pop(context);
          showSnackBar(context: context, text: response.data["message"]);
        }
      }

    }

    catch(e){
      if(context.mounted){
        Navigator.pop(context);
        showSnackBar(context: context, text: e.toString());
      }

    }
    // Replace this URL with your API endpoint
  }

  Future<void> downloadPdf(BuildContext context ,String url, String fileName) async {
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





// import 'dart:io';
//
// import 'package:awesome_dialog/awesome_dialog.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:open_file/open_file.dart';
// import 'dart:convert';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as https;
// import 'package:printing/printing.dart';
// import 'package:sbf_mobile_app/CustomUI/CustomWidgets.dart';
// import 'package:sidebarx/sidebarx.dart';
// import 'package:transparent_image/transparent_image.dart';
// import '../CustomUI/Appbar.dart';
// import '../../Constant.dart';
// import '../../pdfViewer.dart';
// import '../../preferences/preferences.dart';
// import '../../webservices.dart';class Profile extends StatefulWidget {
//   const Profile({Key? key}) : super(key: key);
//
//   @override
//   State<Profile> createState() => _ProfileState();
// }
// var Vdata ;
// var CDATA ;
// TextStyle fieldsStyle = TextStyle(fontSize: 13, fontWeight: FontWeight.bold);
//
//
// TextStyle detailsStyle = TextStyle(fontSize: 13);
// final _controller = SidebarXController(selectedIndex: 0, extended: true);
//
// final _key = GlobalKey<ScaffoldState>();
//
// class _ProfileState extends State<Profile> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     getUser();
//     getVOlbyID();
//
//   }
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(child: Scaffold(
//
//       key: _key,
//       drawer: ExampleSidebarX(controller: _controller,www: _key),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Appbar(context,_key),
//             SizedBox(height: 50),
//             Text('User Profile'),
//             SizedBox(height: 20),
//             Column(
//               children: [
//                 SizedBox(height: 10),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     Container(
//                         width: 130,
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text("SBF ID", style: fieldsStyle),
//                             Text(
//                               ":",
//                               style: fieldsStyle,
//                             )
//                           ],
//                         )),
//                     Container(
//                         width: 190,
//                         child: Text(CDATA['SBFID'], style: detailsStyle))
//                   ],
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     Container(
//                         width: 130,
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text("Name", style: fieldsStyle),
//                             Text(
//                               ":",
//                               style: fieldsStyle,
//                             )
//                           ],
//                         )),
//                     Container(
//                         width: 190,
//                         child: Text(CDATA['Name'], style: detailsStyle))
//                   ],
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     Container(
//                         width: 130,
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text("Email", style: fieldsStyle),
//                             Text(
//                               ":",
//                               style: fieldsStyle,
//                             )
//                           ],
//                         )),
//                     Container(
//                         width: 190,
//                         child: Text(CDATA['Email'], style: detailsStyle))
//                   ],
//                 ),
//
//
//               ],
//             ),
//
//             SizedBox(height: 50),
//             Text('Volunteer Application Details'),
//             Vdata.isEmpty?
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Container(child: Text('You have not applied for volunteer',
//               style: TextStyle(color: Colors.red),
//               ),),
//             ):
//
//             Dtail(0)
//
//           ],
//         ),
//       )
//       ,
//     ));
//   }
//   Widget Dtail(index){
//     return Column(
//       children: [
//         SizedBox(height: 10),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             Container(
//                 width: 130,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text("SBF ID", style: fieldsStyle),
//                     Text(
//                       ":",
//                       style: fieldsStyle,
//                     )
//                   ],
//                 )),
//             Container(
//                 width: 190,
//                 child: Text(Vdata[index]['sbf_ID'], style: detailsStyle))
//           ],
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             Container(
//                 width: 130,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text("Name", style: fieldsStyle),
//                     Text(
//                       ":",
//                       style: fieldsStyle,
//                     )
//                   ],
//                 )),
//             Container(
//                 width: 190,
//                 child: Text(Vdata[index]['name'], style: detailsStyle))
//           ],
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             Container(
//                 width: 130,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text("Email", style: fieldsStyle),
//                     Text(
//                       ":",
//                       style: fieldsStyle,
//                     )
//                   ],
//                 )),
//             Container(
//                 width: 190,
//                 child: Text(Vdata[index]['email'], style: detailsStyle))
//           ],
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             Container(
//                 width: 130,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text("DOB", style: fieldsStyle),
//                     Text(
//                       ":",
//                       style: fieldsStyle,
//                     )
//                   ],
//                 )),
//             Container(
//                 width: 190,
//                 child: Text(Vdata[index]['DOB'], style: detailsStyle))
//           ],
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             Container(
//                 width: 130,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text("Blood Group", style: fieldsStyle),
//                     Text(
//                       ":",
//                       style: fieldsStyle,
//                     )
//                   ],
//                 )),
//             Container(
//                 width: 190,
//                 child: Text(Vdata[index]['blood_group'], style: detailsStyle))
//           ],
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             Container(
//                 width: 130,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text("Contact No.", style: fieldsStyle),
//                     Text(
//                       ":",
//                       style: fieldsStyle,
//                     )
//                   ],
//                 )),
//             Container(
//                 width: 190,
//                 child: Text(Vdata[index]['contact_no'], style: detailsStyle))
//           ],
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             Container(
//                 width: 130,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text("WhatsApp No.", style: fieldsStyle),
//                     Text(
//                       ":",
//                       style: fieldsStyle,
//                     )
//                   ],
//                 )),
//             Container(
//                 width: 190,
//                 child: Text(Vdata[index]['whatsapp_no'], style: detailsStyle))
//           ],
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             Container(
//                 width: 130,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text("State", style: fieldsStyle),
//                     Text(
//                       ":",
//                       style: fieldsStyle,
//                     )
//                   ],
//                 )),
//             Container(
//                 width: 190,
//                 child: Text(Vdata[index]['state'], style: detailsStyle))
//           ],
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             Container(
//                 width: 130,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text("District", style: fieldsStyle),
//                     Text(
//                       ":",
//                       style: fieldsStyle,
//                     )
//                   ],
//                 )),
//             Container(
//                 width: 190,
//                 child: Text(Vdata[index]['district'], style: detailsStyle))
//           ],
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             Container(
//                 width: 130,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text("Ward No.", style: fieldsStyle),
//                     Text(
//                       ":",
//                       style: fieldsStyle,
//                     )
//                   ],
//                 )),
//             Container(
//                 width: 190,
//                 child: Text(Vdata[index]['ward_no'], style: detailsStyle))
//           ],
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             Container(
//                 width: 130,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text("Qualification", style: fieldsStyle),
//                     Text(
//                       ":",
//                       style: fieldsStyle,
//                     )
//                   ],
//                 )),
//             Container(
//                 width: 190,
//                 child: Text(
//                     Vdata[index]['qualification']
//                         .toString()
//                         .replaceAll("[", "")
//                         .replaceAll("]", ""),
//                     style: detailsStyle))
//           ],
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             Container(
//                 width: 130,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text("Skill", style: fieldsStyle),
//                     Text(
//                       ":",
//                       style: fieldsStyle,
//                     )
//                   ],
//                 )),
//             Container(
//                 width: 190,
//                 child: Text(
//                     Vdata[index]['skills']
//                         .toString()
//                         .replaceAll("[", "")
//                         .replaceAll("]", ""),
//                     style: detailsStyle))
//           ],
//         ),
//
//         SizedBox(
//             height: 50,
//             child: Divider(
//               color: Colors.deepPurple,
//               thickness: 2,
//             )),
//
//         Vdata[index]['local_level_approved'] == "1" ?
//             Card
//               (
//               color: Colors.green,
//               elevation: 4,
//               child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Text('Local Level Approved'),
//             ),) :
//         Card
//           (
//           color: Colors.red,
//           elevation: 4,
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text('Local Level Approval Pending'),
//           ),),
//
//         SizedBox(height: 10),
//         Vdata[index]['state_level_approved'] == "1" ?
//         Card
//           (
//           color: Colors.green,
//           elevation: 4,
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text('State Level Approved'),
//           ),) :
//         Card
//           (
//           color: Colors.red,
//           elevation: 4,
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text('State Level Approval Pending'),
//           ),),
//
//         SizedBox(height: 10),
//         Vdata[index]['national_level_approved'] == "1" ?
//         Card
//           (
//           color: Colors.green,
//           elevation: 4,
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text('National Level Approved'),
//           ),) :
//         Card
//           (
//           color: Colors.red,
//           elevation: 4,
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text('National Level Approval Pending'),
//           ),)
//
//         ,
//
//         Vdata[index]['local_level_approved'] == "1"  && Vdata[index]['state_level_approved'] == "1" &&
//     Vdata[index]['national_level_approved'] == "1" ?
//     Padding(
//       padding: const EdgeInsets.only(top: 15.0),
//       child: GestureDetector(
//         onTap: (){
//           downloadID(0);
//
//         },
//         child: Card(
//           elevation: 10,
//           color: Colors.deepPurple,
//
//           child: Padding(
//             padding: const EdgeInsets.all(15.0),
//             child: Text('Download ID Card', style: TextStyle(
//               color: Colors.white,fontWeight: FontWeight.bold
//
//             ),),
//           ),
//         ),
//       ),
//     ):Container()
//
//
//
//       ],
//     ) ;
//   }
//
//
//   void downloadID(int index) async {
//     final ID = pw.Document();
//
//     CustomWidget().showProgress(context: context);
//
//     final photo = await networkImage(Vdata[index]['photo']);
//     final sign = pw.MemoryImage(
//       (await rootBundle.load('assets/images/signature.png'))
//           .buffer
//           .asUint8List(),
//     );
//     final logo = pw.MemoryImage(
//       (await rootBundle.load('assets/images/SBF_logo.png'))
//           .buffer
//           .asUint8List(),
//     );
//     final vision = pw.MemoryImage(
//       (await rootBundle.load('assets/images/VISION2026.png'))
//           .buffer
//           .asUint8List(),
//     );
//
//     ID.addPage(pw.MultiPage(
//         margin: const pw.EdgeInsets.all(5),
//         pageFormat: PdfPageFormat.a4,
//         build: (pw.Context context) {
//           return [
//             pw.Padding(
//                 padding: const pw.EdgeInsets.all(8.0),
//                 child: pw.Center(
//                     child: pw.Container(
//                         width: 270,
//                         // height: 320,
//                         child: pw.Column(
//                             children: [
//                               pw.Container(
//                                   height: 70,
//                                   padding: pw.EdgeInsets.all(8),
//
//                                   color: PdfColor.fromInt(0xffFF0000),
//
//                                   child: pw.Column(
//                                       mainAxisAlignment: pw.MainAxisAlignment.center,
//                                       children: [
//                                         pw.Text('VOLUNTEER',style: pw.TextStyle(color: PdfColor.fromInt(0xffffffff),fontWeight:
//                                         pw.FontWeight.bold,fontSize: 19)),
//                                         pw.Text('DEIDCATED TO DISASTER RELIEF',style:
//                                         pw.TextStyle(color: PdfColor.fromInt(0xffffffff),fontWeight:
//                                         pw.FontWeight.bold,fontSize: 14))
//
//                                       ]
//                                   )
//                               ),
//                               pw.ClipRRect(
//                                 horizontalRadius: 43,
//                                 verticalRadius: 43,
//                                 child: pw.Image(photo, width: 110, height: 110,fit: pw.BoxFit.cover),
//
//                               ),
//
//                               pw.Text(Vdata[index]['name'],style: pw.TextStyle(color: PdfColor.fromInt(0xff000000),fontWeight:
//                               pw.FontWeight.bold,fontSize: 18)),
//                               pw.SizedBox(
//                                   height: 10,
//                                   width: 250,
//
//
//                                   child:pw.Divider(thickness: 2) ),
//
//                               pw.Text(Vdata[index]['sbf_ID'],style: pw.TextStyle(color: PdfColor.fromInt(0xff000000),fontWeight:
//                               pw.FontWeight.bold,fontSize: 16)),
//                               pw.SizedBox(
//                                   height: 10,
//                                   width: 250,
//
//                                   child:pw.Divider(thickness: 2) ),
//
//                               pw.Container(
//                                   width: 180,
//                                   child: pw.Row(
//                                       mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         pw.Column(
//                                             crossAxisAlignment: pw.CrossAxisAlignment.start,
//                                             children: [
//                                               pw.Text('Blood Group',style: pw.TextStyle(color: PdfColor.fromInt(0xff808080),fontSize: 12)),
//                                               pw.Text(Vdata[index]['blood_group'],style: pw.TextStyle(color: PdfColor.fromInt(0xffff0000),
//                                                   fontSize: 14)),
//
//
//                                             ]
//                                         ),
//                                         pw.SizedBox(width: 10),
//                                         pw.Column(
//                                             crossAxisAlignment: pw.CrossAxisAlignment.end,
//
//                                             children: [
//                                               pw.Text('State',style: pw.TextStyle(color: PdfColor.fromInt(0xff808080),fontSize: 12)),
//                                               pw.Text(Vdata[index]['state'],style: pw.TextStyle(fontSize: 14)),
//
//
//                                             ]
//                                         ),
//                                       ]
//
//                                   )
//                               ),
//                               pw.SizedBox(height: 10),
//                               pw.Container(
//                                   width: 180,
//                                   child: pw.Row(
//                                       mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         pw.Column(
//                                             crossAxisAlignment: pw.CrossAxisAlignment.start,
//                                             children: [
//                                               pw.Text('Emergency Contact',style: pw.TextStyle(color: PdfColor.fromInt(0xff808080),fontSize: 12)),
//                                               pw.Text(Vdata[index]['contact_no'],style: pw.TextStyle(
//                                                   fontSize: 14)),
//
//
//                                             ]
//                                         ),
//                                         pw.SizedBox(width: 10),
//                                         pw.Column(
//                                             crossAxisAlignment: pw.CrossAxisAlignment.start,
//
//                                             children: [
//                                               pw.Text('District',style: pw.TextStyle(color: PdfColor.fromInt(0xff808080),fontSize: 12)),
//                                               pw.Text(Vdata[index]['district'],style: pw.TextStyle(fontSize: 14)),
//
//
//                                             ]
//                                         ),
//                                       ]
//
//                                   )
//                               ),
//
//
//
//                               pw.Container(
//                                   width: 180,
//                                   child: pw.Row(
//                                       mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         pw.Text('Valid upto 03/04/2024',style: pw.TextStyle(color: PdfColor.fromInt(0xffff0000),
//                                             fontSize: 9)),
//
//                                         pw.SizedBox(width: 1)
//
//
//
//                                       ]
//
//                                   )
//                               ),
//
//                               pw.Container(
//                                   width: 180,
//                                   child: pw.Row(
//                                       mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//                                       children: [
//
//                                         pw.SizedBox(width: 1),
//                                         pw.Column(
//                                             children: [
//
//                                               pw.Image(sign,width: 80,height: 80),
//                                               pw.Text('Auth Signature',style: pw.TextStyle(
//                                                   fontSize: 10)),
//
//
//
//
//
//
//                                             ]
//                                         )
//
//
//
//
//                                       ]
//
//                                   )
//                               ),
//
//
//
//
//                               pw.SizedBox(
//                                   width: 250,
//
//                                   child:pw.Divider(thickness: 1) ),
//                               pw.Container(
//
//                                   width: 170,
//                                   height: 50,
//                                   child:  pw.Row(
//                                     mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
//                                     // crossAxisAlignment: pw.CrossAxisAlignment.start,
//
//                                     children: [
//                                       pw.Image(logo,width: 60),
//                                       pw.Image(vision,width: 80,fit: pw.BoxFit.contain)
//                                     ],
//                                   )
//                               ),
//                               pw.Text('SOCIETY FOR BRIGHT FUTURE',
//                                   style: pw.TextStyle(
//                                       color: PdfColor.fromInt(0xffFFA500),
//                                       fontSize: 14,
//                                       fontWeight: pw.FontWeight.bold)),
//
//                               pw.Text('E-89, 1st floor, AFE, Jamia Nagar New Delhi, 110025 \n       info@sbfindia.com , www.sbfindia.org',
//                                   style: pw.TextStyle(
//                                       fontSize: 10,
//                                       fontWeight: pw.FontWeight.bold))
//
//
//
//
//
//
//                             ]
//                         )
//
//                     )))
//           ]; // Center
//         }));
//     final file =
//     File("/storage/emulated/0/Download/${Vdata[index]['sbf_ID']}_id.pdf");
//     await file.writeAsBytes(await ID.save());
//
//     CustomWidget().hidProgress(context: context);
//
//     AwesomeDialog(
//       context: context,
//       dialogType: DialogType.SUCCES,
//       animType: AnimType.SCALE,
//       title: 'Downloaded',
//       desc: 'ID Card Downloaded Successfully',
//       btnOkText: 'Open',
//       btnCancelText: 'Close',
//       btnCancelOnPress: () {},
//       btnOkOnPress: () {
//         OpenFile.open(
//             "/storage/emulated/0/Download/${Vdata[index]['sbf_ID']}_id.pdf");
//       },
//     ).show();
//   }
//
//   Future<https.Response?> getUser() async {
//     try {
//       //  CustomWidget().showProgress(context: context);
//       String url = Webservices.getuser;
//
//       var response = await https.post(Uri.parse(url),
//           headers: {
//             'Content-Type': 'application/json',
//             'Accept': 'application/json',
//             'Authorization':
//             'Bearer ${ SessionManager().getString(Constant.access_token)}'
//           });
//
//       var data = jsonDecode(response.body);
//       print(response.body);
//
//       if (response.statusCode == 200) {
//         //  CustomWidget().hidProgress(context: context);
//         print(data);
//
//         setState(() {
//           CDATA = data['data'];
//         });
//       } else {
//         // CustomWidget().hidProgress(context: context);
//
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//             content: Text(
//               'Some error occured',
//               style: TextStyle(color: Colors.red),
//             )));
//       }
//     } on Exception catch (e) {
//       print(e.toString());
//       // _hideProgress();
//     }
//   }
//
//   Future<https.Response?> getVOlbyID() async {
//     try {
//       //  CustomWidget().showProgress(context: context);
//       String url = Webservices.filterVolunteer;
//       print(url);
//       Map jsonData = {
//         "filter": "where sbf_id = '${await SessionManager().getString(Constant.SBFID)}';"
//       };
//       var response = await https.post(Uri.parse(url),
//           body: jsonEncode(jsonData),
//           encoding: Encoding.getByName("utf-8"),
//           headers: {
//             'Content-Type': 'application/json',
//             'Accept': 'application/json',
//             'Authorization':
//             'Bearer ${await SessionManager().getString(Constant.access_token)}'
//           });
//
//       var data = jsonDecode(response.body);
//       print(response.body);
//
//       if (response.statusCode == 201) {
//         //  CustomWidget().hidProgress(context: context);
//         print(data);
//
//         setState(() {
//           Vdata = data['msg'];
//         });
//       } else {
//         // CustomWidget().hidProgress(context: context);
//
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//             content: Text(
//               'Some error occured',
//               style: TextStyle(color: Colors.red),
//             )));
//       }
//     } on Exception catch (e) {
//       print(e.toString());
//       // _hideProgress();
//     }
//   }
//
// }
//
//
