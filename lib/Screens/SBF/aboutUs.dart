
import 'package:flutter/material.dart';
import 'package:sbf_mobile_app/CustomUI/CustomWidgets.dart';

Widget AboutUs(){

  // String aboutUs = "About Us
  // OUR STORY
  // 
  // •	Society for Bright Future is a non-profit NGO that was registered in 2008.
  // •	
  // •	It is a specialized and dedicated National organization that works in the field of Emergency Relief and Rehabilitation.
  // •	
  // •	In the no disaster days it organizes various training programs for the volunteers and creates general awareness in public in order to help them prepare for disasters.
  // •	
  // •	The SBF Rehabilitation program includes the handicapped assistance program, reconstruction of the affected population and employment assistance, etc. Society for Bright Future has been striving to develop an ability to deploy an emergency at a moment’s notice. 
  // •	
  // •	In the past, SBF has quickly responded to natural calamities in Bihar, Assam, Andhra Pradesh, Delhi, and Uttar Pradesh by providing First Aid supplies, shelter, blankets, water, food, and other basic survival materials.
  // •	
  // •	SBF takes projects regarding any disaster or rehab work. The Emergency and Relief program of SBF provides food packages, drinking water, clothes, shelter, and medical care during emergencies or in case of any disaster.

  // OUR MISSION
  // •	To build up an effective and responsive mechanism for disaster management both at local and national level.
  // •	
  // •	To evolve suitable plans and strategies for rehabilitation and reconstruction of dwellings during and after the disaster in the most effective and coordinated
  // •	
  // •	A manner with an aim at building up capabilities of disaster survivors empowering them to take charge of their lives.
  // •	
  // •	To conceive, plan evolve and develop a complete mechanism of disaster preparedness by evaluating the capabilities of the local population for coping and mitigating the disaster damages.
  // •	
  // •	To develop and find appropriate and sustainable solutions to face future disaster by evaluating and assessing risk, vulnerability, and capacity and finding out ways and means of strengthening disaster preparedness and in this way evolving and building up an effective disaster response mechanisms.
  // •	
  // •	To raise community awareness and educate the general public regarding the hazards and vulnerability of future disasters particularly in high-risk areas by imparting basic knowledge of coping strategies that can minimize loss of life and property.
  // "
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
        children: [
          const SizedBox(height: 20),


          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Our Story",style: TextStyle(
                color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold
            )
              ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RichText(
              textAlign: TextAlign.left,


                text:
               const TextSpan(
                 style: TextStyle(color: Colors.black),

                 text:  "Society for Bright Future is a non-profit NGO that was registered in 2008.\n\n"

                     "It is a specialized and dedicated National organization that works in the field of Emergency Relief and Rehabilitation.\n\n"
                 "In the no disaster days it organizes various training programs for the volunteers and creates general awareness in public in order to help them prepare for disasters.\n\n"
                 "The SBF Rehabilitation program includes the handicapped assistance program, reconstruction of the affected population and employment assistance, etc. Society for Bright Future has been striving to develop an ability to deploy an emergency at a moment’s notice. \n\n"
                 "In the past, SBF has quickly responded to natural calamities in Bihar, Assam, Andhra Pradesh, Delhi, and Uttar Pradesh by providing First Aid supplies, shelter, blankets, water, food, and other basic survival materials.\n\n"
                 "SBF takes projects regarding any disaster or rehab work. The Emergency and Relief program of SBF provides food packages, drinking water, clothes, shelter, and medical care during emergencies or in case of any disaster."
               )
            ),
          ),

          const SizedBox(height: 20),


          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Our Mission",style: TextStyle(
                color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold
            )
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RichText(
                textAlign: TextAlign.left,


                text:
                const TextSpan(
                    style: TextStyle(color: Colors.black),

                    text: "To build up an effective and responsive mechanism for disaster management both at local and national level.\n\n"
                    "To evolve suitable plans and strategies for rehabilitation and reconstruction of dwellings during and after the disaster in the most effective and coordinated\n\n"
                "A manner with an aim at building up capabilities of disaster survivors empowering them to take charge of their lives.\n\n"
               "To conceive, plan evolve and develop a complete mechanism of disaster preparedness by evaluating the capabilities of the local population for coping and mitigating the disaster damages.\n\n"
                "	To develop and find appropriate and sustainable solutions to face future disaster by evaluating and assessing risk, vulnerability, and capacity and finding out ways and means of strengthening disaster preparedness and in this way evolving and building up an effective disaster response mechanisms.\n\n"
                "To raise community awareness and educate the general public regarding the hazards and vulnerability of future disasters particularly in high-risk areas by imparting basic knowledge of coping strategies that can minimize loss of life and property.\n\n"
                )
            ),
          )




        ],
      ),
    ),
  );
}