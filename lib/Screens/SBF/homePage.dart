import 'package:flutter/material.dart';
import 'package:sbf_mobile_app/CustomUI/CustomWidgets.dart';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';


Widget HomePage(Function() onTap, BuildContext context) {
  String homeText =
      "Society for Bright Future (SBF) plays a key role in preventing and mitigating the risk of disasters, preparing to provide effective response during such events and rehabilitation of those impacted, to help them recover and return to their normal lives."
      "In the past, SBF has quickly responded to natural calamities in Bihar, Assam, Andhra Pradesh, Delhi, and Uttar Pradesh by providing first aid supplies, shelter, blankets, water, food, and other basic survival materials.";
  YoutubePlayerController controller = YoutubePlayerController(
    initialVideoId: YoutubePlayer.convertUrlToId(
            "https://youtu.be/8bG76ChSFqQ?si=YfizHgKHWO-pIUs0") ??
        'nUKNj30z-gU',
    flags: const YoutubePlayerFlags(
      autoPlay: false,
      mute: false,
    ),
  );

  return SingleChildScrollView(
    child: Column(
      children: [
        const SizedBox(height: 20),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Image(
            image: AssetImage('assets/images/DSC.JPG'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            homeText,
            style: const TextStyle(color: Colors.black, fontSize: 9),
            textAlign: TextAlign.justify,
          ),
        ),
        YoutubePlayer(
          controller: controller,
          showVideoProgressIndicator: true,
        ),
        const SizedBox(height: 40),
        CustomWidget().basicButtonWiImage(
            text: "Become a Volunteer",
            onTap: onTap,
            image: const AssetImage('assets/images/raise-hand.png')),
        const SizedBox(height: 40),

      ],
    ),
  );
}
