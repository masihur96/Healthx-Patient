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

    // Refund info data in Bangla and English
    final refundInfo = [
      {
        'bn': 'অনুজ প্রকাশনী থেকে বই অর্ডার করার জন্য আপনাকে অনেক ধন্যবাদ।',
        'en': 'Thank you for ordering books from Anuj Publication.',
      },
      {
        'bn':
            'অনুজ প্রকাশনী সবসময় নিজেদের বইয়ের কোয়ালিটিতে সর্বোচ্চ শ্রম দেওয়া চেষ্টা করে যেন বইয়ে প্রিন্টিং কোয়ালিটিতে কোনো ত্রুটি না থাকে। তবে মানুষ মাত্রেই ভুল। ভুলবশত যদি বইয়ের ডেলিভারির সময় যদি বইয়ের প্রিন্টিং কোয়ালিটিতে কোনোরকম ত্রুটি থাকে, তবে সেটার জন্য খুবই সুন্দর সমাধান অনুজ রেখেছে।',
        'en':
            'Anuj Publication always strives to ensure the highest quality in printing its books. However, mistakes can happen. If by chance there is any printing defect in your book upon delivery, Anuj has a proper solution in place.',
      },
      {
        'bn':
            'প্রথমত অর্ডার করার সময় আপনি চাইলে ক্যাশ অন হোম ডেলিভারিতে অর্ডার করতে পারবেন। সেক্ষেত্রে বই আপনার বাসায় পৌঁছানোর পর আপনি সেই পার্সেল খুলে বের করে চেক করে এরপর ডেলিভারি ম্যানকে টাকা দিতে পারবেন।',
        'en':
            'Firstly, you can choose Cash on Home Delivery when placing your order. In this case, you can check the parcel at home before paying the delivery person.',
      },
      {
        'bn':
            'এছাড়াও আরো একটা উপায় হলো বইয়ের প্রিন্টিং কোয়ালিটিতে যদি কোনো ত্রুটি থাকে যাবে বই ডেলিভারি হবার ৩ দিনের মধ্যেই উপযুক্ত প্রমানসহ 01317-466054 এই নম্বরে হোয়াটস্যাপ করবেন। তখন আমরা বইটি পাল্টে দেয়ার ব্যবস্থা করবো।',
        'en':
            'Alternatively, if there is any printing defect, you can WhatsApp proof to 01317-466054 within 3 days of delivery. We will arrange to replace the book.',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: const Icon(Icons.arrow_back_ios),
          ),
        ),
        title: Text(languageProvider.isBangla
            ? 'রিফান্ড ও বুক চেক'
            : 'Refund & Book Check'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: refundInfo.length,
          itemBuilder: (context, index) {
            final info = refundInfo[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                languageProvider.isBangla ? info['bn']! : info['en']!,
                style: TextStyle(
                  fontSize: 16,
                  color: themeProvider.isDarkMode ? Colors.white : Colors.black,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
