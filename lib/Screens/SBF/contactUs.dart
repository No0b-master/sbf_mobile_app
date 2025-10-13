
import 'package:flutter/material.dart';
import 'package:sbf_mobile_app/CustomUI/CustomWidgets.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:fluttericon/fontelico_icons.dart';
import 'package:fluttericon/linecons_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
Widget ContactUs(){

  return SingleChildScrollView(
    child: Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/SBF_logo.png"),
            fit: BoxFit.cover,
            opacity: 0.2
        ),
      ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children:  [
          const SizedBox(height: 20),


          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Card(
              elevation: 5.0,
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(

                      children:  [

                        Padding(
                          padding: EdgeInsets.only(top:8.0),
                          child: Icon(Icons.call,size: 30,color: Colors.deepOrange,),
                        ),

                        SizedBox(width: 20),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("+91   7290074384",style: TextStyle(fontSize: 12),),
                            Text("+91   7290074380",style: TextStyle(fontSize: 12))
                            ,
                            Text("+011 41500750",style: TextStyle(fontSize: 12))
                          ],
                        )
                      ],
                    ),


                  ],
                ),
              ),
            ),
          ),




          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Card(
              elevation: 5.0,
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(

                      children:  [

                        Padding(
                          padding: EdgeInsets.only(top:8.0),
                          child: Icon(Icons.mail,size: 30,color: Colors.deepOrange,),
                        ),

                        SizedBox(width: 20),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("volunteerssbf@gmail.com",style: TextStyle(fontSize: 16),),
                            Text("info@sbfindia.org",style: TextStyle(fontSize: 16))
                          ],
                        )
                      ],
                    ),


                  ],
                ),
              ),
            ),
          ),

          GestureDetector(
            onTap: ()async{
              if (!await launchUrl(
                Uri.parse("https://www.google.com/maps/place/Society+For+Bright+Future/@28.555101,77.293251,16z/data=!4m5!3m4!1s0x0:0x8ba8230e6dbb3b34!8m2!3d28.5551012!4d77.2932505?hl=en",
                ),

              mode: LaunchMode.externalApplication,
              )) {
              throw 'Could not launch ';
              }
            },
            child:  Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 5.0,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(

                        children:  [

                          const Padding(
                            padding: EdgeInsets.only(top:8.0),
                            child: Icon(Icons.location_on_rounded,size: 30,color: Colors.deepOrange,),
                          ),

                          const SizedBox(width: 20),

                          Container(
                            width: 250,
                            child: const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Society for Bright Future",style: TextStyle(fontSize: 16),),
                                Text("E-89 Hari Kothi lane, Abul Fazal Enclave",style: TextStyle(fontSize: 16)),
                                Text("Jamia Nagar, New Delhi, India",style: TextStyle(fontSize: 16),),

                              ],
                            ),
                          )
                        ],
                      ),


                    ],
                  ),
                ),
              ),
            ),
          ),

          GestureDetector(
            onTap: ()async{
              if (!await launchUrl(
                Uri.parse("https://sbfindia.org/",
                ),

                mode: LaunchMode.externalApplication,
              )) {
                throw 'Could not launch ';
              }
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Card(
                elevation: 5.0,
                child: Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(

                        children:  [

                          Padding(
                            padding: EdgeInsets.only(top:8.0),
                            child: Icon(Icons.web,size: 30,color: Colors.deepOrange,),
                          ),

                          SizedBox(width: 20),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("https://sbfindia.org/",style: TextStyle(fontSize: 16))
                            ],
                          )
                        ],
                      ),


                    ],
                  ),
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 5.0,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: ()async{
                        if (!await launchUrl(
                          Uri.parse("https://www.facebook.com/societyforbrightfuture",
                          ),

                          mode: LaunchMode.externalApplication,
                        )) {
                          throw 'Could not launch ';
                        }
                      },
                      child: const Row(

                        children:  [

                          Padding(
                            padding: EdgeInsets.only(top:8.0),
                            child: Icon(Icons.facebook,size: 30,color: Colors.deepOrange,),
                          ),

                          SizedBox(width: 20),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("/societyforbrightfuture",style: TextStyle(fontSize: 16))
                            ],
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: ()async{
                        if (!await launchUrl(
                          Uri.parse("https://twitter.com/sbfparivar/",
                          ),

                          mode: LaunchMode.externalApplication,
                        )) {
                          throw 'Could not launch ';
                        }

                      },
                      child: const Row(

                        children:  [

                          Padding(
                            padding: EdgeInsets.only(top:8.0),
                            child: Icon(Typicons.twitter,size: 30,color: Colors.deepOrange,),
                          ),

                          SizedBox(width: 20),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("/sbfparivar",style: TextStyle(fontSize: 16))
                            ],
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: ()async{
                        if (!await launchUrl(
                          Uri.parse("https://www.instagram.com/sbfparivar/",
                          ),

                          mode: LaunchMode.externalApplication,
                        )) {
                          throw 'Could not launch ';
                        }

                      },
                      child: const Row(

                        children:  [

                          Padding(
                            padding: EdgeInsets.only(top:8.0),
                            child: Icon(FontAwesome.instagram,size: 30,color: Colors.deepOrange,),
                          ),

                          SizedBox(width: 20),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("/sbfparivar",style: TextStyle(fontSize: 16))
                            ],
                          )
                        ],
                      ),
                    ),

                    GestureDetector(
                      onTap: ()async{
                        if (!await launchUrl(
                          Uri.parse("https://www.youtube.com/c/SocietyforBrightFuture",
                          ),

                          mode: LaunchMode.externalApplication,
                        )) {
                          throw 'Could not launch ';
                        }

                      },
                      child: const Row(

                        children:  [

                          Padding(
                            padding: EdgeInsets.only(top:8.0),
                            child: Icon(FontAwesome.youtube,size: 30,color: Colors.deepOrange,),
                          ),

                          SizedBox(width: 20),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("/SocietyforBrightFuture",style: TextStyle(fontSize: 16))
                            ],
                          )
                        ],
                      ),
                    ),


                  ],
                ),
              ),
            ),
          ),




        ],
      ),
    ),
  );
}