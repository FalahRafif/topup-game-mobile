import 'package:flutter/material.dart';
import '../../constants.dart';

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({Key? key}) : super(key: key);

  final List<Map<String, String>> faqItems = const [
    {
      "question": "How do I edit my profile?",
      "answer": "Go to Profile > Edit, change your info, then tap Save."
    },
    {
      "question": "How do I enable dark mode?",
      "answer": "Go to Settings and toggle the Dark Mode switch."
    },
    {
      "question": "I forgot my password.",
      "answer": "Use the 'Forgot Password' option on the login screen."
    },
    {
      "question": "How do I contact support?",
      "answer": "Email us at support@example.com or use the Contact Us button."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        title: const Text("Help Center", style: TextStyle(color: Colors.black)),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: faqItems.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final faq = faqItems[index];
          return ExpansionTile(
            tilePadding: const EdgeInsets.symmetric(horizontal: 16),
            childrenPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            backgroundColor: Colors.white,
            collapsedBackgroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            collapsedShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            iconColor: kPrimaryColor,
            collapsedIconColor: kPrimaryColor,
            title: Text(
              faq["question"]!,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
            children: [
              Text(
                faq["answer"]!,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
