import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:url_launcher/url_launcher.dart';

Widget instruction(){
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
      GestureDetector(
        onTap: ()async{
          String url = 'https://drive.google.com/file/d/1GKoA83h8ka61KNCo_sTgMG4TAKdx2RZx/view?usp=sharing' ;
          if(await canLaunchUrl(Uri.parse(url))){
            await launchUrl(Uri.parse(url) , mode: LaunchMode.inAppBrowserView );
          }else {
            throw 'Could not launch $url';
          }



        },
        child: Container(
          width: 200,
          child: const Card(
            elevation: 4,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Read guidelines first'),
                  Icon(FontAwesome.file_pdf , color: Colors.red,)
                ],
              ),
            ),
          ),
        ),
      ),
      const SizedBox(height: 20),


      const Text(
          'Volunteers are the backbone of Society for Bright Future. We feel proud to work with people who go above and beyond their duties to help us continue our charitable and welfare work with their time and skills.'),
      const Text(
          'Anyone who is a citizen of the Indian Union can become a volunteer of Volunteer Core provided that he:\n\n'
              '1. Is residing in India and possessing a valid identity card (issued by the government)\n'
              '2. Should be no older than 60 years and no younger than 18 years of age.\n'
              '3. Preferably, should have passed the 10th class.\n'
              '4. Has no criminal record.\n'
              '5. Read volunteer guideline carefully its mandatory to become a volunteer.'),
      const Text(
          'Note: Before Fill this form Please Ready with these Documents in your Mobile or Desktop\n\n'
              '1. Passport size Photo\n'
              '2. Scan Signature\n'
              '3. 10th or Above Marksheet\n'
              '4. Aadhar Card\n'
              '5. Pan Card\n'
              '6. Character Certificate ( You can attest this form by  Gazetted Officers, Police, Gram Pardhan, Ward Member, M.L.A)'),
      const SizedBox(height: 10),
      GestureDetector(
        onTap: ()async{
          String url = 'https://drive.google.com/file/d/18nWisLIr06BisOqJt88dA1KOFBlPD6Pt/view?usp=sharing' ;
          if(await canLaunchUrl(Uri.parse(url))){
            await launchUrl(Uri.parse(url),mode: LaunchMode.externalApplication );
          }else {
            throw 'Could not launch $url';
          }



        },


        child: Container(
          width: 250,
          child: const Card(
            elevation: 4,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Character Certificate Format'),
                  Icon(FontAwesome.file_pdf , color: Colors.red,)
                ],
              ),
            ),
          ),
        ),
      ),
    ]),
  );
}