import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/about_secession_controller.dart';

class AboutSecessionView extends GetView<AboutSecessionController> {
  const AboutSecessionView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEDE7F6),
      appBar: AppBar(
        backgroundColor: Color(0xffA180F5),
        elevation: 1,
        title: Text(
          "About",
          style: GoogleFonts.fredoka(
            color: Colors.white,
            fontSize: 35,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body:  ListView(
        children: [
          const CustomExpansionTile(
            title: 'Terms & Conditions',
            content: Text('1. Acceptance of TermsBy using this AI Agent App, you agree to comply with these Terms and Conditions. If you do not agree, please do not use the app.\n\n2. Use of the AppThe app provides AI-powered assistance and information. You agree to use it responsibly and not for any illegal, harmful, or offensive purposes.\n\n3. User Data and PrivacyWe may collect certain data to improve app functionality. Your personal data will be handled according to our Privacy Policy. Do not share sensitive personal information within the app.\n\n4. Intellectual PropertyAll content, AI models, and features within the app are the intellectual property of the app developers. You may not copy, distribute, or reproduce them without permission.'),
          ),
          const CustomExpansionTile(
            title: 'Privacy Policy',
            content: Text('1. Data Collection We may collect information such as usage data, device information, and interactions within the app to improve functionality.\n\n2. Use of DataCollected data is used to enhance app performance, provide better AI responses, and ensure a smooth user experience.\n\n3. Data SharingWe do not sell, trade, or share your personal information with third parties.\n\n4. SecurityWe implement reasonable measures to protect your data from unauthorized access or disclosure.\n\n5. ConsentBy using the app, you agree to this Privacy Policy and the handling of your data as described.'),
          ),
          CustomExpansionTile(
            title: 'About Developer',
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: Image.asset('assets/images/pic3.jpg',  height: 100, width: 100, fit: BoxFit.cover,)),
                const SizedBox(height: 10),
                const Text('Developer:',style: TextStyle(fontWeight: FontWeight.w600,color: Colors.black,fontSize: 17)),
                const Text('Name:  Jihad Ahmed'),
                const Text('Email:  md.jihad.info2006@gmail.com'),
                const Text('GitHub:  https://github.com/mdjihad2006'),
              ],
            )
          ),
        ],
      ),
    );
  }
}

class CustomExpansionTile extends StatefulWidget {
  final String title;
  final Widget content;

  const CustomExpansionTile({super.key, required this.title, required this.content});

  @override
  State<CustomExpansionTile> createState() => _CustomExpansionTileState();
}

class _CustomExpansionTileState extends State<CustomExpansionTile> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: ListTile(
            tileColor: Colors.deepPurple.withOpacity(0.2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(13),
            ),
            title: Padding(
              padding: const EdgeInsets.all(17),
              child: Text(
                widget.title,
                style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
              ),
            ),
            trailing: Icon(isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down),
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
          ),
        ),
        if (isExpanded)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(13),
              ),
              child: widget.content,
            ),
          ),
        const SizedBox(height: 10),
        const Divider(height: 1),
      ],
    );
  }
}

