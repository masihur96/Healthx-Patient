import 'package:flutter/material.dart';
import 'package:healthx_patient/shared/providers/language_provider.dart';
import 'package:healthx_patient/shared/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class RefundScreen extends StatelessWidget {
  const RefundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final languageProvider = Provider.of<LanguageProvider>(context);

    // Telemedicine Refund and Policy Information
    final refundInfo = [
      {
        'bn': 'আমাদের টেলিমেডিসিন সেবা ব্যবহারের জন্য আপনাকে ধন্যবাদ।',
        'en': 'Thank you for using our telemedicine service.',
      },
      {
        'bn':
            'আপনার স্বাস্থ্য পরামর্শ সর্বোচ্চ মান বজায় রেখে সঠিকভাবে পৌঁছে দেওয়াই আমাদের লক্ষ্য। তবে নেটওয়ার্ক সমস্যা বা অন্য যেকোনো কারণে ডাক্তার পরামর্শ দিতে না পারলে আপনার পেমেন্ট সুরক্ষিত থাকে।',
        'en':
            'Our goal is to provide high-quality medical consultation. However, if the doctor cannot complete the consultation due to technical or network issues, your payment remains secured.',
      },
      {
        'bn':
            'যদি ডাক্তার নির্ধারিত সময়ে কল না করেন বা কনসালটেশন সম্পূর্ণ না হয়, সেক্ষেত্রে আপনি রিফান্ডের জন্য আবেদন করতে পারবেন।',
        'en':
            'If the doctor does not call at the scheduled time or the consultation remains incomplete, you can request a refund.',
      },
      {
        'bn':
            'রিফান্ড আবেদন করতে, অ্যাপের “Support” সেকশনে যান এবং সমস্যার বিস্তারিত লিখে সাবমিট করুন। যাচাইয়ের পর ৩-৫ কার্যদিবসের মধ্যে রিফান্ড সম্পন্ন হবে।',
        'en':
            'To request a refund, go to the “Support” section in the app and submit your issue. After verification, refunds are processed within 3–5 business days.',
      },
      {
        'bn':
            'যদি ডাক্তার আংশিক সময় পরামর্শ দেন বা কনসালটেশন মাঝপথে নেটওয়ার্ক সমস্যায় বন্ধ হয়ে যায়, আমরা পুনরায় কলের জন্য সময় নির্ধারণ করে দেবো।',
        'en':
            'If the consultation was partially completed or interrupted due to network issues, we will arrange a rescheduled call for you.',
      },
      {
        'bn':
            'যেসব ক্ষেত্রে রিফান্ড প্রযोज্য নয়:\n• কনসালটেশন সফলভাবে সম্পন্ন হলে\n• প্রেসক্রিপশন ইস্যু হওয়ার পর\n• শিডিউল বাদে দেরিতে অনুরোধ করলে',
        'en':
            'Refund is not applicable in the following cases:\n• Consultation completed successfully\n• Prescription has already been issued\n• Refund requested after the allowed timeframe',
      },
      {
        'bn':
            'যেকোনো রিফান্ড, কনসালটেশন বা প্রেসক্রিপশন সংক্রান্ত সমস্যায় আমাদের হেল্পলাইনে যোগাযোগ করুন: 013XX-XXXXXX',
        'en':
            'For any refund, consultation, or prescription-related issue, contact our support helpline: 013XX-XXXXXX',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: Text(languageProvider.isBangla
            ? 'রিফান্ড ও নীতিমালা'
            : 'Refund & Policy'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: refundInfo.length,
          itemBuilder: (context, index) {
            final info = refundInfo[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                languageProvider.isBangla ? info['bn']! : info['en']!,
                style: TextStyle(
                  fontSize: 16,
                  height: 1.5,
                  color: themeProvider.isDarkMode
                      ? Colors.grey[300]
                      : Colors.black87,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
