import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sbf_mobile_app/CustomUI/CustomWidgets.dart';

Widget Activity() {
  const headerStyle = TextStyle(
    color: Colors.deepPurple,
    fontSize: 15,
    fontWeight: FontWeight.bold,
  );

  const sectionTitleBlue = TextStyle(
    color: Colors.blue,
    fontSize: 15,
    fontWeight: FontWeight.bold,
  );

  const sectionTitleOrange = TextStyle(
    color: Colors.orange,
    fontSize: 15,
    fontWeight: FontWeight.bold,
  );

  const sectionTitleGold = TextStyle(
    color: Color(0xffb79d01),
    fontSize: 15,
    fontWeight: FontWeight.bold,
  );

  const bulletBoldBlue = TextStyle(fontSize: 12, color: Colors.blue, fontWeight: FontWeight.bold);
  const bulletBoldOrange = TextStyle(fontSize: 12, color: Colors.orange, fontWeight: FontWeight.bold);
  const bulletBoldGold = TextStyle(fontSize: 12, color: Color(0xffb79d01), fontWeight: FontWeight.bold);
  const bulletNormal = TextStyle(fontSize: 12, color: Colors.black, fontWeight: FontWeight.w500);

  return SingleChildScrollView(
    child: Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/SBF_logo.png"),
          fit: BoxFit.cover,
          opacity: 0.2,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 18.0, right: 18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            const Align(
              alignment: Alignment.center,
              child: Text("Key Achievements", style: headerStyle),
            ),

            const SizedBox(height: 28),

            // Key Achievements — Stat Cards
            _StatCard(
              gradient: const LinearGradient(colors: [Colors.blue, Colors.white]),
              number: "24 ",
              label: "States & Zones",
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.bottomRight,
              child: _StatCard(
                gradient: const LinearGradient(colors: [Colors.white, Colors.blue]),
                number: "2,250 ",
                label: "Volunteers",
              ),
            ),

            const SizedBox(height: 28),

            // Response to emergency
            const Text("Response to emergency", style: sectionTitleBlue),
            const Divider(thickness: 5, color: Colors.blue),
            _bulletRich([
              _span("● Rescued 7,000 individuals ", bulletBoldBlue),
              _span(
                "from floods, cyclones, and fire in Assam, Maharashtra, Gujarat, Kerala, West Bengal, Bihar and UP",
                bulletNormal,
              ),
            ]),
            const SizedBox(height: 10),
            _bulletRich([
              _span("● Conducted ", bulletNormal),
              _span("Relief work in 99 emergencies ", bulletBoldBlue),
              _span(
                "providing essential assistance such as ration kit, hygiene kit, cooked food, drinking water, blanket, and clothes.",
                bulletNormal,
              ),
            ]),
            const SizedBox(height: 10),
            _bulletRich([
              _span("● Supported 20,250 families ", bulletBoldBlue),
              _span("providing livelihood to 422 and housing to 1,010", bulletNormal),
            ]),

            const SizedBox(height: 24),

            // Training and Orientation Workshop
            const Text("Training and Orientation Workshop", style: sectionTitleOrange),
            const Divider(thickness: 5, color: Colors.orange),
            _bulletRich([
              _span("● 167 training workshops ", bulletBoldOrange),
              _span("organized at District, State, and National Levels\n", bulletNormal),
              _span(" - Training Programs ", bulletNormal),
              _span("167\n", bulletBoldOrange),
              _span(" - Training Individuals ", bulletNormal),
              _span("6478", bulletBoldOrange),
            ]),

            const SizedBox(height: 24),

            // Social Welfare Activities
            const Text("Social Welfare Activities", style: sectionTitleGold),
            const Divider(thickness: 5, color: Color(0xffb79d01)),

            // Plantation
            _bulletRich([
              _span("● Plantation Program\n", bulletBoldGold),
              _span(" - Total Program ", bulletNormal),
              _span("281\n", bulletBoldGold),
              _span(" - Sapling Planted ", bulletNormal),
              _span("33,548", bulletBoldGold),
            ]),
            const SizedBox(height: 10),

            // General Health Camp
            _bulletRich([
              _span("● General Health Camp\n", bulletBoldGold),
              _span(" - Total Camp ", bulletNormal),
              _span("82\n", bulletBoldGold),
              _span(" - Total Beneficiaries ", bulletNormal),
              _span("19,214", bulletBoldGold),
            ]),
            const SizedBox(height: 10),

            // Blood Donation Camp
            _bulletRich([
              _span("● Blood Donation Camp\n", bulletBoldGold),
              _span(" - Total Program ", bulletNormal),
              _span("128\n", bulletBoldGold),
              _span(" - Units Collected ", bulletNormal),
              _span("4,923", bulletBoldGold),
            ]),
            const SizedBox(height: 10),

            // Awareness Program
            _bulletRich([
              _span("● Awareness Program\n", bulletBoldGold),
              _span(" - Total Program ", bulletNormal),
              _span("647\n", bulletBoldGold),
              _span(" - Total Beneficiaries ", bulletNormal),
              _span("54,042", bulletBoldGold),
            ]),

            const SizedBox(height: 24),
          ],
        ),
      ),
    ),
  );
}

/// --- Helpers ---

class _StatCard extends StatelessWidget {
  final LinearGradient gradient;
  final String number;
  final String label;

  const _StatCard({
    super.key,
    required this.gradient,
    required this.number,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: gradient, borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.all(12),
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: number,
              style: const TextStyle(fontSize: 30, color: Colors.red, fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text: label,
              style: const TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        textAlign: TextAlign.left,
      ),
    );
  }
}

Widget _bulletRich(List<TextSpan> spans) => Text.rich(TextSpan(children: spans), textAlign: TextAlign.left);

TextSpan _span(String text, TextStyle style) => TextSpan(text: text, style: style);
