import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:sbf_mobile_app/CustomUI/CustomWidgets.dart';
import 'package:sbf_mobile_app/Util/path.dart';

Widget ProfileDetails(dynamic data , int step,BuildContext context,  Function() onTap) {
  TextStyle detailsStyle = const TextStyle(fontSize: 13);
  int activeStep = step ;
  return data.isEmpty ? const Center(
    child: Center(child: Text("You haven't applied for volunteer application")),
  ):Column(

    children: [
      Container(color: Colors.green,width: MediaQuery.of(context).size.width,height: 50,
        child:const Center(child:  Text("Volunteer Application",style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),)),
      ),
      Padding(
        padding: const EdgeInsets.all(18.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text('Name : ${data["name"].toString()}', style: detailsStyle),
                Text('Date of Birth : ${data["dob"].toString()}', style: detailsStyle),
                Text('Blood group : ${data["blood_group"].toString()}',
                    style: detailsStyle),
                Text('State : ${data["state"].toString()}', style: detailsStyle),
                Text('District : ${data["district"].toString()}', style: detailsStyle),
                Text('Pin code : ${data["pin_code"].toString()}', style: detailsStyle),
                Text('Contact Number : ${data["contact_no"].toString()}',
                    style: detailsStyle),
                Text('Whatsapp Number : ${data["whatsapp_no"].toString()}',
                    style: detailsStyle),
                Text('Email : ${data["email"].toString()}', style: detailsStyle),
              ],
            ),
            CircularNetworkImage(
                imageUrl: data["photo"].toString(),
                fallbackImage: 'assets/images/user.png',

                radius: 70),



          ],
        ),
      ),
      const SizedBox(height: 10),
      const Divider(thickness: 1),
      EasyStepper(

        activeStep: activeStep,
        activeStepTextColor: Colors.black87,
        finishedStepTextColor: Colors.black87,
        internalPadding: 30,
        fitWidth: true,

        finishedStepBackgroundColor: Colors.green,
        showLoadingAnimation: false,
        stepRadius: 15,
        showStepBorder: false,
        steps: [
          EasyStep(
            customStep: CircleAvatar(
              radius: 8,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 7,
                backgroundColor:
                activeStep >= 0 ? Colors.orange : Colors.white,
              ),
            ),
            title: 'Local Level    ',
          ),
          EasyStep(
            customStep: CircleAvatar(
              radius: 8,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 7,
                backgroundColor:
                activeStep >= 1 ? Colors.orange : Colors.white,
              ),
            ),
            title: 'State Level',
            topTitle: false,
          ),
          EasyStep(
            customStep: CircleAvatar(
              radius: 8,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 7,
                backgroundColor:
                activeStep >= 2 ? Colors.orange : Colors.white,
              ),
            ),
            title: 'National Level',
          ),

        ],

      ),
      const SizedBox(height: 10),
      activeStep > 2 ? CustomWidget().basicButton(text: "Download Id Card", onTap: onTap, context: context) : Container()


    ],
  );
}

class CircularNetworkImage extends StatelessWidget {
  final String imageUrl;
  final String fallbackImage;
  final double radius;

  const CircularNetworkImage({
    super.key,
    required this.imageUrl,
    required this.fallbackImage,
    required this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: Colors.grey[200],
      child: ClipOval(
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
          width: radius * 2,
          height: radius * 2,
          errorBuilder:
              (BuildContext context, Object error, StackTrace? stackTrace) {
            return Image.asset(
              fallbackImage,
              fit: BoxFit.cover,
              width: radius * 2,
              height: radius * 2,
            );
          },
        ),
      ),
    );
  }
}
