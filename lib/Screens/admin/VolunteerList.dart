// import 'dart:convert';
// import 'dart:io';
// import 'package:awesome_dialog/awesome_dialog.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_pdfview/flutter_pdfview.dart';
// import 'package:open_file/open_file.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:pdf_merger/pdf_merger.dart';
// import 'package:pdf_merger/pdf_merger_response.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:sbf_mobile_app/CustomUI/CustomWidgets.dart';
// import 'package:sbf_mobile_app/Screens/admin/viewApplication.dart';
// import 'package:sbf_mobile_app/Screens/volunteer.dart';
// import 'package:sidebarx/sidebarx.dart';
// import 'package:http/http.dart' as https;
// import 'package:url_launcher/url_launcher.dart';
// import '../../Constant.dart';
// import '../../CustomUI/Appbar.dart';
// import '../../pdfViewer.dart';
// import '../../preferences/preferences.dart';
// import '../../webservices.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:printing/printing.dart';
// import 'package:transparent_image/transparent_image.dart';
//
// class VolunteerList extends StatefulWidget {
//   const VolunteerList({Key? key}) : super(key: key);
//
//   @override
//   State<VolunteerList> createState() => _VolunteerListState();
// }
//
// enum Interest { WeekDays, Weekend }
//
// enum AustereCondition { yes, no }
//
// enum calamity { oneweek, twoweek, onemonth }
//
// enum noticePeriod {
//   oneDay,
//   twoDays,
//   twotofivedays,
//   seventotendays,
// }
//
// enum emergencyDays { Anytime, Within24Hours, hrs48, days2, days5, days7 }
//
// String? notice;
// String? leave;
// String session = DateTime.now().month >= 3
//     ? '${DateTime.now().year}-${DateTime.now().year + 1}'
//     : '${DateTime.now().year - 1}-${DateTime.now().year}';
// String CurrentSession = DateTime.now().month >= 3
//     ? '${DateTime.now().year}-${DateTime.now().year + 1}'
//     : '${DateTime.now().year - 1}-${DateTime.now().year}';
//
// final _controller = SidebarXController(selectedIndex: 0, extended: true);
//
// final _key = GlobalKey<ScaffoldState>();
//
// class _VolunteerListState extends State<VolunteerList> {
//   String SBFID = '';
//   String userType = '';
//   String Userstate = '';
//   var Vdata;
//   var ReportPath;
//
//   pw.TextStyle fieldsStyle2 =
//       pw.TextStyle(fontSize: 13, fontWeight: pw.FontWeight.bold);
//   pw.TextStyle detailsStyle2 = pw.TextStyle(fontSize: 13);
//
//   TextEditingController _field = TextEditingController();
//   TextEditingController _value = TextEditingController();
//   TextEditingController _bg = TextEditingController();
//   TextEditingController _district = TextEditingController();
//   TextEditingController _state = TextEditingController();
//   TextEditingController _pin = TextEditingController();
//   TextEditingController _qualification = TextEditingController();
//   TextEditingController _skill = TextEditingController();
//
//   List<Map<String, bool>> Qualification = [
//     {'10th': false},
//     {'12th': false},
//     {'Diploma': false},
//     {'Graduation': false},
//     {'Post Graduation': false},
//     {'PhD': false},
//     {'Other': false}
//   ];
//
//   List<Map<String, bool>> Skills = [
//     {'Driving': false},
//     {'Swimming': false},
//     {'Electrician': false},
//     {'Plumbing': false},
//     {'Acting': false},
//     {'Singing': false},
//     {'Public Speaking': false},
//     {'Writing': false},
//     {'IT Proficient': false},
//     {'Graphic Designing': false}
//   ];
//
//   String? q;
//   List s = [];
//
//   TextStyle fieldsStyle = TextStyle(fontSize: 13, fontWeight: FontWeight.bold);
//   TextStyle detailsStyle = TextStyle(fontSize: 13);
//   int selectedTile = -1;
//   List<bool> expanded =
//       new List.generate(1000, (index) => false, growable: true);
//
//   @override
//   void initState() {
//     super.initState();
//
//     getDetails();
//     Future.delayed(Duration(seconds: 2));
//     getVolunteers();
//
//     // TODO: implement initState
//   }
//
//   Interest _days = Interest.WeekDays;
//   AustereCondition _austereCondition = AustereCondition.yes;
//   calamity _calamity = calamity.oneweek;
//   noticePeriod _notice = noticePeriod.oneDay;
//   emergencyDays _emergency = emergencyDays.Anytime;
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Scaffold(
//       drawer: ExampleSidebarXadmin(
//         controller: _controller,
//         www: _key,
//       ),
//       key: _key,
//       body: Vdata == null
//           ? Center(child: CircularProgressIndicator())
//           : Column(
//               children: [
//                 Appbar(context, _key),
//                 Container(
//                   width: double.infinity,
//                   height: 80,
//                   color: Color(0xff016507),
//                   child: Center(
//                     child: Text(
//                       userType == '1'
//                           ? 'Local Level Admin'
//                           : userType == '2'
//                               ? 'State Level Admin'
//                               : userType == '3'
//                                   ? 'National Level Admin'
//                                   : 'Super Admin',
//                       style: TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.w900,
//                           fontSize: 25),
//                     ),
//                   ),
//                 ),
//                 // Container(
//                 //   width: MediaQuery.of(context).size.width,
//                 //   height: 100,
//                 //   child: Row(
//                 //     children: [
//                 //       SizedBox(width: 10),
//                 //       Container(
//                 //         width: MediaQuery.of(context).size.width / 2.5,
//                 //         child: CustomWidget().FormField(
//                 //             label: "Search Field", controller: _field),
//                 //       ),
//                 //       SizedBox(width: 10),
//                 //       Container(
//                 //         width: MediaQuery.of(context).size.width / 2.5,
//                 //         child: CustomWidget()
//                 //             .FormField(label: "Value", controller: _value),
//                 //       ),
//                 //       SizedBox(width: 10),
//                 //       GestureDetector(
//                 //         onTap: () {
//                 //           _field.text.isEmpty || _value.text.isEmpty
//                 //               ? getVolunteers()
//                 //               : getVolunteersbySearch(_field.text, _value.text);
//                 //         },
//                 //         child: Container(
//                 //             color: Colors.deepPurple,
//                 //             child: Padding(
//                 //               padding: const EdgeInsets.all(5.0),
//                 //               child: Icon(
//                 //                 Icons.search_outlined,
//                 //                 size: 30,
//                 //                 color: Colors.white,
//                 //               ),
//                 //             )),
//                 //       )
//                 //     ],
//                 //   ),
//                 // ),
//                 Row(
//                   children: [
//                     GestureDetector(
//                       onTap: () {
//                         showModalBottomSheet(
//                             context: context,
//                             elevation: 4,
//                             enableDrag: true,
//                             builder: (BuildContext context) {
//                               return StatefulBuilder(builder:
//                                   (BuildContext context, StateSetter setState) {
//                                 return SingleChildScrollView(
//                                   child: SafeArea(
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(8.0),
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Center(
//                                             child: SizedBox(
//                                                 height: 40,
//                                                 width: 80,
//                                                 child: Divider(
//                                                   thickness: 2,
//                                                   color: Colors.black54,
//                                                 )),
//                                           ),
//                                           CustomWidget().FormField2(
//                                               label: 'Blood Group',
//                                               controller: _bg),
//                                           SizedBox(height: 10),
//                                           CustomWidget().FormField2(
//                                               label: 'District',
//                                               controller: _district),
//                                           SizedBox(height: 10),
//                                           CustomWidget().FormField2(
//                                               label: 'State',
//                                               controller: _state),
//                                           SizedBox(height: 10),
//                                           CustomWidget().FormField2(
//                                               label: 'Pin Code',
//                                               controller: _pin),
//                                           SizedBox(height: 10),
//                                           Padding(
//                                             padding: const EdgeInsets.all(8.0),
//                                             child: Align(
//                                               alignment: Alignment.centerLeft,
//                                               child: Text(
//                                                 'Qualification',
//                                                 style: TextStyle(
//                                                     color: Colors.black,
//                                                     fontSize: 15),
//                                               ),
//                                             ),
//                                           ),
//                                           Column(children: [
//                                             ListView.builder(
//                                                 physics:
//                                                     ClampingScrollPhysics(),
//                                                 shrinkWrap: true,
//                                                 itemCount: Qualification.length,
//                                                 itemBuilder:
//                                                     (BuildContext context,
//                                                         int i) {
//                                                   return CheckboxListTile(
//                                                     activeColor: Colors.green,
//
//                                                     title: Text(Qualification[i]
//                                                         .keys
//                                                         .first),
//                                                     value: Qualification[i]
//                                                             [q] ??
//                                                         false,
//                                                     onChanged: (newValue) {
//                                                       setState(() {
//                                                         Qualification[i][
//                                                                 Qualification[i]
//                                                                     .keys
//                                                                     .first] =
//                                                             newValue ?? true;
//                                                         if (newValue == true) {
//                                                           q = Qualification[i]
//                                                               .keys
//                                                               .first;
//                                                         } else {
//                                                           q = null;
//                                                         }
//
//                                                         print(q);
//                                                       });
//                                                     },
//                                                     controlAffinity:
//                                                         ListTileControlAffinity
//                                                             .leading, //  <-- leading Checkbox
//                                                   );
//                                                 }),
//                                           ]),
//                                           Padding(
//                                             padding: const EdgeInsets.all(8.0),
//                                             child: Align(
//                                               alignment: Alignment.centerLeft,
//                                               child: Text(
//                                                 'Skills',
//                                                 style: TextStyle(
//                                                     color: Colors.black,
//                                                     fontSize: 15),
//                                               ),
//                                             ),
//                                           ),
//                                           Column(
//                                             children: [
//                                               ListView.builder(
//                                                   physics:
//                                                       ClampingScrollPhysics(),
//                                                   shrinkWrap: true,
//                                                   itemCount: Skills.length,
//                                                   itemBuilder:
//                                                       (BuildContext context,
//                                                           int i) {
//                                                     return CheckboxListTile(
//                                                       activeColor: Colors.green,
//                                                       title: Text(
//                                                           Skills[i].keys.first),
//                                                       value: Skills[i]
//                                                           .values
//                                                           .first,
//                                                       onChanged: (newValue) {
//                                                         setState(() {
//                                                           Skills[i][Skills[i]
//                                                                   .keys
//                                                                   .first] =
//                                                               newValue ?? true;
//
//                                                           if (newValue ==
//                                                               true) {
//                                                             s.insert(
//                                                                 0,
//                                                                 Skills[i].keys.firstWhere(
//                                                                     (k) =>
//                                                                         Skills[i]
//                                                                             [
//                                                                             k] ==
//                                                                         true,
//                                                                     orElse: () =>
//                                                                         ''));
//                                                           } else {
//                                                             s.removeAt(0);
//                                                           }
//                                                           print("skill${s}");
//                                                         });
//                                                       },
//                                                       controlAffinity:
//                                                           ListTileControlAffinity
//                                                               .leading, //  <-- leading Checkbox
//                                                     );
//                                                   })
//                                             ],
//                                           ),
//                                           Padding(
//                                             padding: const EdgeInsets.all(4.0),
//                                             child: Text(
//                                               'Interest to be involved',
//                                               style: TextStyle(fontSize: 17),
//                                             ),
//                                           ),
//                                           RadioListTile<Interest>(
//                                             title: Text('Weekdays'),
//                                             value: Interest.WeekDays,
//                                             contentPadding: EdgeInsets.zero,
//                                             dense: true,
//                                             groupValue: _days,
//                                             onChanged: (Interest? value) {
//                                               setState(() {
//                                                 _days = value!;
//                                               });
//                                             },
//                                           ),
//                                           RadioListTile<Interest>(
//                                             dense: true,
//                                             contentPadding: EdgeInsets.zero,
//                                             title: Text('Weekends'),
//                                             value: Interest.Weekend,
//                                             groupValue: _days,
//                                             onChanged: (Interest? value) {
//                                               setState(() {
//                                                 _days = value!;
//
//                                                 print(_days.name);
//                                               });
//                                             },
//                                           ),
//                                           Padding(
//                                             padding: const EdgeInsets.all(8.0),
//                                             child: Text(
//                                               'Are you comfortable in practicing in austere condition ?',
//                                               style: TextStyle(fontSize: 17),
//                                             ),
//                                           ),
//                                           RadioListTile<AustereCondition>(
//                                             title: Text('Yes'),
//                                             dense: true,
//                                             contentPadding: EdgeInsets.zero,
//                                             value: AustereCondition.yes,
//                                             groupValue: _austereCondition,
//                                             onChanged:
//                                                 (AustereCondition? value) {
//                                               setState(() {
//                                                 _austereCondition = value!;
//                                               });
//                                             },
//                                           ),
//                                           RadioListTile<AustereCondition>(
//                                             title: Text('No'),
//                                             dense: true,
//                                             contentPadding: EdgeInsets.zero,
//                                             value: AustereCondition.no,
//                                             groupValue: _austereCondition,
//                                             onChanged:
//                                                 (AustereCondition? value) {
//                                               setState(() {
//                                                 _austereCondition = value!;
//                                               });
//                                             },
//                                           ),
//                                           Padding(
//                                             padding: const EdgeInsets.all(8.0),
//                                             child: Text(
//                                               'How long can you be deployed during any calamity  ?',
//                                               style: TextStyle(fontSize: 17),
//                                             ),
//                                           ),
//                                           RadioListTile<calamity>(
//                                             title: Text('One Week'),
//                                             dense: true,
//                                             contentPadding: EdgeInsets.zero,
//                                             value: calamity.oneweek,
//                                             groupValue: _calamity,
//                                             onChanged: (calamity? value) {
//                                               setState(() {
//                                                 _calamity = value!;
//                                               });
//                                             },
//                                           ),
//                                           RadioListTile<calamity>(
//                                             title: Text('Two Weeks'),
//                                             dense: true,
//                                             contentPadding: EdgeInsets.zero,
//                                             value: calamity.twoweek,
//                                             groupValue: _calamity,
//                                             onChanged: (calamity? value) {
//                                               setState(() {
//                                                 _calamity = value!;
//                                               });
//                                             },
//                                           ),
//                                           RadioListTile<calamity>(
//                                             title: Text('One Month'),
//                                             dense: true,
//                                             contentPadding: EdgeInsets.zero,
//                                             value: calamity.onemonth,
//                                             groupValue: _calamity,
//                                             onChanged: (calamity? value) {
//                                               setState(() {
//                                                 _calamity = value!;
//                                               });
//                                             },
//                                           ),
//                                           Padding(
//                                             padding: const EdgeInsets.all(8.0),
//                                             child: Text(
//                                               'How much notice do you get before deployment ?',
//                                               style: TextStyle(fontSize: 17),
//                                             ),
//                                           ),
//                                           DropdownButton<String>(
//                                             elevation: 1,
//                                             items: <String>[
//                                               '24 Hours',
//                                               '48 Hours',
//                                               '2 to 5 days',
//                                               '7 to 10 days',
//                                             ].map((String value) {
//                                               return DropdownMenuItem<String>(
//                                                 value: value,
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.all(8.0),
//                                                   child: Text(value),
//                                                 ),
//                                               );
//                                             }).toList(),
//                                             value: notice,
//                                             onChanged: (value) {
//                                               setState(() {
//                                                 notice = value ?? 'Select';
//                                               });
//                                             },
//                                           ),
//                                           const Padding(
//                                             padding: EdgeInsets.all(8.0),
//                                             child: Text(
//                                               'If a disaster occurred today, how soon can you pack and leave ?',
//                                               style: TextStyle(fontSize: 17),
//                                             ),
//                                           ),
//                                           DropdownButton<String>(
//                                             elevation: 1,
//                                             items: <String>[
//                                               'Anytime',
//                                               'Within 24 Hours',
//                                               '48 Hours',
//                                               '2 days',
//                                               '5 days'
//                                                   '7 days',
//                                             ].map((String value) {
//                                               return DropdownMenuItem<String>(
//                                                 value: value,
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.all(8.0),
//                                                   child: Text(value),
//                                                 ),
//                                               );
//                                             }).toList(),
//                                             value: leave,
//                                             onChanged: (value) {
//                                               setState(() {
//                                                 leave = value ?? 'Select';
//                                               });
//                                             },
//                                           ),
//                                           Padding(
//                                             padding: const EdgeInsets.all(8.0),
//                                             child: Center(
//                                                 child:
//                                                     CustomWidget().basicButton(
//                                                         text: 'Apply',
//                                                         onTap: () {
//                                                           getVolunteersbySearch(
//                                                               'where 1'
//                                                               '${_bg.text.isEmpty == true ? '' : ' and blood_group like  "${_bg.text}"'}'
//                                                               '${_district.text.isEmpty == true ? '' : ' and district like "${_district.text}"'}'
//                                                               '${ _state.text.isEmpty == true ? '' : ' and state like "${_state.text}"'}'
//                                                               '${_pin.text.isEmpty == true ? '' : ' and pin like "${_pin.text}"'}'
//                                                               '${q == null ? '' : ' and qualification like "$q"'}'
//                                                               '${s.isEmpty ? '' : ' and skills like "$s"'}'
//                                                               '${' and involved_days like "${_days.name}"'}'
//                                                               '${' and austere_condition like "${_austereCondition.name}"'}'
//                                                               '${' and calamity_days like "${_calamity.name}"'}'
//                                                               '${notice == null ? '' : ' and notice_period like "$notice"'}'
//                                                               '${leave == null ? '' : ' and emergency_period like "$leave"'}'
//                                                               ';');
//                                                           print('where 1'
//                                                               '${_bg.text.isEmpty == true ? '' : 'and blood_group is like %${_bg.text}%'}'
//                                                               '${_district.text.isEmpty == true ? '' : 'and district is like %${_district.text}%'}');
//                                                         })),
//                                           )
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 );
//                               });
//                             });
//                       },
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Align(
//                           alignment: Alignment.centerLeft,
//                           child: Card(
//                             elevation: 4.0,
//                             child: Padding(
//                               padding: const EdgeInsets.all(10.0),
//                               child: Row(
//                                 children: [
//                                   Icon(
//                                     Icons.filter_alt,
//                                     size: 30,
//                                   ),
//                                   SizedBox(width: 10),
//                                   Text(
//                                     'FILTER VOLUNTEERS',
//                                     style: TextStyle(
//                                         color: Colors.deepPurple, fontSize: 15),
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Container(
//                       child: DropdownButton<String>(
//                         elevation: 1,
//                         items: <String>[
//                           '2022-2023',
//                           '2023-2024',
//                           '2024-2025',
//                           '2025-2026',
//                           '2026-2027'
//                         ].map((String value) {
//                           return DropdownMenuItem<String>(
//                             value: value,
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Text(value),
//                             ),
//                           );
//                         }).toList(),
//                         value: session,
//                         onChanged: (value) {
//                           if(userType=='2'){
//                             setState(() {
//                               session = value ?? '2022-2023';
//                               getVolunteersbySearch("where state = '${Userstate}' and session ='$session'");
//                             });
//                           }
//                           else{
//                             setState(() {
//                               session = value ?? '2022-2023';
//                               getVolunteersbySearch("where session ='$session'");
//                             });
//                           }
//
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: GestureDetector(
//                           onTap: () {
//                             if(userType=='2'){
//                               setState(() {
//                                 session = CurrentSession;
//                               });
//                               getVolunteersbySearch(
//                                   "where 1 and state = '${Userstate}' and session = '${session}'");
//
//                             }
//                             else{
//                               setState(() {
//                                 session = CurrentSession;
//                               });
//                               getVolunteersbySearch(
//                                   "where 1 and session = '${session}'");
//
//                             }
//
//
//                           },
//                           child: Card(
//                               child: Row(
//                             children: [
//                               Icon(
//                                 Icons.refresh,
//                                 size: 25,
//                               ),
//                               Text('Reset Filter'),
//                             ],
//                           ))),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: GestureDetector(
//                         onTap: () async {
//                           String url = ReportPath;
//                           if (await canLaunchUrl(Uri.parse(url))) {
//                             await launchUrl(Uri.parse(url),
//                                 mode: LaunchMode.externalApplication);
//                           } else {
//                             throw 'Could not launch $url';
//                           }
//                         },
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Text('Generate Report'),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 Expanded(
//                   child: ListView.builder(
//                       physics: ClampingScrollPhysics(),
//                       shrinkWrap: true,
//                       key: Key(selectedTile.toString()),
//                       itemCount: Vdata.length,
//                       itemBuilder: (BuildContext context, int index) {
//                         return Padding(
//                           padding: const EdgeInsets.all(2.0),
//                           child: Container(
//                             color: const Color(0xffefefef),
//                             child: ExpansionTile(
//                               key: Key(index.toString()),
//                               initiallyExpanded: index == selectedTile,
//
//
//
//                               onExpansionChanged: (value) {
//
//
//
//
//
//                                 if (value) {
//                                   setState(() {
//                                     selectedTile = index;
//                                     // expanded[index] = value;
//                                   });
//                                 } else {
//                                   setState(() {
//                                     selectedTile = -1;
//                                    // expanded[index] = value;
//                                   });
//                                 }
//                               },
//                               title: Row(
//                                 children: [
//                                   FadeInImage.memoryNetwork(
//                                     placeholder: kTransparentImage,
//                                     image: Vdata[index]['photo'],
//                                     width: 60,
//                                     height: 60,
//                                     fit: BoxFit.fill,
//                                     placeholderErrorBuilder:
//                                         (context, Object, StackTrace) {
//                                       return Icon(Icons.image);
//                                     },
//                                   ),
//                                   SizedBox(width: 20),
//                                   // expanded[index] == false
//                               //        ?
//                               Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             Row(
//                                               children: [
//                                                 Text(
//                                                   'SBF ID :',
//                                                   style: fieldsStyle,
//                                                 ),
//                                                 Text(Vdata[index]['sbf_ID'],
//                                                     style: detailsStyle)
//                                               ],
//                                             ),
//                                             Row(
//                                               children: [
//                                                 Text(
//                                                   'Name :',
//                                                   style: fieldsStyle,
//                                                 ),
//                                                 Text(Vdata[index]['name'],
//                                                     style: detailsStyle)
//                                               ],
//                                             ),
//                                             Row(
//                                               children: [
//                                                 Text(
//                                                   'Email :',
//                                                   style: fieldsStyle,
//                                                 ),
//                                                 Text(Vdata[index]['email'],
//                                                     style: detailsStyle)
//                                               ],
//                                             ),
//                                           ],
//                                         )
//
//                                 ],
//                               ),
//                               children: [
//                                 Row(
//                                   children: [
//                                     SizedBox(
//                                         width: MediaQuery.of(context)
//                                             .size
//                                             .width /
//                                             6),
//                                     (userType == '4' || userType =='3') ?
//                                     RawMaterialButton(
//                                       onPressed: () async {
//                                         if (await askPermission() ==
//                                             true) {
//                                           downloadApplication(index);
//                                         }
//                                       },
//                                       elevation: 2.0,
//                                       fillColor: Colors.red,
//                                       splashColor: Colors.redAccent,
//                                       constraints: BoxConstraints(
//                                           minWidth: 0,
//                                           maxWidth: 50,
//                                           minHeight: 0),
//                                       child: Icon(
//                                         Icons.print,
//                                         size: 30.0,
//                                         color: Colors.white,
//                                       ),
//                                       padding: EdgeInsets.all(10.0),
//                                       shape: CircleBorder(),
//                                     ) :Container(),
//                                     SizedBox(width: 10),
//                                     Vdata[index][
//                                     'local_level_approved'] ==
//                                         '1' &&
//                                         Vdata[index][
//                                         'state_level_approved'] ==
//                                             '1' &&
//                                         Vdata[index][
//                                         'central_level_approved'] ==
//                                             '1' &&
//
//                                     (userType == '4' || userType =='3')
//                                         ?
//
//                                     RawMaterialButton(
//                                         onPressed: () async {
//                                           if (await askPermission() ==
//                                               true) {
//                                             downloadID(index);
//                                           }
//                                         },
//                                         elevation: 2.0,
//                                         fillColor: Colors.blue,
//                                         splashColor:
//                                         Colors.lightBlue,
//                                         constraints: BoxConstraints(
//                                             minWidth: 0,
//                                             maxWidth: 50,
//                                             minHeight: 0),
//                                         padding:
//                                         EdgeInsets.all(10.0),
//                                         shape: CircleBorder(),
//                                         child: const ImageIcon(
//                                           AssetImage(
//                                               'assets/images/id-card.png'),
//                                           size: 30.0,
//                                           color: Colors.white,
//                                         ))
//                                         : Container(),
//                                     SizedBox(width: 10),
//                                     // userType == "1" ||
//                                     //         userType == "2" ||
//                                     //         userType == "3" ||
//                                     //         userType == '4'
//                                     //     ? Vdata[index]['local_level_approved'] == "1"
//                                     //         ? RawMaterialButton(
//                                     //             onPressed: () {},
//                                     //             elevation: 2.0,
//                                     //             fillColor: Colors.teal,
//                                     //             splashColor:
//                                     //                 Colors.tealAccent,
//                                     //             constraints:
//                                     //                 BoxConstraints(
//                                     //                     minWidth: 0,
//                                     //                     maxWidth: 50,
//                                     //                     minHeight: 0),
//                                     //             child: Icon(
//                                     //               Icons.done,
//                                     //               size: 30.0,
//                                     //               color: Colors.white,
//                                     //             ),
//                                     //             padding: EdgeInsets.all(
//                                     //                 10.0),
//                                     //             shape: CircleBorder(),
//                                     //           )
//                                     //         : RawMaterialButton(
//                                     //             onPressed: () {
//                                     //               LocalLevel(
//                                     //                   Vdata[index]
//                                     //                       ['sbf_ID']);
//                                     //             },
//                                     //             elevation: 2.0,
//                                     //             fillColor: Colors.green,
//                                     //             splashColor:
//                                     //                 Colors.lightGreen,
//                                     //             constraints:
//                                     //                 BoxConstraints(
//                                     //                     minWidth: 0,
//                                     //                     maxWidth: 50,
//                                     //                     minHeight: 0),
//                                     //             child: Icon(
//                                     //               Icons.approval,
//                                     //               size: 30.0,
//                                     //               color: Colors.white,
//                                     //             ),
//                                     //             padding: EdgeInsets.all(
//                                     //                 10.0),
//                                     //             shape: CircleBorder(),
//                                     //           ) :Container() ,
//                                     //      userType == "2" ||
//                                     //             userType == '3' ||
//                                     //             userType == '4'
//                                     //         ? Vdata[index][
//                                     //                     'state_level_approved'] ==
//                                     //                 "1"
//                                     //             ? RawMaterialButton(
//                                     //                 onPressed: () {},
//                                     //                 elevation: 2.0,
//                                     //                 fillColor:
//                                     //                     Colors.teal,
//                                     //                 splashColor: Colors
//                                     //                     .tealAccent,
//                                     //                 constraints:
//                                     //                     const BoxConstraints(
//                                     //                         minWidth: 0,
//                                     //                         maxWidth:
//                                     //                             50,
//                                     //                         minHeight:
//                                     //                             0),
//                                     //                 child: const Icon(
//                                     //                   Icons.done,
//                                     //                   size: 30.0,
//                                     //                   color:
//                                     //                       Colors.white,
//                                     //                 ),
//                                     //                 padding:
//                                     //                     EdgeInsets.all(
//                                     //                         10.0),
//                                     //                 shape:
//                                     //                     CircleBorder(),
//                                     //               )
//                                     //             : RawMaterialButton(
//                                     //                 onPressed: () {
//                                     //                   Userstate ==
//                                     //                           Vdata[index]
//                                     //                               [
//                                     //                               'state']
//                                     //                       ? StateLevel(
//                                     //                           Vdata[index]
//                                     //                               [
//                                     //                               'sbf_ID'])
//                                     //                       : ScaffoldMessenger.of(
//                                     //                               context)
//                                     //                           .showSnackBar(SnackBar(
//                                     //                               content:
//                                     //                                   Text('You cannot give approval of volunteer from another state')));
//                                     //                 },
//                                     //                 elevation: 2.0,
//                                     //                 fillColor:
//                                     //                     Colors.green,
//                                     //                 splashColor: Colors
//                                     //                     .lightGreen,
//                                     //                 constraints:
//                                     //                     BoxConstraints(
//                                     //                         minWidth: 0,
//                                     //                         maxWidth:
//                                     //                             50,
//                                     //                         minHeight:
//                                     //                             0),
//                                     //                 child: Icon(
//                                     //                   Icons.approval,
//                                     //                   size: 30.0,
//                                     //                   color:
//                                     //                       Colors.white,
//                                     //                 ),
//                                     //                 padding:
//                                     //                     EdgeInsets.all(
//                                     //                         10.0),
//                                     //                 shape:
//                                     //                     CircleBorder(),
//                                     //               ) : Container(),
//                                     //          userType == '3' ||
//                                     //                 userType == '4'
//                                     //             ? Vdata[index][
//                                     //                         'central_level_approved'] ==
//                                     //                     "1"
//                                     //                 ? RawMaterialButton(
//                                     //                     onPressed:
//                                     //                         () {},
//                                     //                     elevation: 2.0,
//                                     //                     fillColor:
//                                     //                         Colors.teal,
//                                     //                     splashColor: Colors
//                                     //                         .tealAccent,
//                                     //                     constraints:
//                                     //                         BoxConstraints(
//                                     //                             minWidth:
//                                     //                                 0,
//                                     //                             maxWidth:
//                                     //                                 50,
//                                     //                             minHeight:
//                                     //                                 0),
//                                     //                     child: Icon(
//                                     //                       Icons.done,
//                                     //                       size: 30.0,
//                                     //                       color: Colors
//                                     //                           .white,
//                                     //                     ),
//                                     //                     padding:
//                                     //                         EdgeInsets
//                                     //                             .all(
//                                     //                                 10.0),
//                                     //                     shape:
//                                     //                         CircleBorder(),
//                                     //                   )
//                                     //                 : RawMaterialButton(
//                                     //                     onPressed: () {
//                                     //                       CentralLevel(Vdata[
//                                     //                               index]
//                                     //                           [
//                                     //                           'sbf_ID']);
//                                     //                     },
//                                     //                     elevation: 2.0,
//                                     //                     fillColor:
//                                     //                         Colors
//                                     //                             .green,
//                                     //                     splashColor: Colors
//                                     //                         .lightGreen,
//                                     //                     constraints:
//                                     //                         BoxConstraints(
//                                     //                             minWidth:
//                                     //                                 0,
//                                     //                             maxWidth:
//                                     //                                 50,
//                                     //                             minHeight:
//                                     //                                 0),
//                                     //                     child: Icon(
//                                     //                       Icons
//                                     //                           .approval,
//                                     //                       size: 30.0,
//                                     //                       color: Colors
//                                     //                           .white,
//                                     //                     ),
//                                     //                     padding:
//                                     //                         EdgeInsets
//                                     //                             .all(
//                                     //                                 10.0),
//                                     //                     shape:
//                                     //                         CircleBorder(),
//                                     //                   )
//                                     //             : Container(),
//                                   ],
//                                 ),
//                                 Deatils(index)],
//                             ),
//                           ),
//                         );
//                       }),
//                 )
//               ],
//             ),
//     ));
//   }
//
//   void getDetails() async {
//     SBFID = await SessionManager().getString(Constant.SBFID);
//     userType = await SessionManager().getString(Constant.userType);
//     Userstate = await SessionManager().getString(Constant.state);
//
//
//   }
//
//   Future<bool> askPermission() async {
//     PermissionStatus status = await Permission.accessMediaLocation.request();
//     PermissionStatus storage = await Permission.storage.request();
//     PermissionStatus files = await Permission.manageExternalStorage.request();
//     PermissionStatus file = await Permission.mediaLibrary.request();
//
//     print(status);
//     if (status.isDenied == true || status.isPermanentlyDenied == true) {
//       askPermission();
//     } else {
//       return true;
//     }
//     return false;
//   }
//
//   void downloadApplication(int index) async {
//     final pdf = pw.Document();
//
//     CustomWidget().showProgress(context: context);
//     final adhar = await networkImage(Vdata[index]['adhar_card']);
//     final Pan = await networkImage(Vdata[index]['pan_card']);
//     final Signature = await networkImage(Vdata[index]['signature']);
//     final character = await networkImage(Vdata[index]['character_certificate']);
//     final photo = await networkImage(Vdata[index]['photo']);
//
//     final logo = pw.MemoryImage(
//       (await rootBundle.load('assets/images/SBF_logo.png'))
//           .buffer
//           .asUint8List(),
//     );
//
//     pdf.addPage(pw.MultiPage(
//         margin: const pw.EdgeInsets.all(5),
//         pageFormat: PdfPageFormat.a4,
//         build: (pw.Context context) {
//           return [
//             pw.Padding(
//               padding: const pw.EdgeInsets.all(8.0),
//               child: pw.Column(
//                 crossAxisAlignment: pw.CrossAxisAlignment.start,
//                 children: [
//                   pw.Align(
//                       alignment: pw.Alignment.center,
//                       child: pw.Container(
//                         width: 400,
//                         child: pw.Row(
//                           children: [
//                             pw.Image(logo, width: 90, height: 90),
//                             pw.Text('SOCIETY FOR BRIGHT FUTURE',
//                                 style: pw.TextStyle(
//                                     color: PdfColor.fromInt(0xffFFA500),
//                                     fontSize: 20,
//                                     fontWeight: pw.FontWeight.bold))
//                           ],
//                         ),
//                       )),
//                   pw.Align(
//                     alignment: pw.Alignment.center,
//                     child: pw.Text('Volunteer Application',
//                         style: pw.TextStyle(
//                             color: PdfColor.fromInt(0xff000000),
//                             fontSize: 20,
//                             fontWeight: pw.FontWeight.bold)),
//                   ),
//                   pw.Stack(children: [
//                     pw.Column(children: [
//                       pw.SizedBox(height: 20),
//                       pw.Row(
//                         mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
//                         children: [
//                           pw.Container(
//                               width: 130,
//                               child: pw.Row(
//                                 mainAxisAlignment:
//                                     pw.MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   pw.Text("SBF ID", style: fieldsStyle2),
//                                   pw.Text(
//                                     ":",
//                                     style: fieldsStyle2,
//                                   )
//                                 ],
//                               )),
//                           pw.Container(
//                               width: 240,
//                               child: pw.Text(Vdata[index]['sbf_ID'],
//                                   style: detailsStyle2))
//                         ],
//                       ),
//                       pw.Row(
//                         mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
//                         children: [
//                           pw.Container(
//                               width: 130,
//                               child: pw.Row(
//                                 mainAxisAlignment:
//                                     pw.MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   pw.Text("Name", style: fieldsStyle2),
//                                   pw.Text(
//                                     ":",
//                                     style: fieldsStyle2,
//                                   )
//                                 ],
//                               )),
//                           pw.Container(
//                               width: 240,
//                               child: pw.Text(Vdata[index]['name'],
//                                   style: detailsStyle2))
//                         ],
//                       ),
//                       pw.Row(
//                         mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
//                         children: [
//                           pw.Container(
//                               width: 130,
//                               child: pw.Row(
//                                 mainAxisAlignment:
//                                     pw.MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   pw.Text("Email", style: fieldsStyle2),
//                                   pw.Text(
//                                     ":",
//                                     style: fieldsStyle2,
//                                   )
//                                 ],
//                               )),
//                           pw.Container(
//                               width: 240,
//                               child: pw.Text(Vdata[index]['email'],
//                                   style: detailsStyle2))
//                         ],
//                       ),
//                       pw.Row(
//                         mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
//                         children: [
//                           pw.Container(
//                               width: 130,
//                               child: pw.Row(
//                                 mainAxisAlignment:
//                                     pw.MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   pw.Text("DOB", style: fieldsStyle2),
//                                   pw.Text(
//                                     ":",
//                                     style: fieldsStyle2,
//                                   )
//                                 ],
//                               )),
//                           pw.Container(
//                               width: 240,
//                               child: pw.Text(Vdata[index]['DOB'],
//                                   style: detailsStyle2))
//                         ],
//                       ),
//                       pw.Row(
//                         mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
//                         children: [
//                           pw.Container(
//                               width: 130,
//                               child: pw.Row(
//                                 mainAxisAlignment:
//                                     pw.MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   pw.Text("Blood Group", style: fieldsStyle2),
//                                   pw.Text(
//                                     ":",
//                                     style: fieldsStyle2,
//                                   )
//                                 ],
//                               )),
//                           pw.Container(
//                               width: 240,
//                               child: pw.Text(Vdata[index]['blood_group'],
//                                   style: detailsStyle2))
//                         ],
//                       ),
//                       pw.Row(
//                         mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
//                         children: [
//                           pw.Container(
//                               width: 130,
//                               child: pw.Row(
//                                 mainAxisAlignment:
//                                     pw.MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   pw.Text("Contact No.", style: fieldsStyle2),
//                                   pw.Text(
//                                     ":",
//                                     style: fieldsStyle2,
//                                   )
//                                 ],
//                               )),
//                           pw.Container(
//                               width: 240,
//                               child: pw.Text(Vdata[index]['contact_no'],
//                                   style: detailsStyle2))
//                         ],
//                       ),
//                       pw.Row(
//                         mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
//                         children: [
//                           pw.Container(
//                               width: 130,
//                               child: pw.Row(
//                                 mainAxisAlignment:
//                                     pw.MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   pw.Text("WhatsApp No.", style: fieldsStyle2),
//                                   pw.Text(
//                                     ":",
//                                     style: fieldsStyle2,
//                                   )
//                                 ],
//                               )),
//                           pw.Container(
//                               width: 240,
//                               child: pw.Text(Vdata[index]['whatsapp_no'],
//                                   style: detailsStyle2))
//                         ],
//                       ),
//                       pw.Row(
//                         mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
//                         children: [
//                           pw.Container(
//                               width: 130,
//                               child: pw.Row(
//                                 mainAxisAlignment:
//                                     pw.MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   pw.Text("State", style: fieldsStyle2),
//                                   pw.Text(
//                                     ":",
//                                     style: fieldsStyle2,
//                                   )
//                                 ],
//                               )),
//                           pw.Container(
//                               width: 240,
//                               child: pw.Text(Vdata[index]['state'],
//                                   style: detailsStyle2))
//                         ],
//                       ),
//                       pw.Row(
//                         mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
//                         children: [
//                           pw.Container(
//                               width: 130,
//                               child: pw.Row(
//                                 mainAxisAlignment:
//                                     pw.MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   pw.Text("District", style: fieldsStyle2),
//                                   pw.Text(
//                                     ":",
//                                     style: fieldsStyle2,
//                                   )
//                                 ],
//                               )),
//                           pw.Container(
//                               width: 240,
//                               child: pw.Text(Vdata[index]['district'],
//                                   style: detailsStyle2))
//                         ],
//                       ),
//                       pw.Row(
//                         mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
//                         children: [
//                           pw.Container(
//                               width: 130,
//                               child: pw.Row(
//                                 mainAxisAlignment:
//                                     pw.MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   pw.Text("Ward No.", style: fieldsStyle2),
//                                   pw.Text(
//                                     ":",
//                                     style: fieldsStyle2,
//                                   )
//                                 ],
//                               )),
//                           pw.Container(
//                               width: 240,
//                               child: pw.Text(Vdata[index]['ward_no'],
//                                   style: detailsStyle2))
//                         ],
//                       ),
//                       pw.Row(
//                         mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
//                         children: [
//                           pw.Container(
//                               width: 130,
//                               child: pw.Row(
//                                 mainAxisAlignment:
//                                     pw.MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   pw.Text("Qualification", style: fieldsStyle2),
//                                   pw.Text(
//                                     ":",
//                                     style: fieldsStyle2,
//                                   )
//                                 ],
//                               )),
//                           pw.Container(
//                               width: 240,
//                               child: pw.Text(
//                                   Vdata[index]['qualification']
//                                       .toString()
//                                       .replaceAll("[", "")
//                                       .replaceAll("]", ""),
//                                   style: detailsStyle2))
//                         ],
//                       ),
//                       pw.Row(
//                         mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
//                         children: [
//                           pw.Container(
//                               width: 130,
//                               child: pw.Row(
//                                 mainAxisAlignment:
//                                     pw.MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   pw.Text("Skill", style: fieldsStyle2),
//                                   pw.Text(
//                                     ":",
//                                     style: fieldsStyle2,
//                                   )
//                                 ],
//                               )),
//                           pw.Container(
//                               width: 240,
//                               child: pw.Text(
//                                   Vdata[index]['skills']
//                                       .toString()
//                                       .replaceAll("[", "")
//                                       .replaceAll("]", ""),
//                                   style: detailsStyle2))
//                         ],
//                       ),
//                     ]),
//                     pw.Positioned(
//                         top: 10,
//                         right: 10,
//                         child: pw.Image(photo,
//                             width: 100, height: 130, fit: pw.BoxFit.fill))
//                   ]),
//                   pw.SizedBox(height: 20, child: pw.Divider()),
//                   pw.Row(
//                     mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
//                     children: [
//                       pw.Container(
//                           width: 170,
//                           child: pw.Row(
//                             mainAxisAlignment:
//                                 pw.MainAxisAlignment.spaceBetween,
//                             children: [
//                               pw.Container(
//                                 width: 160,
//                                 child: pw.Text("Interest to be Involved",
//                                     style: fieldsStyle2),
//                               ),
//                               pw.Text(
//                                 ":",
//                                 style: fieldsStyle2,
//                               )
//                             ],
//                           )),
//                       pw.Container(
//                           width: 190,
//                           child: pw.Text(Vdata[index]['involved_days'],
//                               style: detailsStyle2))
//                     ],
//                   ),
//                   pw.SizedBox(height: 10, child: pw.Divider()),
//                   pw.Row(
//                     mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
//                     children: [
//                       pw.Container(
//                           width: 170,
//                           child: pw.Row(
//                             mainAxisAlignment:
//                                 pw.MainAxisAlignment.spaceBetween,
//                             children: [
//                               pw.Container(
//                                 width: 160,
//                                 child: pw.Text(
//                                     "Comfortable in practicing in austere condition?",
//                                     style: fieldsStyle2),
//                               ),
//                               pw.Text(
//                                 ":",
//                                 style: fieldsStyle2,
//                               )
//                             ],
//                           )),
//                       pw.Container(
//                           width: 190,
//                           child: pw.Text(Vdata[index]['austere_condition'],
//                               style: detailsStyle2))
//                     ],
//                   ),
//                   pw.SizedBox(height: 10, child: pw.Divider()),
//                   pw.Row(
//                     mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
//                     children: [
//                       pw.Container(
//                           width: 170,
//                           child: pw.Row(
//                             mainAxisAlignment:
//                                 pw.MainAxisAlignment.spaceBetween,
//                             children: [
//                               pw.Container(
//                                 width: 160,
//                                 child: pw.Text(
//                                     "How long can you be deployed during any calamity?",
//                                     style: fieldsStyle2),
//                               ),
//                               pw.Text(
//                                 ":",
//                                 style: fieldsStyle2,
//                               )
//                             ],
//                           )),
//                       pw.Container(
//                           width: 190,
//                           child: pw.Text(Vdata[index]['calamity_days'],
//                               style: detailsStyle2))
//                     ],
//                   ),
//                   pw.SizedBox(height: 10, child: pw.Divider()),
//                   pw.Row(
//                     mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
//                     children: [
//                       pw.Container(
//                           width: 170,
//                           child: pw.Row(
//                             mainAxisAlignment:
//                                 pw.MainAxisAlignment.spaceBetween,
//                             children: [
//                               pw.Container(
//                                 width: 160,
//                                 child: pw.Text(
//                                     "How much notice do you get before deployment?",
//                                     style: fieldsStyle2),
//                               ),
//                               pw.Text(
//                                 ":",
//                                 style: fieldsStyle2,
//                               )
//                             ],
//                           )),
//                       pw.Container(
//                           width: 190,
//                           child: pw.Text(Vdata[index]['notice_period'],
//                               style: detailsStyle2))
//                     ],
//                   ),
//                   pw.SizedBox(height: 10, child: pw.Divider()),
//                   pw.Row(
//                     mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
//                     children: [
//                       pw.Container(
//                           width: 170,
//                           child: pw.Row(
//                             mainAxisAlignment:
//                                 pw.MainAxisAlignment.spaceBetween,
//                             children: [
//                               pw.Container(
//                                 width: 160,
//                                 child: pw.Text(
//                                     "If a disaster occurred today, how soon can you pack and leave?",
//                                     style: fieldsStyle2),
//                               ),
//                               pw.Text(
//                                 ":",
//                                 style: fieldsStyle2,
//                               )
//                             ],
//                           )),
//                       pw.Container(
//                           width: 190,
//                           child: pw.Text(Vdata[index]['emergency_period'],
//                               style: detailsStyle2))
//                     ],
//                   ),
//                   pw.SizedBox(
//                     height: 100,
//                   ),
//                   pw.SizedBox(
//                       height: 20,
//                       child: pw.Divider(
//                         color: PdfColor.fromInt(0xff8500b7),
//                         thickness: 2,
//                       )),
//                   pw.Text(
//                     'Documents',
//                     style: pw.TextStyle(
//                         color: PdfColor.fromInt(0xff8500b7), fontSize: 19),
//                   ),
//                   pw.SizedBox(
//                       height: 20,
//                       child: pw.Divider(
//                         color: PdfColor.fromInt(0xff8500b7),
//                         thickness: 2,
//                       )),
//                   pw.Text(
//                     'Aadhar Card',
//                     style: pw.TextStyle(fontSize: 15),
//                   ),
//                   pw.Image(adhar, width: 300, height: 170, fit: pw.BoxFit.fill),
//                   pw.SizedBox(height: 10),
//                   pw.Text(
//                     'PAN Card',
//                     style: pw.TextStyle(fontSize: 15),
//                   ),
//                   pw.Image(Pan, width: 300, height: 170, fit: pw.BoxFit.fill),
//                   pw.SizedBox(height: 10),
//                   pw.Text(
//                     'Signature',
//                     style: pw.TextStyle(fontSize: 15),
//                   ),
//                   pw.Image(Signature,
//                       width: 300, height: 170, fit: pw.BoxFit.fill),
//                   pw.SizedBox(height: 10),
//                   pw.Text(
//                     'Character Certificate',
//                     style: pw.TextStyle(fontSize: 15),
//                   ),
//                   pw.Image(character,
//                       width: 550, height: 800, fit: pw.BoxFit.fill)
//                 ],
//               ),
//             )
//           ]; // Center
//         }));
//     Response response;
//     final pth = await getExternalStorageDirectory();
//     print('Downloads directory ------${pth?.path}');
//
//     var dio = Dio();
//
//     print(Vdata[index]['qualification_doc']);
//
//     response = await dio.download(Vdata[index]['qualification_doc'],
//         "/storage/emulated/0/Download/${Vdata[index]['sbf_ID']}_qDocs.pdf");
//
//     final file =
//         File("/storage/emulated/0/Download/${Vdata[index]['sbf_ID']}.pdf");
//     print(file.path);
//     await file.writeAsBytes(await pdf.save());
//     pdf.document;
//
//     MergeMultiplePDFResponse rr = await PdfMerger.mergeMultiplePDF(
//         paths: [
//           "/storage/emulated/0/Download/${Vdata[index]['sbf_ID']}.pdf",
//           "/storage/emulated/0/Download/${Vdata[index]['sbf_ID']}_qDocs.pdf"
//         ],
//         outputDirPath:
//             "/storage/emulated/0/Download/${Vdata[index]['sbf_ID']}_application.pdf");
//
//     print(rr.response);
//
//     // if(rr.status==201){
//     //   print('file completeerd');
//     //   print(response);
//     //
//     // }
//     // else{
//     //   print(response);
//     // }
//
//     CustomWidget().hidProgress(context: context);
//     AwesomeDialog(
//       context: context,
//       dialogType: DialogType.SUCCES,
//       animType: AnimType.rightSlide,
//       title: 'Downloaded',
//       desc: 'Application Download Successfully',
//       btnOkText: 'Open',
//       btnCancelText: 'Close',
//       btnCancelOnPress: () {},
//       btnOkOnPress: () {
//         OpenFile.open(
//             "/storage/emulated/0/Download/${Vdata[index]['sbf_ID']}_application.pdf");
//       },
//     ).show();
//   }
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
//                         child: pw.Column(children: [
//                           pw.Container(
//                               height: 70,
//                               padding: pw.EdgeInsets.all(8),
//                               color: PdfColor.fromInt(0xffFF0000),
//                               child: pw.Column(
//                                   mainAxisAlignment:
//                                       pw.MainAxisAlignment.center,
//                                   children: [
//                                     pw.Text('VOLUNTEER',
//                                         style: pw.TextStyle(
//                                             color: PdfColor.fromInt(0xffffffff),
//                                             fontWeight: pw.FontWeight.bold,
//                                             fontSize: 19)),
//                                     pw.Text('DEIDCATED TO DISASTER RELIEF',
//                                         style: pw.TextStyle(
//                                             color: PdfColor.fromInt(0xffffffff),
//                                             fontWeight: pw.FontWeight.bold,
//                                             fontSize: 14))
//                                   ])),
//                           pw.ClipRRect(
//                             horizontalRadius: 43,
//                             verticalRadius: 43,
//                             child: pw.Image(photo,
//                                 width: 110, height: 110, fit: pw.BoxFit.cover),
//                           ),
//                           pw.Text(Vdata[index]['name'],
//                               style: pw.TextStyle(
//                                   color: PdfColor.fromInt(0xff000000),
//                                   fontWeight: pw.FontWeight.bold,
//                                   fontSize: 18)),
//                           pw.SizedBox(
//                               height: 10,
//                               width: 250,
//                               child: pw.Divider(thickness: 2)),
//                           pw.Text(Vdata[index]['sbf_ID'],
//                               style: pw.TextStyle(
//                                   color: PdfColor.fromInt(0xff000000),
//                                   fontWeight: pw.FontWeight.bold,
//                                   fontSize: 16)),
//                           pw.SizedBox(
//                               height: 10,
//                               width: 250,
//                               child: pw.Divider(thickness: 2)),
//                           pw.Container(
//                               width: 220,
//                               child: pw.Row(
//                                   mainAxisAlignment:
//                                       pw.MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     pw.Column(
//                                         crossAxisAlignment:
//                                             pw.CrossAxisAlignment.start,
//                                         children: [
//                                           pw.Text('Blood Group',
//                                               style: pw.TextStyle(
//                                                   color: PdfColor.fromInt(
//                                                       0xff808080),
//                                                   fontSize: 12)),
//                                           pw.Text(Vdata[index]['blood_group'],
//                                               style: pw.TextStyle(
//                                                   color: PdfColor.fromInt(
//                                                       0xffff0000),
//                                                   fontSize: 14)),
//                                         ]),
//                                     pw.SizedBox(width: 10),
//                                     pw.Column(
//                                         crossAxisAlignment:
//                                             pw.CrossAxisAlignment.end,
//                                         children: [
//                                           pw.Text('State',
//                                               style: pw.TextStyle(
//                                                   color: PdfColor.fromInt(
//                                                       0xff808080),
//                                                   fontSize: 12)),
//                                           pw.Text(Vdata[index]['state'],
//                                               style:
//                                                   pw.TextStyle(fontSize: 14)),
//                                         ]),
//                                   ])),
//                           pw.SizedBox(height: 10),
//                           pw.Container(
//                               width: 220,
//                               child: pw.Row(
//                                   mainAxisAlignment:
//                                       pw.MainAxisAlignment.start,
//                                   children: [
//                                     pw.Column(
//                                         crossAxisAlignment:
//                                             pw.CrossAxisAlignment.start,
//                                         children: [
//                                           pw.Text('Emergency Contact',
//                                               style: pw.TextStyle(
//                                                   color: PdfColor.fromInt(
//                                                       0xff808080),
//                                                   fontSize: 12)),
//                                           pw.Text(Vdata[index]['contact_no'],
//                                               style:
//                                                   pw.TextStyle(fontSize: 14)),
//                                         ]),
//                                     pw.SizedBox(width: 10),
//                                     pw.Column(
//                                         crossAxisAlignment:
//                                             pw.CrossAxisAlignment.start,
//                                         children: [
//                                           pw.Text('District',
//                                               style: pw.TextStyle(
//                                                   color: PdfColor.fromInt(
//                                                       0xff808080),
//                                                   fontSize: 12)),
//                                           pw.Text(Vdata[index]['district'],
//                                               style:
//                                                   pw.TextStyle(fontSize: 14)),
//                                         ]),
//
//                                     pw.Container(
//                                         child: pw.Row(
//                                             children: [
//                                               pw.SizedBox(width: 1),
//                                               pw.Column(children: [
//                                                 pw.Image(sign, width: 100, height: 50,fit: pw.BoxFit.cover),
//                                                 pw.Text('Auth Signature',
//                                                     style: pw.TextStyle(fontSize: 10)),
//                                               ])
//                                             ])),
//                                   ])),
//                           pw.Container(
//                               width: 220,
//                               child: pw.Row(
//                                   mainAxisAlignment:
//                                       pw.MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     pw.Text(
//                                         'Valid upto ${Vdata[index]['expire']}',
//                                         style: pw.TextStyle(
//                                             color: PdfColor.fromInt(0xffff0000),
//                                             fontSize: 9)),
//                                     pw.SizedBox(width: 1)
//                                   ])),
//
//                           pw.SizedBox(
//                               width: 250, child: pw.Divider(thickness: 1)),
//                           pw.Container(
//                               width: 170,
//                               height: 50,
//                               child: pw.Row(
//                                 mainAxisAlignment:
//                                     pw.MainAxisAlignment.spaceAround,
//                                 // crossAxisAlignment: pw.CrossAxisAlignment.start,
//
//                                 children: [
//                                   pw.Image(logo, width: 60),
//                                   pw.Image(vision,
//                                       width: 80, fit: pw.BoxFit.contain)
//                                 ],
//                               )),
//                           pw.Text('SOCIETY FOR BRIGHT FUTURE',
//                               style: pw.TextStyle(
//                                   color: PdfColor.fromInt(0xffFFA500),
//                                   fontSize: 14,
//                                   fontWeight: pw.FontWeight.bold)),
//                           pw.Text(
//                               'E-89, 1st floor, AFE, Jamia Nagar New Delhi, 110025 \n       info@sbfindia.com , www.sbfindia.org',
//                               style: pw.TextStyle(
//                                   fontSize: 10, fontWeight: pw.FontWeight.bold))
//                         ]))))
//           ]; // Center
//         }));
//     final file =
//         File("/storage/emulated/0/Download/${Vdata[index]['sbf_ID']}_id.pdf");
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
//   Widget Deatils(int index) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           userType == '4' ||
//                   userType == '3' ||
//                   userType == '2' ||
//                   userType == '1'
//               ? Row(
//                   children: [
//                     userType == '1' || userType == '2' || userType == '3' || userType == '4'
//                         ? ElevatedButton(
//                             onPressed: () {
//                               Vdata[index]['local_level_approved'] == "1"
//                                   ? ScaffoldMessenger.of(context).showSnackBar(
//                                       SnackBar(
//                                           content: Text("Already Approved")))
//                                   : LocalLevel(Vdata[index]['sbf_ID']);
//                             },
//                             style: ButtonStyle(
//                                 backgroundColor:
//                                     MaterialStateProperty.all(Colors.cyan)),
//                             child: Vdata[index]['local_level_approved'] == "1"
//                                 ? Padding(
//                                     padding: const EdgeInsets.all(2.0),
//                                     child: Column(
//                                       children: const [
//                                         Icon(Icons.done),
//                                         Text('Local Level')
//                                       ],
//                                     ),
//                                   )
//                                 : Text('Local Level'),
//                           )
//                         : Container(),
//                     SizedBox(width: 6),
//                     userType == '2' || userType == '3' || userType == '4'
//                         ? ElevatedButton(
//                             onPressed: () {
//                               Userstate != Vdata[index]['state'] && userType!='4' ?
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                   SnackBar(
//                                       content:
//                                       const Text("You cannot give approval of this state"))) :
//
//
//
//                               Vdata[index]['state_level_approved'] == "1"
//                                   ? ScaffoldMessenger.of(context).showSnackBar(
//                                       SnackBar(
//                                           content:
//                                               const Text("Already Approved")))
//                                   : StateLevel(Vdata[index]['sbf_ID']);
//                             },
//                             style: ButtonStyle(
//                                 backgroundColor: MaterialStateProperty.all(
//                                     Colors.deepPurple)),
//                             child: Vdata[index]['state_level_approved'] == "1"
//                                 ? Padding(
//                                     padding: const EdgeInsets.all(2.0),
//                                     child: Column(
//                                       children: [
//                                         Icon(Icons.done),
//                                         Text('State Level')
//                                       ],
//                                     ),
//                                   )
//                                 : Text('State Level'),
//                           )
//                         : Container(),
//                     SizedBox(width: 6),
//                     userType == '3' || userType == '4'
//                         ? ElevatedButton(
//                             onPressed: () {
//                               Vdata[index]['central_level_approved'] == "1"
//                                   ? ScaffoldMessenger.of(context).showSnackBar(
//                                       SnackBar(
//                                           content: Text("Already Approved")))
//                                   : CentralLevel(Vdata[index]['sbf_ID']);
//                             },
//                             child: Vdata[index]['central_level_approved'] == "1"
//                                 ? Padding(
//                                     padding: const EdgeInsets.all(2.0),
//                                     child: Column(
//                                       children: [
//                                         Icon(Icons.done),
//                                         Text('National Level')
//                                       ],
//                                     ),
//                                   )
//                                 : Text('National Level'),
//                             style: ButtonStyle(
//                                 backgroundColor:
//                                     MaterialStateProperty.all(Colors.black54)),
//                           )
//                         : Container(),
//                   ],
//                 )
//               : Container(),
//           GestureDetector(
//             onTap: () {
//               Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (BuildContext context) => ViewApplication(
//                             id: Vdata[index]['sbf_ID'],
//                           )));
//             },
//             child: Card(
//               elevation: 4.0,
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Text('view Application'),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
//
//   Future<https.Response?> getVolunteersbySearch(Field) async {
//     try {
//       CustomWidget().showProgress(context: context);
//       Map jsondata = {"filter": Field};
//       print("----jsondata----$jsondata");
//       String url = Webservices.filterVolunteer;
//       print(url);
//       var response = await https.post(Uri.parse(url),
//           body: jsonEncode(jsondata),
//           encoding: Encoding.getByName("utf-8"),
//           headers: {
//             'Content-Type': 'application/json',
//             'Accept': 'application/json',
//             'Authorization':
//                 'Bearer ${await SessionManager().getString(Constant.access_token)}'
//           });
//
//       var data = jsonDecode(response.body);
//
//       if (response.statusCode == 201) {
//         //  CustomWidget().hidProgress(context: context);
//         print(data);
//
//         setState(() {
//           Vdata = data['msg'];
//           ReportPath = data['path'];
//         });
//         CustomWidget().hidProgress(context: context);
//       } else {
//         CustomWidget().hidProgress(context: context);
//
//         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//             content: Text(
//           'Some error occured',
//           style: TextStyle(color: Colors.red),
//         )));
//       }
//     } on Exception catch (e) {
//       print(e.toString());
//       // _hideProgress();
//     }
//   }
//
//   Future<https.Response?> getVolunteers() async {
//     try {
//       //  CustomWidget().showProgress(context: context);
//       String url = Webservices.filterVolunteer;
//       print(url);
//       userType = await SessionManager().getString(Constant.userType) ;
//       Userstate = await SessionManager().getString(Constant.state);
//       Map jsonData = userType=='2' ? {"filter": "where state = '${Userstate}' and session = '${session}';"} : {"filter": "where session = '${session}';"};
//
//       print(jsonData);
//       var response = await https.post(Uri.parse(url),
//           body: jsonEncode(jsonData),
//           encoding: Encoding.getByName("utf-8"),
//           headers: {
//             'Content-Type': 'application/json',
//             'Accept': 'application/json',
//             'Authorization':
//                 'Bearer ${await SessionManager().getString(Constant.access_token)}'
//           });
//
//       var data = jsonDecode(response.body);
//       //print(response.body);
//
//       if (response.statusCode == 201) {
//         //  CustomWidget().hidProgress(context: context);
//       //  print(data);
//
//         setState(() {
//           Vdata = data['msg'];
//           ReportPath = data['path'];
//         });
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
//   }
//
//   Future<https.Response?> LocalLevel(String ID) async {
//     try {
//       CustomWidget().showProgress(context: context);
//       Map jsondata = {"id": ID};
//       print("----jsondata----$jsondata");
//       String url = Webservices.localLevel;
//       print(url);
//       var response = await https.post(Uri.parse(url),
//           body: jsonEncode(jsondata),
//           encoding: Encoding.getByName("utf-8"),
//           headers: {
//             'Content-Type': 'application/json',
//             'Accept': 'application/json',
//             'Authorization':
//                 'Bearer ${await SessionManager().getString(Constant.access_token)}'
//           });
//       var data = jsonDecode(response.body);
//
//       if (response.statusCode == 201) {
//         CustomWidget().hidProgress(context: context);
//         setState(() {
//           getVolunteers();
//         });
//       } else {}
//     } on Exception catch (e) {
//       print(e.toString());
//       // _hideProgress();
//     }
//   }
//
//   Future<https.Response?> StateLevel(String ID) async {
//     try {
//       CustomWidget().showProgress(context: context);
//       Map jsondata = {"id": ID};
//       print("----jsondata----$jsondata");
//       String url = Webservices.stateLevel;
//       print(url);
//       var response = await https.post(Uri.parse(url),
//           body: jsonEncode(jsondata),
//           encoding: Encoding.getByName("utf-8"),
//           headers: {
//             'Content-Type': 'application/json',
//             'Accept': 'application/json',
//             'Authorization':
//                 'Bearer ${await SessionManager().getString(Constant.access_token)}'
//           });
//       var data = jsonDecode(response.body);
//
//       if (response.statusCode == 201) {
//         CustomWidget().hidProgress(context: context);
//         setState(() {
//           getVolunteers();
//         });
//       } else {}
//     } on Exception catch (e) {
//       print(e.toString());
//       // _hideProgress();
//     }
//   }
//
//   Future<https.Response?> CentralLevel(String ID) async {
//     try {
//       CustomWidget().showProgress(context: context);
//       Map jsondata = {"id": ID};
//       print("----jsondata----$jsondata");
//       String url = Webservices.centralLevel;
//       print(url);
//       var response = await https.post(Uri.parse(url),
//           body: jsonEncode(jsondata),
//           encoding: Encoding.getByName("utf-8"),
//           headers: {
//             'Content-Type': 'application/json',
//             'Accept': 'application/json',
//             'Authorization':
//                 'Bearer ${await SessionManager().getString(Constant.access_token)}'
//           });
//       var data = jsonDecode(response.body);
//
//       if (response.statusCode == 201) {
//         CustomWidget().hidProgress(context: context);
//         setState(() {
//           getVolunteers();
//         });
//       } else {}
//     } on Exception catch (e) {
//       print(e.toString());
//       // _hideProgress();
//     }
//   }
// }
