import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:sbf_mobile_app/CustomUI/Appbar.dart';
import 'package:sbf_mobile_app/Screens/admin/viewApplication.dart';
import '../../Constant.dart';
import '../../CustomUI/circular_network_image.dart';
import '../../CustomUI/snackBar.dart';
import '../../Util/path.dart';
import '../../preferences/preferences.dart';
import '../../webservices.dart';

class AdminPanel extends StatefulWidget {
  const AdminPanel({super.key});

  @override
  State<AdminPanel> createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  late Future volunteers;
  final TextEditingController _search = TextEditingController();
  TextStyle key = const TextStyle(color: Color(0xff1e1e1e),fontSize: 11 ,fontWeight: FontWeight.bold);
  TextStyle value = const TextStyle(color: Colors.black,fontSize: 11);
  @override
  void initState()  {
    super.initState();
    volunteers = fetchData(context: context, page: "0" , limit: "10",search: _search.text , session: initialSession);
  }

  String initialSession = '2024-25';
  int totalPages = 1 ;
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: Column(
        children: [
          appBar(context),
          Container(color: Colors.green,width: double.infinity,height: 50,
            child:const Center(child:  Text("Admin Panel",style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),)),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextFormField(

              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green, width: 2)),
                  label: Text("Search"),
                  suffixIcon: Icon(Icons.search),
                  hintStyle: TextStyle(color: Color(0xff919191)),
                  hintText: 'Enter Name, SBF id, Email, State or Phone No.'),
              controller: _search,
              onFieldSubmitted: (val){
                setState(() {
                  volunteers = fetchData(context: context, page: "1" , limit: "10",search: val , session: initialSession);
                });
              },
            ),
          ),
          DropdownButton<String>(
            hint: const Text('Sessions'),
            value: initialSession,
            items: <String>["N/A",'2022-23', '2023-24', '2024-25', '2025-26','2026-27','2027-28'].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (val) {
              setState(() {
                initialSession = val!;
                volunteers = fetchData(context: context, page: "1" , limit: "10",search: _search.text , session: initialSession);
              });

            },
          ),
          FutureBuilder(future: volunteers, builder: (BuildContext context,AsyncSnapshot snapshot){
            if(snapshot.connectionState==ConnectionState.done){
              if(snapshot.hasData){
                final data = snapshot.data;
                return Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: data?.length,
                      scrollDirection: Axis.vertical,

                      itemBuilder: (BuildContext context, int index){
                        return
                          Container(
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [BoxShadow(offset: Offset(1, 1),
                                      blurRadius: 10,
                                      blurStyle: BlurStyle.normal,
                                      spreadRadius: 2,
                                      color: Color(0xffefefef)
                                  )]
                              ),
                              margin: const EdgeInsets.only(left: 12,right: 12,top: 8),
                              padding: const EdgeInsets.all(8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [

                                  Row(
                                    children: [
                                      Container(
                                        color: data[index]["isActive"]==0 ? Colors.red : Colors.green,
                                        width: 4,
                                        height: 70,
                                      ),
                                      const SizedBox(width: 10),
                                      CircularNetworkImage(
                                        imageUrl: getPath(path: data[index]["SBF_id"]+"/photo",
                                        ),


                                        fallbackImage: 'assets/images/user.png',
                                        radius: 30, token: SessionManager.getString(Constant.access_token),),
                                      const SizedBox(width: 15),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text('Name ',style: key),
                                              Text('Phone ',style: key),
                                              Text('District ',style: key),
                                              Text('State ',style: key),
                                            ],
                                          ),
                                          const SizedBox(width: 10),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(':',style: key),
                                              Text(':',style: key),
                                              Text(':',style: key),
                                              Text(': ',style: key),
                                            ],
                                          ),
                                          const SizedBox(width: 10),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(width:130,child: Text(data[index]['name'],style: value,overflow: TextOverflow.fade,softWrap: false,maxLines: 2,)),
                                              SizedBox(width:130,child: Text(data[index]['contact_no'],style: value,overflow: TextOverflow.fade,softWrap: false,maxLines: 2,)),
                                              SizedBox(width:130,child: Text(data[index]['district'] ?? "",style: value,overflow: TextOverflow.fade,softWrap: false,maxLines: 2,)),
                                              SizedBox(width:130,child: Text(data[index]['state'],style: value,overflow: TextOverflow.fade,softWrap: false,maxLines: 2,)),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  GestureDetector(
                                    onTap: (){
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) =>  VolunteerApplication(id: data[index]["SBF_id"])));
                                    },
                                    child: const Padding(
                                      padding: EdgeInsets.only(right: 8.0),
                                      child: CircleAvatar
                                        (

                                          backgroundColor: Color(0xfffdeaf3),radius: 15,

                                          child: Icon(Icons.arrow_forward_ios_outlined,size: 13,)),
                                    ),
                                  ),

                                ],
                              ));


                      }),
                );
              }

              else if (snapshot.hasError) {
                print(snapshot.error);

                return Center(child: Text("Some error occurred , ${snapshot.error}"));
              }

            }
            return const CircularProgressIndicator();


          }),
      NumberPaginator(
        numberPages: totalPages,
        onPageChange: (int index) {
          setState(() {
            volunteers = fetchData(context: context, page: (index+1).toString() , limit: "10",search: _search.text , session: initialSession);
          });
          // handle page change...
        },
      )



          // Stack(
          //   alignment: Alignment.topCenter,
          //   children: [
          //     const Padding(
          //       padding: EdgeInsets.all(8.0),
          //       child: Column(
          //         children: [
          //           Icon(Icons.do_not_disturb,size: 50,color: Colors.red),
          //           Text("No Data Found !")
          //         ],
          //       ),
          //     ),
          //   ],
          // )



        ],
      ),

    ));
  }

  Future<List<dynamic>?> fetchData(

      {required BuildContext context, required String page, required String limit,required String  session,required String  search}) async {
    print("Fetching Data");
    final dio = Dio();
    print('${Webservices.getVolunteerList}?page=$page&limit=$limit&year=$session&query=$search');
    Response response = await dio.get('${Webservices.getVolunteerList}?page=$page&limit=$limit&year=$session&query=$search',
        options: Options(headers: {
          "Authorization": "Bearer ${SessionManager.getString(Constant.access_token)}"
        })

    );
    if(response.statusCode==200 || response.statusCode==201 ){
      print(response.data);

      setState(() {
        totalPages = response.data["totalPages"]==0 ? 1 :  response.data["totalPages"];

      });
      return response.data["data"].toList();
    }
    else {
      print(response.data);
      if(context.mounted) showSnackBar(context: context, text: response.data["message"]);
      return null ;
    }
    // Replace this URL with your API endpoint
  }

}
