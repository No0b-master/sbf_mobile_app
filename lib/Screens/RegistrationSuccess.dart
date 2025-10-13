// import 'package:flutter/material.dart';
// import 'package:sbf_mobile_app/CustomUI/CustomWidgets.dart';
// import 'package:sidebarx/sidebarx.dart';
//
// import '../Constant.dart';
// import '../CustomUI/Appbar.dart';
// import '../Home.dart';
// import '../preferences/preferences.dart';
//
// class Success extends StatefulWidget {
//   const Success({Key? key}) : super(key: key);
//
//   @override
//
//   State<Success> createState() => _SuccessState();
//
// }
// final _controller = SidebarXController(selectedIndex: 0, extended: true);
//
// final _key = GlobalKey<ScaffoldState>();
//
//
//
// class _SuccessState extends State<Success> {
//
//   String SBFID = '';
//   @override
//   void initState() {
//
//     getDetails();
//
//     // TODO: implement initState
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: ()async{
//         Route route = MaterialPageRoute(builder: (context) => Home(type : 'user'));
//         Navigator.pushReplacement(context, route);
//         return  true;
//       },
//       child: SafeArea(child:
//       Scaffold(
//         drawer: ExampleSidebarX(controller: _controller,www:_key),
//
//         key: _key,
//         body: Column(
//
//           children: [
//             Appbar(context,_key),
//             Container(
//               width: double.infinity,
//               height: 80,
//               color: Color(0xff016507),
//               child: Center(
//                 child: Text('Reigstration Successfull',style: TextStyle(
//                   color: Colors.white,fontWeight: FontWeight.w900,fontSize: 25
//                 ),),
//               ),
//             ),
//             SizedBox(height: 200),
//
//             Align(
//               alignment: Alignment.center,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text('Congratulations...',style: TextStyle(
//                       color: Colors.black,fontWeight: FontWeight.w700,fontSize: 20
//                   ),),
//                   Text('You are now registered with us',style: TextStyle(
//                       color: Colors.black,fontWeight: FontWeight.w700,fontSize: 20
//                   ),),
//                   Text('Wait for thr admin approval',style: TextStyle(
//                       color: Colors.black,fontWeight: FontWeight.w700,fontSize: 20
//                   ),)
//                 ],
//               ),
//             ),
//             SizedBox(height: 30),
//
//             Text('Your registration no is : ${SBFID}',style: TextStyle(
//                 color: Colors.green,fontWeight: FontWeight.w500,fontSize: 15
//             ),),
//
//
//           ],
//         ),
//       )),
//     );
//   }
//
//   void getDetails()async{
//     SBFID = await SessionManager().getString(Constant.SBFID);
//     setState(() {
//
//     });
//
//   }
// }
