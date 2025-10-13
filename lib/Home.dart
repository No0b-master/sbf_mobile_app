import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sbf_mobile_app/CustomUI/CustomWidgets.dart';
import 'package:sbf_mobile_app/Screens/SBF/aboutUs.dart';
import 'package:sbf_mobile_app/Screens/SBF/contactUs.dart';
import 'package:sbf_mobile_app/Screens/SBF/homePage.dart';
import 'package:sbf_mobile_app/Screens/SBF/ourActivities.dart';
import 'package:sbf_mobile_app/Screens/SBF/volunteerForm/volunteer_basic_details.dart';
import 'package:sbf_mobile_app/Screens/auth/auth_screen.dart';
import 'package:sbf_mobile_app/Screens/volunteer.dart';
import 'package:sbf_mobile_app/preferences/preferences.dart';
import 'package:sbf_mobile_app/webservices.dart';
import 'Constant.dart';
import 'CustomUI/Appbar.dart';
import 'Screens/login.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

@override
class _HomeState extends State<Home> with TickerProviderStateMixin {
  late TabController _tabController;
  final Dio dio = Dio();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  TextStyle tabStyle = const TextStyle(color: Colors.black, fontSize: 10);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  appBar(context),
                  TabBar(
                    unselectedLabelColor: Colors.green,
                    labelColor: Colors.black,
                    labelStyle:
                        const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                    unselectedLabelStyle: const TextStyle(fontSize: 9),
                    padding: EdgeInsets.zero,
                    controller: _tabController,
                    tabs: const <Widget>[
                      Tab(
                        text: "Home",
                        iconMargin: EdgeInsets.zero,

                        // icon: Icon(Icons.cloud_outlined,color: Colors.red),
                      ),
                      Tab(
                        text: "About us",
                        //icon: Icon(Icons.beach_access_sharp),
                      ),
                      Tab(
                        text: "Our Activities",
                        //  icon: Icon(Icons.brightness_5_sharp),
                      ),
                      Tab(
                        text: "Contact Us",
                        // icon: Icon(Icons.brightness_5_sharp),
                      ),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(controller: _tabController, children: [
                      HomePage(() {
                        SessionManager.getString(Constant.access_token) == ''
                            ? Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) => const AuthScreen()))
                            : Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        const VolunteerBasicDetails()));
                      }, context),
                      AboutUs(),
                      Activity(),
                      ContactUs()
                    ]),
                  )
      ],
    )));
  }

  Future<Map<String, dynamic>?> fetchData() async {
    try {
      Response response = await dio.get(Webservices.getVolunteer,
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
}
