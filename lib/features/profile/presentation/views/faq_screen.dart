import 'package:flutter/material.dart';
import 'package:healthx_patient/shared/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    final faqs = [
      {
        "q": "টেলিমেডিসিন অ্যাপটি কী?",
        "a":
            "এটি একটি অনলাইন চিকিৎসা সেবা প্ল্যাটফর্ম যেখানে আপনি ভিডিও কল, অডিও কল বা চ্যাটের মাধ্যমে যেকোনো সময় বিশেষজ্ঞ ডাক্তারের পরামর্শ নিতে পারবেন।"
      },
      {
        "q": "আমি কীভাবে অ্যাপে একাউন্ট তৈরি করবো?",
        "a":
            "মোবাইল নাম্বার বা ইমেইল ব্যবহার করে রেজিস্ট্রেশন করতে পারবেন। OTP ভেরিফিকেশন সম্পন্ন হলে আপনার একাউন্ট তৈরি হবে।"
      },
      {
        "q": "কিভাবে ডাক্তার অ্যাপয়েন্টমেন্ট বুক করবো?",
        "a":
            "হোম স্ক্রিন থেকে 'Find Doctor' এ যান → পছন্দের ডাক্তার সিলেক্ট করুন → সময় নির্ধারণ করুন → 'Confirm Appointment' চাপুন।"
      },
      {
        "q": "ভিডিও কলে চিকিৎসা নেওয়ার জন্য প্রয়োজনীয়তা কী?",
        "a":
            "ভাল ইন্টারনেট কানেকশন, স্মার্টফোন, এবং ক্যামেরা/মাইক্রোফোন অন থাকতে হবে।"
      },
      {
        "q": "অনলাইন প্রেসক্রিপশন কি পাবো?",
        "a":
            "হ্যাঁ, ডাক্তার আপনার সমস্যা শুনে সাথে সাথে ডিজিটাল প্রেসক্রিপশন তৈরি করে দেবেন। আপনি অ্যাপ থেকে তা ডাউনলোড বা শেয়ার করতে পারবেন।"
      },
      {
        "q": "আমি কি ওষুধ অর্ডার করতে পারবো?",
        "a":
            "হ্যাঁ, প্রেসক্রিপশন অনুযায়ী অ্যাপ থেকে সরাসরি ওষুধ অর্ডার করতে পারবেন। হোম ডেলিভারি সুবিধাও আছে।"
      },
      {
        "q": "ডেটা কি নিরাপদ?",
        "a":
            "আপনার যাবতীয় ডেটা এবং মেডিকেল ইনফরমেশন সম্পূর্ণ এনক্রিপ্টেড এবং সিকিউর। কারো সাথে শেয়ার করা হয় না।"
      },
      {
        "q": "রিফান্ড পলিসি কী?",
        "a":
            "যদি ডাক্তার কল না করে অথবা অ্যাপয়েন্টমেন্ট সফল না হয়, তাহলে রিফান্ড আবেদন করতে পারবেন। যাচাইয়ের পর টাকা ফেরত দেওয়া হয়।"
      },
      {
        "q": "ডাক্তারের সাথে কত মিনিট কথা বলতে পারবো?",
        "a":
            "প্রতিটি অ্যাপয়েন্টমেন্টের জন্য নির্দিষ্ট সময় (১০–১৫ মিনিট) থাকে। প্রয়োজনে ডাক্তার সময় বাড়াতে পারেন।"
      },
    ];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text("প্রশ্নোত্তর"),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            "টেলিমেডিসিন সেবা ব্যবহারকারীদের সাধারণ কিছু প্রশ্ন ও তার উত্তর এখানে দেওয়া হলো—",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 16),
          ...faqs.map((faq) {
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 2,
              child: ExpansionTile(
                tilePadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                title: Text(
                  faq["q"]!,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      faq["a"]!,
                      style: TextStyle(
                        height: 1.5,
                        color: themeProvider.isDarkMode
                            ? Colors.grey[300]
                            : Colors.grey[700],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
