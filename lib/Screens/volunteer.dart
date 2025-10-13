// import 'dart:convert';
// import 'dart:ffi';
// import 'dart:io';
// import 'package:flutter/services.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:sbf_mobile_app/CustomUI/Appbar.dart';
// import 'package:awesome_dialog/awesome_dialog.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:sbf_mobile_app/Constant.dart';
// import 'package:sbf_mobile_app/CustomUI/CustomWidgets.dart';
// import 'package:http/http.dart' as https;
// import 'package:sbf_mobile_app/Screens/RegistrationSuccess.dart';
// import 'package:sbf_mobile_app/Screens/admin/VolunteerList.dart';
// import 'package:sbf_mobile_app/preferences/preferences.dart';
// import 'package:sbf_mobile_app/webservices.dart';
// import 'package:sidebarx/sidebarx.dart';
// import 'package:sn_progress_dialog/progress_dialog.dart';
// import 'package:fluttericon/typicons_icons.dart';
// import 'package:fluttericon/fontelico_icons.dart';
// import 'package:fluttericon/linecons_icons.dart';
// import 'package:fluttericon/font_awesome_icons.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// import '../pdfViewer.dart';
//
// class Volunteer extends StatefulWidget {
//   const Volunteer({Key? key}) : super(key: key);
//
//   @override
//   State<Volunteer> createState() => _VolunteerState();
// }
//
// TextEditingController _name = TextEditingController();
// TextEditingController _contactNo = TextEditingController();
// TextEditingController _WhatsAppNo = TextEditingController();
// TextEditingController _email = TextEditingController();
// TextEditingController _district = TextEditingController();
// TextEditingController _block = TextEditingController();
// TextEditingController _pincode = TextEditingController();
//
// String dob = "";
// String? bloogGroup;
// String? state;
//
// List<Map<String, bool>> Qualification = [
//   {'10th': false},
//   {'12th': false},
//   {'Diploma': false},
//   {'Graduation': false},
//   {'Post Graduation': false},
//   {'PhD': false},
//   {'Other': false}
// ];
//
// List<Map<String, bool>> Skills = [
//   {'Driving': false},
//   {'Swimming': false},
//   {'Electrician': false},
//   {'Plumbing': false},
//   {'Acting': false},
//   {'Singing': false},
//   {'Public Speaking': false},
//   {'Writing': false},
//   {'IT Proficient': false},
//   {'Graphic Designing': false}
// ];
//
// enum Interest { WeekDays, Weekend }
//
// enum AustereCondition { yes, no }
//
// enum calamity { oneweek, twoweek, onemonth }
// enum noticePeriod {oneDay,twoDays,twotofivedays,seventotendays, }
// enum emergencyDays {Anytime, Within24Hours, _48Hours, _2days, _5days ,_7days }
//
//
//
//
// late ProgressDialog progressDialog;
//
// String? notice;
// String? leave;
// File? photo;
// File? qDocs;
// File? sign;
// File? adhar;
// File? pan;
// File? character;
//
// String? q ;
// List s = [];
//
// final _controller = SidebarXController(selectedIndex: 0, extended: true);
//
// final _key = GlobalKey<ScaffoldState>();
//
// class _VolunteerState extends State<Volunteer> {
//
//   Interest _days = Interest.WeekDays;
//   AustereCondition _austereCondition = AustereCondition.yes;
//   calamity _calamity = calamity.oneweek;
//   noticePeriod _notice = noticePeriod.oneDay;
//   emergencyDays _emergency = emergencyDays.Anytime;
//   @override
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Scaffold(
//       key: _key,
//       drawer: widget.type=='admin'?ExampleSidebarXadmin(controller: _controller,www: _key): ExampleSidebarX(controller: _controller,www: _key),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Appbar(context, _key),
//             Container(
//               width: double.infinity,
//               height: 80,
//               color: Color(0xff016507),
//               child: Center(
//                 child: const Text(
//                   'SBF Volunteer Application Form',
//                   style: TextStyle(
//                       fontSize: 22,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 8.0, right: 8),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(height: 20),
//                   GestureDetector(
//                     onTap: ()async{
//                       String url = 'https://sbfdata.s3.ap-south-1.amazonaws.com/guidelines/Volunteers+guidelines.pdf' ;
//                       if(await canLaunchUrl(Uri.parse(url))){
//                         await launchUrl(Uri.parse(url),mode: LaunchMode.externalApplication );
//                       }else {
//                         throw 'Could not launch $url';
//                       }
//
//
//
//                     },
//                     child: Container(
//                       width: 200,
//                       child: Card(
//                         elevation: 4,
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text('Read guidelines first'),
//                               Icon(FontAwesome.file_pdf , color: Colors.red,)
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 20),
//
//
//                   const Text(
//                       'Volunteers are the backbone of Society for Bright Future. We feel proud to work with people who go above and beyond their duties to help us continue our charitable and welfare work with their time and skills.'),
//                   const Text(
//                       'Anyone who is a citizen of the Indian Union can become a volunteer of Volunteer Core provided that he:\n\n'
//                       '1. Is residing in India and possessing a valid identity card (issued by the government)\n'
//                       '2. Should be no older than 60 years and no younger than 18 years of age.\n'
//                       '3. Preferably, should have passed the 10th class.\n'
//                       '4. Has no criminal record.\n'
//                       '5. Read volunteer guideline carefully its mandatory to become a volunteer.'),
//                   const Text(
//                       'Note: Before Fill this form Please Ready with these Documents in your Mobile or Desktop\n\n'
//                       '1. Passport size Photo\n'
//                       '2. Scan Signature\n'
//                       '3. 10th or Above Marksheet\n'
//                       '4. Aadhar Card\n'
//                       '5. Pan Card\n'
//                       '6. Character Certificate ( You can attest this form by  Gazetted Officers, Police, Gram Pardhan, Ward Member, M.L.A)'),
//                   SizedBox(height: 10),
//                   GestureDetector(
//                       onTap: ()async{
//                         String url = 'https://sbfdata.s3.ap-south-1.amazonaws.com/guidelines/Socity+of+Bright+Certificate.pdf' ;
//                         if(await canLaunchUrl(Uri.parse(url))){
//                           await launchUrl(Uri.parse(url),mode: LaunchMode.externalApplication );
//                         }else {
//                           throw 'Could not launch $url';
//                         }
//
//
//
//                       },
//
//
//                     child: Container(
//                       width: 250,
//                       child: Card(
//                         elevation: 4,
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text('Character Ceritificate Format'),
//                               Icon(FontAwesome.file_pdf , color: Colors.red,)
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//
//                   SizedBox(height: 20),
//                   CustomWidget()
//                       .FormField(label: "Applicant Name / आवेदक का नाम", controller: _name),
//                   SizedBox(height: 10),
//                   GestureDetector(
//                     onTap: () async {
//                       DateTime? pickedDate = await showDatePicker(
//                           context: context, //context of current state
//                           initialDate: DateTime.now(),
//                           firstDate: DateTime(
//                               1950), //DateTime.now() - not to allow to choose before today.
//                           lastDate: DateTime(2101));
//
//                       if (pickedDate != null) {
//                         print(
//                             pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
//                         String formattedDate =
//                             DateFormat('yyyy-MM-dd').format(pickedDate);
//                         print(formattedDate);
//                         setState(() {
//                           dob = formattedDate;
//                         }); //formatted date output using intl package =>  2021-03-16
//                       } else {
//                         print("Date is not selected");
//                       }
//                     },
//                     child: Container(
//                       padding: EdgeInsets.all(8),
//                       decoration: BoxDecoration(
//                           border: Border.all(color: Colors.black)),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           RichText(
//                             text: TextSpan(
//                                 text: dob==''? "DOB / जन्म तिथि":dob,
//                                 style: TextStyle(color: Colors.black),
//
//                                 children: [
//                                   TextSpan(
//                                       text: ' *',
//                                       style: TextStyle(
//                                           color: Colors.red))
//                                 ]),
//                             textScaleFactor: 1,
//                             maxLines: 1,
//                             overflow: TextOverflow.fade,
//                             textAlign: TextAlign.start,
//                           ),
//                           Icon(Icons.calendar_month,
//                               color: Colors.green, size: 30)
//                         ],
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 10),
//                   bloogGroup != null ?
//                   RichText(
//                     text: const TextSpan(
//                         text: "Blood Group / रक्त वर्ग",
//                         style: TextStyle(color: Colors.black),
//
//                         children: [
//                           TextSpan(
//                               text: ' *',
//                               style: TextStyle(
//                                   color: Colors.red))
//                         ]),
//                     textScaleFactor: 1,
//                     maxLines: 1,
//                     overflow: TextOverflow.fade,
//                     textAlign: TextAlign.start,
//                   )
//
//                       : Container(),
//                   Container(
//                     decoration: const BoxDecoration(color: Color(0xffefefef)),
//                     child: DropdownButton<String>(
//                       elevation: 1,
//                       isExpanded: true,
//                       items: <String>[
//                         'A+',
//                         'A-',
//                         'B+',
//                         'B-',
//                         'O+',
//                         'O-',
//                         'AB-',
//                         'AB+'
//                       ].map((String value) {
//                         return DropdownMenuItem<String>(
//                           value: value,
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Text(value),
//                           ),
//                         );
//                       }).toList(),
//                       value: bloogGroup,
//                       disabledHint: const Text(
//                         'Blood Group /  रक्त वर्ग',
//                         style: TextStyle(color: Colors.black),
//                       ),
//                       hint: const Text(
//                         'Blood Group /  रक्त वर्ग',
//                         style: TextStyle(color: Colors.black),
//                       ),
//                       onChanged: (value) {
//                         setState(() {
//                           bloogGroup = value ?? 'blood group';
//                         });
//                       },
//                     ),
//                   ),
//                   SizedBox(height: 10),
//                   CustomWidget().FormField(
//                       label: "Contact No. / संपर्क नंबर",
//                       controller: _contactNo,
//                       type: TextInputType.phone),
//                   SizedBox(height: 10),
//                   CustomWidget().FormField(
//                       label: "WhatsApp No. / व्हाट्सएप नंबर",
//                       controller: _WhatsAppNo,
//                       type: TextInputType.phone),
//                   SizedBox(height: 10),
//                   CustomWidget().FormField(
//                       label: "Email / ईमेल आईडी",
//                       controller: _email,
//                       type: TextInputType.emailAddress),
//                   SizedBox(height: 10),
//                   state != null ? Text('State / राज्य') : Container(),
//                   Container(
//                     decoration: BoxDecoration(color: Color(0xffefefef)),
//                     child: DropdownButton<String>(
//                       elevation: 1,
//                       isExpanded: true,
//                       items: <String>[
//                         'Assam North',
//                         'Assam South',
//                         'Bihar',
//                         'Chattisgarh',
//                         'Delhi',
//                         'Gujarat',
//                         'Haryana',
//                         'Jharkhand',
//                         'Madhya Pradesh',
//                         'Punjab',
//                         'Rajasthan',
//                         'UP east',
//                         'UP west',
//                         'Utrakhand',
//                         'West Bengal'
//                       ].map((String value) {
//                         return DropdownMenuItem<String>(
//                           value: value,
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Text(value),
//                           ),
//                         );
//                       }).toList(),
//                       value: state,
//                       disabledHint: const Text(
//                         'State / राज्य',
//                         style: TextStyle(color: Colors.black),
//                       ),
//                       hint: const Text(
//                         'State / राज्य',
//                         style: TextStyle(color: Colors.black),
//                       ),
//                       onChanged: (value) {
//                         setState(() {
//                           state = value ?? 'State / राज्य';
//                         });
//                       },
//                     ),
//                   ),
//                   SizedBox(height: 10),
//                   CustomWidget()
//                       .FormField(label: "District. / ज़िला", controller: _district),
//                   SizedBox(height: 10),
//                   CustomWidget().FormField(
//                       label: "Block/Tehsil/Ward No. |  ब्लॉक/ तहसील / वार्ड न.", controller: _block),
//                   SizedBox(height: 10),
//                   CustomWidget().FormField(
//                       label: "Pin Code / पिन कोड",
//                       controller: _pincode,
//                       type: TextInputType.number),
//                   SizedBox(height: 10),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Align(
//                       alignment: Alignment.centerLeft,
//                       child: Text(
//                         'Qualification',
//                         style: TextStyle(color: Colors.black, fontSize: 15),
//                       ),
//                     ),
//                   ),
//                   Column(
//                       children: [
//                         ListView.builder(
//                             physics: ClampingScrollPhysics(),
//                             shrinkWrap: true,
//                             itemCount: Qualification.length,
//                             itemBuilder: (BuildContext context, int i) {
//                               return CheckboxListTile(
//                                 activeColor: Colors.green,
//
//                                 title: Text(Qualification[i].keys.first),
//                                 value: Qualification[i][q] ?? false,
//                                 onChanged: (newValue) {
//                                   setState(() {
//                                     Qualification[i]
//                                     [Qualification[i].keys.first] =
//                                         newValue ?? true;
//                                     if(newValue == true){
//                                       q = Qualification[i].keys.first ;
//
//
//                                     }
//                                     else{
//                                       q = null;
//
//
//                                     }
//
//
//
//
//
//                                     print(q);
//                                   });
//                                 },
//                                 controlAffinity: ListTileControlAffinity
//                                     .leading, //  <-- leading Checkbox
//                               );
//                             }),
//                       ]),
//                   SizedBox(height: 10),
//                   Text(
//                     'Skills / कौशल',
//                     style: TextStyle(color: Colors.black, fontSize: 19),
//                   ),
//                   Column(
//                     children: [
//                       ListView.builder(
//                         physics: ClampingScrollPhysics(),
//                           shrinkWrap: true,
//                           itemCount: Skills.length,
//                           itemBuilder: (BuildContext context, int i) {
//                             return CheckboxListTile(
//                               activeColor: Colors.green,
//                               title: Text(Skills[i].keys.first),
//                               value: Skills[i].values.first,
//                               onChanged: (newValue) {
//                                 setState(() {
//                                   Skills[i][Skills[i].keys.first] =
//                                       newValue ?? true;
//
//                                   if (newValue == true) {
//                                     s.insert(
//                                         0,
//                                         Skills[i].keys.firstWhere(
//                                             (k) => Skills[i][k] == true,
//                                             orElse: () => ''));
//                                   } else {
//                                     s.removeAt(0);
//                                   }
//                                   print("skill${s}");
//                                 });
//                               },
//                               controlAffinity: ListTileControlAffinity
//                                   .leading, //  <-- leading Checkbox
//                             );
//                           })
//                     ],
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: RichText(
//                     text: const TextSpan(
//                         text: 'Interest to be involved',
//                         style: TextStyle(color: Colors.black),
//
//                         children: [
//                           TextSpan(
//                               text: ' *',
//                               style: TextStyle(
//                                   color: Colors.red))
//                         ]),
//                     textScaleFactor: 1,
//                     maxLines: 1,
//                     overflow: TextOverflow.fade,
//                     textAlign: TextAlign.start,
//                   )
//
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text(
//                       'आपको सप्ताह के किस दिन शामिल होने में रुचि है?',
//                       style: TextStyle(fontSize: 17),
//                     ),
//                   ),
//                   RadioListTile<Interest>(
//                     title: Text('Weekdays'),
//                     value: Interest.WeekDays,
//                     groupValue: _days,
//                     onChanged: (Interest? value) {
//                       setState(() {
//                         _days = value!;
//                       });
//                     },
//                   ),
//                   RadioListTile<Interest>(
//                     title: Text('Weekends'),
//                     value: Interest.Weekend,
//                     groupValue: _days,
//                     onChanged: (Interest? value) {
//                       setState(() {
//                         _days = value!;
//
//                         print(_days.name);
//                       });
//                     },
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child:
//
//                       RichText(
//                         text: const TextSpan(
//                             text: 'Are you comfortable in practicing in austere condition ?',
//                             style: TextStyle(color: Colors.black),
//
//                             children: [
//                               TextSpan(
//                                   text: ' *',
//                                   style: TextStyle(
//                                       color: Colors.red))
//                             ]),
//                         textScaleFactor: 1,
//                         maxLines: 1,
//                         overflow: TextOverflow.fade,
//                         textAlign: TextAlign.start,
//                       )
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text(
//                       'क्या आप कठोर परिस्थितियों में अभ्यास करने में सहज हैं?',
//                       style: TextStyle(fontSize: 17),
//                     ),
//                   ),
//                   RadioListTile<AustereCondition>(
//                     title: Text('Yes'),
//                     value: AustereCondition.yes,
//                     groupValue: _austereCondition,
//                     onChanged: (AustereCondition? value) {
//                       setState(() {
//                         _austereCondition = value!;
//                       });
//                     },
//                   ),
//                   RadioListTile<AustereCondition>(
//                     title: Text('No'),
//                     value: AustereCondition.no,
//                     groupValue: _austereCondition,
//                     onChanged: (AustereCondition? value) {
//                       setState(() {
//                         _austereCondition = value!;
//                       });
//                     },
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child:
//                       RichText(
//                         text: const TextSpan(
//                             text: 'How long can you be deployed during any calamity  ?',
//                             style: TextStyle(color: Colors.black),
//
//                             children: [
//                               TextSpan(
//                                   text: ' *',
//                                   style: TextStyle(
//                                       color: Colors.red))
//                             ]),
//                         textScaleFactor: 1,
//                         maxLines: 1,
//                         overflow: TextOverflow.fade,
//                         textAlign: TextAlign.start,
//                       )
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text(
//                       'आपको कितने समय के लिए तैनात किया जा सकता है किसी विपदा के दौरान ?',
//                       style: TextStyle(fontSize: 17),
//                     ),
//                   ),
//                   RadioListTile<calamity>(
//                     title: Text('One Week'),
//                     value: calamity.oneweek,
//                     groupValue: _calamity,
//                     onChanged: (calamity? value) {
//                       setState(() {
//                         _calamity = value!;
//                       });
//                     },
//                   ),
//                   RadioListTile<calamity>(
//                     title: Text('Two Weeks'),
//                     value: calamity.twoweek,
//                     groupValue: _calamity,
//                     onChanged: (calamity? value) {
//                       setState(() {
//                         _calamity = value!;
//                       });
//                     },
//                   ),
//                   RadioListTile<calamity>(
//                     title: Text('One Month'),
//                     value: calamity.onemonth,
//                     groupValue: _calamity,
//                     onChanged: (calamity? value) {
//                       setState(() {
//                         _calamity = value!;
//                       });
//                     },
//                   ),
//
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child:
//                       RichText(
//                         text: const TextSpan(
//                             text: 'How much notice do you get before deployment ?',
//                             style: TextStyle(color: Colors.black),
//
//                             children: [
//                               TextSpan(
//                                   text: ' *',
//                                   style: TextStyle(
//                                       color: Colors.red))
//                             ]),
//                         textScaleFactor: 1,
//                         maxLines: 1,
//                         overflow: TextOverflow.fade,
//                         textAlign: TextAlign.start,
//                       )
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text(
//                       'तैनाती से कितने समय पहले आपको सूचना दी जानी चाहिए?',
//                       style: TextStyle(fontSize: 17),
//                     ),
//                   ),
//                   RadioListTile<noticePeriod>(
//                     title: Text('24 Hours'),
//
//                     value: noticePeriod.oneDay,
//                     groupValue: _notice,
//                     onChanged: (noticePeriod? value) {
//                       setState(() {
//                         _notice = value!;
//                       });
//                     },
//                   ),
//                   RadioListTile<noticePeriod>(
//                     title: Text('48 Hours'),
//
//                     value: noticePeriod.twoDays,
//                     groupValue: _notice,
//                     onChanged: (noticePeriod? value) {
//                       setState(() {
//                         _notice = value!;
//                       });
//                     },
//                   ),
//                   RadioListTile<noticePeriod>(
//                     title: Text('2 to 5 days'),
//
//                     value: noticePeriod.twotofivedays,
//                     groupValue: _notice,
//                     onChanged: (noticePeriod? value) {
//                       setState(() {
//                         _notice = value!;
//                       });
//                     },
//                   ),
//
//                   RadioListTile<noticePeriod>(
//                     title: Text('7 to 10 days'),
//
//                     value: noticePeriod.seventotendays,
//                     groupValue: _notice,
//                     onChanged: (noticePeriod? value) {
//                       setState(() {
//                         _notice = value!;
//                       });
//                     },
//                   ),
//
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child:
//                       RichText(
//                         text: const TextSpan(
//                             text: 'If a disaster occurred today, how soon can you pack and leave ?',
//                             style: TextStyle(color: Colors.black),
//
//                             children: [
//                               TextSpan(
//                                   text: ' *',
//                                   style: TextStyle(
//                                       color: Colors.red))
//                             ]),
//                         textScaleFactor: 1,
//                         maxLines: 2,
//                         overflow: TextOverflow.fade,
//                         textAlign: TextAlign.start,
//                       )
//                   ),
//
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text(
//                       'यदि आज कोई आपदा आती है, तो आप कितनी जल्दी पैक करके निकल सकते हैं?',
//                       style: TextStyle(fontSize: 17),
//                     ),
//                   ),
//                   RadioListTile<emergencyDays>(
//                     title: Text('Anytime'),
//
//                     value: emergencyDays.Anytime,
//                     groupValue: _emergency,
//                     onChanged: (emergencyDays? value) {
//                       setState(() {
//                         _emergency = value!;
//                       });
//                     },
//                   ),
//                   RadioListTile<emergencyDays>(
//                     title: Text('Within 24 Hours'),
//
//                     value: emergencyDays.Within24Hours,
//                     groupValue: _emergency,
//                     onChanged: (emergencyDays? value) {
//                       setState(() {
//                         _emergency = value!;
//                       });
//                     },
//                   ),
//                   RadioListTile<emergencyDays>(
//                     title: Text('48 Hours'),
//
//                     value: emergencyDays._48Hours,
//                     groupValue: _emergency,
//                     onChanged: (emergencyDays? value) {
//                       setState(() {
//                         _emergency = value!;
//                       });
//                     },
//                   ),
//                   RadioListTile<emergencyDays>(
//                     title: Text('2 days'),
//
//                     value: emergencyDays._2days,
//                     groupValue: _emergency,
//                     onChanged: (emergencyDays? value) {
//                       setState(() {
//                         _emergency = value!;
//                       });
//                     },
//                   ),
//                   RadioListTile<emergencyDays>(
//                     title: Text('5 days'),
//
//                     value: emergencyDays._5days,
//                     groupValue: _emergency,
//                     onChanged: (emergencyDays? value) {
//                       setState(() {
//                         _emergency = value!;
//                         print(_emergency.name);
//                       });
//                     },
//                   ),
//                   RadioListTile<emergencyDays>(
//                     title: Text('7 days'),
//
//                     value: emergencyDays._7days,
//                     groupValue: _emergency,
//                     onChanged: (emergencyDays? value) {
//                       setState(() {
//                         _emergency = value!;
//                       });
//                     },
//                   ),
//
//
//
//                   SizedBox(height: 30),
//                   Container(
//                     width: 500,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         SizedBox(
//                             width: MediaQuery.of(context).size.width / 8,
//                             child:
//                                 Divider(thickness: 1.0, color: Colors.black)),
//                         SizedBox(width: 10),
//                         Text(
//                           'DOCUMENTS UPLOAD \n दस्तावेज़ अपलोड करें',
//                           style:
//                               TextStyle(color: Colors.deepPurple, fontSize: 20),
//                         ),
//                         SizedBox(width: 10),
//                         SizedBox(
//                             width: MediaQuery.of(context).size.width / 8,
//                             child:
//                                 Divider(thickness: 1.0, color: Colors.black)),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   GestureDetector(
//                     onTap: () async {
//                       FilePickerResult? result = await FilePicker.platform
//                           .pickFiles(type: FileType.image);
//
//                       if (result != null) {
//                         setState(() {
//                           final f = File(result.files.single.path ?? '');
//                           int sizeInBytes = f.lengthSync();
//                           double sizeInMb = sizeInBytes / (1024 * 1024);
//
//                           if (sizeInMb <= 2){
//                             photo = File(result.files.single.path ?? '') ;
//                           }
//                           else{
//                             ScaffoldMessenger.of(context)
//                                 .showSnackBar(SnackBar(content: Text('File must be smaller than 2 MB' ,style: TextStyle(color: Colors.red),) )  );
//
//                           }                        });
//                       } else {
//                         // User canceled the picker
//                       }
//                     },
//                     child: Container(
//                       width: double.infinity,
//                       child: Card(
//                         elevation: 10,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Padding(
//                                   padding: const EdgeInsets.all(18.0),
//                                   child: Text('Passport size photo \n पासपोर्ट साइज फोटो',
//                                       style: TextStyle(color: Colors.purple)),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.all(18.0),
//                                   child: Icon(
//                                     Icons.upload_sharp,
//                                     color: Colors.purple,
//                                   ),
//                                 )
//                               ],
//                             ),
//                             photo == null
//                                 ? Container()
//                                 : Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: Image.file(photo!),
//                                   )
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   GestureDetector(
//                     onTap: () async {
//                       FilePickerResult? result = await FilePicker.platform
//                           .pickFiles(
//                               type: FileType.custom,
//                               allowedExtensions: ['pdf']);
//
//                       if (result != null) {
//                         setState(() {
//
//                           final f = File(result.files.single.path ?? '');
//                           int sizeInBytes = f.lengthSync();
//                           double sizeInMb = sizeInBytes / (1024 * 1024);
//
//                           if (sizeInMb <= 2){
//                             qDocs = File(result.files.single.path ?? '') ;
//                           }
//                           else{
//                             ScaffoldMessenger.of(context)
//                                 .showSnackBar(SnackBar(content: Text('File must be smaller than 2 MB' ,style: TextStyle(color: Colors.red),) )  );
//
//                           }
//
//
//
//                         });
//                       } else {
//                         // User canceled the picker
//                       }
//                     },
//                     child: Container(
//                       width: double.infinity,
//                       child: Card(
//                         elevation: 10,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Padding(
//                                   padding: const EdgeInsets.all(18.0),
//                                   child: Text(
//                                     'Qualification Documents \n योग्यता',
//                                     style: TextStyle(color: Colors.purple),
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.all(18.0),
//                                   child: Icon(Icons.upload_sharp,
//                                       color: Colors.purple),
//                                 )
//                               ],
//                             ),
//                             qDocs == null
//                                 ? Container()
//                                 : Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: Row(
//                                       children: [
//                                         Text(qDocs!.path.split('/').last),
//                                         Icon(
//                                           Icons.picture_as_pdf,
//                                           size: 35,
//                                           color: Colors.red,
//                                         )
//                                       ],
//                                     ),
//                                   )
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   GestureDetector(
//                     onTap: () async {
//                       FilePickerResult? result = await FilePicker.platform
//                           .pickFiles(type: FileType.image);
//
//                       if (result != null) {
//                         setState(() {
//                           final f = File(result.files.single.path ?? '');
//                           int sizeInBytes = f.lengthSync();
//                           double sizeInMb = sizeInBytes / (1024 * 1024);
//
//                           if (sizeInMb <= 2){
//                             sign = File(result.files.single.path ?? '') ;
//                           }
//                           else{
//                             ScaffoldMessenger.of(context)
//                                 .showSnackBar(SnackBar(content: Text('File must be smaller than 2 MB' ,style: TextStyle(color: Colors.red),) )  );
//
//                           }                        });
//                       } else {
//                         // User canceled the picker
//                       }
//                     },
//                     child: Container(
//                       width: double.infinity,
//                       child: Card(
//                         elevation: 10,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Padding(
//                                   padding: const EdgeInsets.all(18.0),
//                                   child: Text('Signature \n हस्ताक्षर',
//                                       style: TextStyle(color: Colors.purple)),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.all(18.0),
//                                   child: Icon(
//                                     Icons.upload_sharp,
//                                     color: Colors.purple,
//                                   ),
//                                 )
//                               ],
//                             ),
//                             sign == null
//                                 ? Container()
//                                 : Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: Image.file(sign!),
//                                   )
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   GestureDetector(
//                     onTap: () async {
//                       FilePickerResult? result = await FilePicker.platform
//                           .pickFiles(type: FileType.image);
//
//                       if (result != null) {
//                         setState(() {
//                           final f = File(result.files.single.path ?? '');
//                           int sizeInBytes = f.lengthSync();
//                           double sizeInMb = sizeInBytes / (1024 * 1024);
//
//                           if (sizeInMb <= 2){
//                             adhar = File(result.files.single.path ?? '') ;
//                           }
//                           else{
//                             ScaffoldMessenger.of(context)
//                                 .showSnackBar(SnackBar(content: Text('File must be smaller than 2 MB' ,style: TextStyle(color: Colors.red),) )  );
//
//                           }                                  });
//                       } else {
//                         // User canceled the picker
//                       }
//                     },
//                     child: Container(
//                       width: double.infinity,
//                       child: Card(
//                         elevation: 10,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Padding(
//                                   padding: const EdgeInsets.all(18.0),
//                                   child: Text('Adhaar Card \n आधार कार्ड',
//                                       style: TextStyle(color: Colors.purple)),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.all(18.0),
//                                   child: Icon(
//                                     Icons.upload_sharp,
//                                     color: Colors.purple,
//                                   ),
//                                 )
//                               ],
//                             ),
//                             adhar == null
//                                 ? Container()
//                                 : Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: Image.file(adhar!),
//                                   )
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   GestureDetector(
//                     onTap: () async {
//                       FilePickerResult? result = await FilePicker.platform
//                           .pickFiles(type: FileType.image);
//
//                       if (result != null) {
//                         setState(() {
//                           final f = File(result.files.single.path ?? '');
//                           int sizeInBytes = f.lengthSync();
//                           double sizeInMb = sizeInBytes / (1024 * 1024);
//
//                           if (sizeInMb <= 2){
//                             pan = File(result.files.single.path ?? '') ;
//                           }
//                           else{
//                             ScaffoldMessenger.of(context)
//                                 .showSnackBar(SnackBar(content: Text('File must be smaller than 2 MB' ,style: TextStyle(color: Colors.red),) )  );
//
//                           }                              });
//                       } else {
//                         pan = await getImageFileFromAssets('images/notfound.png');
//                         // User canceled the picker
//                       }
//                     },
//                     child: Container(
//                       width: double.infinity,
//                       child: Card(
//                         elevation: 10,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Padding(
//                                   padding: const EdgeInsets.all(18.0),
//                                   child: Text('PAN Card \n पैन कार्ड',
//                                       style: TextStyle(color: Colors.purple)),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.all(18.0),
//                                   child: Icon(
//                                     Icons.upload_sharp,
//                                     color: Colors.purple,
//                                   ),
//                                 )
//                               ],
//                             ),
//                             pan == null
//                                 ? Container()
//                                 : Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: Image.file(pan!),
//                                   )
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   GestureDetector(
//                     onTap: () async {
//                       FilePickerResult? result = await FilePicker.platform
//                           .pickFiles(
//                               type: FileType.image,
//                              );
//
//                       if (result != null) {
//                         setState(() {
//                           final f = File(result.files.single.path ?? '');
//                           int sizeInBytes = f.lengthSync();
//                           double sizeInMb = sizeInBytes / (1024 * 1024);
//
//                           if (sizeInMb <= 2){
//                             character = File(result.files.single.path ?? '') ;
//                           }
//                           else{
//                             ScaffoldMessenger.of(context)
//                                 .showSnackBar(SnackBar(content: Text('File must be smaller than 2 MB' ,style: TextStyle(color: Colors.red),) )  );
//
//                           }                           });
//                       } else {
//                         character = await getImageFileFromAssets('images/notfound.png');
//                         // User canceled the picker
//                       }
//                     },
//                     child: Container(
//                       width: double.infinity,
//                       child: Card(
//                         elevation: 10,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Padding(
//                                   padding: const EdgeInsets.all(18.0),
//                                   child: Text(
//                                     'Character Certificate \n चरित्र प्रमाण पत्र',
//                                     style: TextStyle(color: Colors.purple),
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.all(18.0),
//                                   child: Icon(Icons.upload_sharp,
//                                       color: Colors.purple),
//                                 )
//                               ],
//                             ),
//                             character == null
//                                 ? Container()
//                                 : Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: Row(
//                                       children: [
//                                         Text(character!.path.split('/').last),
//                                         character!.path
//                                                     .split('/')
//                                                     .last
//                                                     .split(".")
//                                                     .last ==
//                                                 'pdf'
//                                             ? Icon(
//                                                 Icons.picture_as_pdf,
//                                                 size: 35,
//                                                 color: Colors.red,
//                                               )
//                                             : character!.path
//                                                             .split('/')
//                                                             .last
//                                                             .split(".")
//                                                             .last ==
//                                                         'png' ||
//                                                     character!.path
//                                                             .split('/')
//                                                             .last
//                                                             .split(".")
//                                                             .last ==
//                                                         'jpeg' ||
//                                                     character!.path
//                                                             .split('/')
//                                                             .last
//                                                             .split(".")
//                                                             .last ==
//                                                         'jpg'
//                                                 ? Icon(Icons.image,
//                                                     size: 35,
//                                                     color: Colors.blue)
//                                                 : Icon(Icons.file_copy_outlined,
//                                                     size: 35,
//                                                     color: Colors.green)
//                                       ],
//                                     ),
//                                   ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 30),
//                   Align(
//                     alignment: Alignment.center,
//                     child: CustomWidget().basicButton(
//                         text: "Submit",
//                         onTap: () async {
//                           _name.text.isNotEmpty &&
//                                   _email.text.isNotEmpty &&
//                                   _contactNo.text.isNotEmpty &&
//                                   _WhatsAppNo.text.isNotEmpty &&
//                                   _district.text.isNotEmpty &&
//                                   _block.text.isNotEmpty &&
//                                   _pincode.text.isNotEmpty &&
//                                   dob != "" &&
//                                   bloogGroup != null &&
//                                   state != null &&
//                                   photo != null &&
//                                   qDocs != null &&
//                                   sign != null &&
//                                   adhar != null
//                               ? await getVolunteers(context) == true
//                                   ? ScaffoldMessenger.of(context).showSnackBar(
//                                       SnackBar(
//                                           content: Text(
//                                               'You have already applied for volunteer')))
//                                   : SendData()
//                               : ScaffoldMessenger.of(context).showSnackBar(
//                                   SnackBar(
//                                       content: Text(
//                                           'Please enter all the details')));
//                         }),
//                   ),
//                   SizedBox(height: 30),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     ));
//   }
//
//   Future<void> SendData() async {
//
//     pan ??= await getImageFileFromAssets('images/notfound.png');
//     character ??= await getImageFileFromAssets('images/notfound.png');
//
//     try {
//       _showProgress(context);
//       Map<String, String> headers = {
//         'Content-Type': 'application/json',
//         'Accept': 'application/json',
//         'Authorization':
//             'Bearer ${await SessionManager().getString(Constant.access_token)}'
//       };
//       print(headers);
//       Uri uri = Uri.parse(Webservices.volunteerCreate);
//       var _request = https.MultipartRequest('POST', uri);
//       _request.headers.addAll(headers);
//
//       if (photo != null && qDocs != null) {
//         _request.files
//             .add(await https.MultipartFile.fromPath('photo', photo!.path));
//
//         _request.files.add(await https.MultipartFile.fromPath(
//             'qualification_doc', qDocs!.path));
//         _request.files
//             .add(await https.MultipartFile.fromPath('signature', sign!.path));
//         _request.files
//             .add(await https.MultipartFile.fromPath('adhar_card', adhar!.path));
//         _request.files
//             .add(await https.MultipartFile.fromPath('pan_card', pan!.path));
//         _request.files.add(await https.MultipartFile.fromPath(
//             'character_certitificate', character!.path));
//       }
//
//       _request.fields["name"] = _name.text;
//       _request.fields["DOB"] = dob;
//       _request.fields["blood_group"] = bloogGroup ?? '';
//       _request.fields["contact_no"] = _contactNo.text;
//       _request.fields["whatsapp_no"] = _WhatsAppNo.text;
//       _request.fields["email"] = _email.text;
//       _request.fields["state"] = state ?? '';
//       _request.fields["pin"] = _pincode.text;
//
//       _request.fields["district"] = _district.text;
//       _request.fields["ward_no"] = _block.text;
//       _request.fields["qualification"] = q.toString();
//       _request.fields["skills"] = s.toString();
//       _request.fields["involved_days"] = _days.name;
//       _request.fields["austere_condition"] = _austereCondition.name;
//       _request.fields["calamity_days"] = _calamity.name;
//       _request.fields["notice_period"] = _notice.name ;
//       _request.fields["emergency_period"] = _emergency.name ;
//
//       print("------request11------${_request.fields}");
//       print("------request--22----${_request.files}");
//       print("------request----33--$_request");
//
//       var streamedResponse = await _request.send();
//       https.Response res = await https.Response.fromStream(streamedResponse);
//       print('response.body ${res.statusCode}');
//       print("-----respnse----${res.body}");
//
//       if (res.statusCode == 201) {
//         AwesomeDialog(
//           context: context,
//           animType: AnimType.scale,
//           dialogType: DialogType.SUCCES,
//           title: 'Form Submitted Successfully',
//           desc:
//               'Your request for the volunteer has been submitted successfully',
//           btnOkOnPress: () {
//             _name.clear();
//             dob = "";
//             _email.clear();
//             _contactNo.clear();
//             _WhatsAppNo.clear();
//             _district.clear();
//             bloogGroup = null;
//             state = null;
//             _block.clear();
//             _pincode.clear();
//             Skills = [
//               {'Driving': false},
//               {'Swimming': false},
//               {'Electrician': false},
//               {'Plumbing': false},
//               {'Acting': false},
//               {'Singing': false},
//               {'Public Speaking': false},
//               {'Writing': false},
//               {'IT Proficient': false},
//               {'Graphic Designing': false}
//             ];
//             Qualification = [
//               {'10th': false},
//               {'12th': false},
//               {'Diploma': false},
//               {'Graduation': false},
//               {'Post Graduation': false},
//               {'PhD': false},
//               {'Other': false}
//             ];
//             notice = null;
//             leave = null;
//             photo = null;
//             qDocs = null;
//             sign = null;
//             adhar = null;
//             pan = null;
//             character = null;
//
//             Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (BuildContext context) => Success()));
//           },
//         ).show();
//       } else {
//         print("errroroororr");
//       }
//     } on Expanded catch (e) {
//       print(e.toString());
//     }
//   }
//
//   _showProgress(BuildContext context) {
//     progressDialog = ProgressDialog(context: context);
//     progressDialog.show(
//         max: 100,
//         msg: "Loading",
//         progressValueColor: Colors.orange,
//         progressType: ProgressType.valuable);
//   }
//
//   _hideProgress() {
//     progressDialog.isOpen() ? progressDialog.close(delay: 0) : print('asdsa');
//     ;
//   }
//
//   Future<bool> getVolunteers(BuildContext context) async {
//     try {
//       //  CustomWidget().showProgress(context: context);
//       String url = Webservices.getVolunteer +
//           "sbf_ID/" +
//           await SessionManager().getString(Constant.SBFID);
//       print(url);
//       var response = await https.get(Uri.parse(url), headers: {
//         'Content-Type': 'application/json',
//         'Accept': 'application/json',
//         'Authorization':
//             'Bearer ${await SessionManager().getString(Constant.access_token)}'
//       });
//       var data = jsonDecode(response.body);
//       print(response.body);
//
//       if (response.statusCode == 201) {
//         print(response);
//         if (data['msg'].isEmpty) {
//           print("Msg is empty");
//           return false;
//         }
//         //  CustomWidget().hidProgress(context: context);
//         else {
//           return true;
//         }
//       } else {
//         // CustomWidget().hidProgress(context: context);
//
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//             content: Text(
//           'Some error occured',
//           style: TextStyle(color: Colors.red),
//         )));
//       }
//     } on Exception catch (e) {
//       print(e.toString());
//       // _hideProgress();
//     }
//
//     return true;
//   }
//
//   Future<File> getImageFileFromAssets(String path) async {
//     final byteData = await rootBundle.load('assets/$path');
//
//     final file = File('${(await getTemporaryDirectory()).path}/image.png');
//     await file.create(recursive: true);
//     await file.writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
//
//     return file;
//   }
// }
