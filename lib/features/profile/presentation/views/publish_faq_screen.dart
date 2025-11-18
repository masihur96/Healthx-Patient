import 'package:flutter/material.dart';
import 'package:healthx_patient/shared/providers/language_provider.dart';
import 'package:healthx_patient/shared/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class PublishFaqScreen extends StatelessWidget {
  const PublishFaqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final languageProvider = Provider.of<LanguageProvider>(context);

    // FAQ Data with Bangla & English
    final faqs = [
      {
        'bn_question': 'আমি কিভাবে Anuj App এ ইবুক প্রকাশ করবো?',
        'en_question': 'How can I publish an eBook on Anuj App?',
        'bn_answer':
            'আপনি অনুগ্রহ করে আপনার নাম, ফোন নম্বর(Whatsapp), আপনার ফেসবুক আইডির লিংক এবং আপনার গল্পের বা বইয়ের ইউনিকোডে লেখা Docs ফাইল আমাদের anujprokashoni@gmail.com  এই এড্রেসে মেইল করুন অথবা Whatsapp করুন ০১৮৪৯-৯৪০১০১ এই নম্বরে।',
        'en_answer':
            'Please email your name, phone number (Whatsapp), Facebook ID link, and your story or book in a Unicode Docs file to anujprokashoni@gmail.com or Whatsapp to 01849-940101.',
      },
      {
        'bn_question': 'আমি কিভাবে অনুজ প্রকাশনীতে হার্ডকপি বই প্রকাশ করবো?',
        'en_question':
            'How can I publish a hardcover book at Anuj Publication?',
        'bn_answer': 'আপনি অনুগ্রহ করে 01317-466054 এই নম্বরে যোগাযোগ করুন।',
        'en_answer': 'Please contact 01317-466054.',
      },
      {
        'bn_question':
            'ইবুকে লেখক/প্রকাশকদের সাথে অনুজ কত পার্সেন্ট রেভেন্যু শেয়ার করে?',
        'en_question':
            'What percentage of revenue does Anuj share with eBook authors/publishers?',
        'bn_answer':
            'প্রথম অবস্থায় অনুজ সব লেখকদের সাথে ইবুকের নির্ধারিত মুল্যের অনুজ ৫০% রেভেন্যু শেয়ার করে থাকে। তবে আপনার জনপ্রিয়তা এবং প্রকাশিত বইয়ের সংখ্যা বিবেচনা করা অনুজ অবশ্যই রেভেন্যু কিভাবে কমবেশি করা যায় তা বিবেচনা করবে।',
        'en_answer':
            'Initially, Anuj shares 50% of the set price with all authors. However, depending on your popularity and the number of books published, Anuj may adjust the revenue share.',
      },
      {
        'bn_question': 'লেখক কি অনুজ ইবুকে বইয়ের দাম ঠিক করতে পারবেন?',
        'en_question': 'Can authors set the price of their eBook on Anuj?',
        'bn_answer':
            'জি অবশ্যই পারবেন। তবে আমরা সবসময় লেখকদের উৎসাহ দিই যেন বইয়ের দাম যথাসম্ভব সাশ্রয়ী রাখা হয়। বাংলাদেশে এখনো ই-বুক পড়ার সংস্কৃতি গড়ে উঠছে, আর এই অভ্যাসকে জনপ্রিয় করতে সুলভ মূল্যই সবচেয়ে বড় ভূমিকা রাখবে। চাইলে আপনি আপনার বই সম্পূর্ণ ফ্রি তেও প্রকাশ করতে পারেন—এর জন্য অনুজ প্রকাশনীকে কোনো ধরনের চার্জ প্রদান করতে হয় না।',
        'en_answer':
            'Yes, authors can set the price. We encourage reasonable pricing to promote eBook reading culture in Bangladesh. You can even publish your book for free without any charge from Anuj.',
      },
      {
        'bn_question': 'অনুজ ইবুকে বই প্রকাশ করতে কপিরাইটে কোন পরিবর্তন লাগবে?',
        'en_question': 'Does publishing on Anuj eBook change copyright?',
        'bn_answer':
            'আপনার বইয়ের কপিরাইট আপনারই থাকবে। তবে বইটির যে ইবুক অনুজে প্রকাশিত হবে তার মালিকানা থাকবে অনুজের। এর মানে হচ্ছে, অনুজে প্রকাশিত ইবুকটি আপনি অন্যকোন কাজে ব্যবহারের জন্য আমাদের কাছে চাইতে পারবেন না।',
        'en_answer':
            'The copyright of your book remains yours. However, the eBook published on Anuj belongs to Anuj. You cannot use the published eBook elsewhere without permission.',
      },
      {
        'bn_question': 'আমি কিভাবে আমার আয় জানতে পারবো?',
        'en_question': 'How can I check my earnings?',
        'bn_answer':
            'অনুজে বই প্রকাশ করলে আপনাকে অনুজ লেখক পোর্টালে লগিন করার জন্য বিস্তারিত তথ্য দেয়া হবে, যার মাধ্যমে আপনি আপনার সমস্ত আয়, কোন বই কেমন বিক্রি হচ্ছে তা যেকোন সময় জানতে পারবেন।',
        'en_answer':
            'After publishing, you will get access to the Anuj Author Portal to track all your earnings and book sales.',
      },
      {
        'bn_question':
            'অনুজ কিভাবে বইয়ের প্রচারণা বাড়ায়? আমাকে অনুজে আমার ইবুকের প্রচারণার জন্য টাকা দিতে হবে?',
        'en_question':
            'How does Anuj promote books? Do I need to pay for eBook promotion?',
        'bn_answer':
            'প্রথম অবস্থায় আপনার ইবুক অনুজের App এ প্রকাশের পর আপনার বইয়ের অন্য পোস্টার ডিজাইন করে দেওয়া হবে। এই পোস্টার দিয়ে আপনি সহজেই প্রচার করতে পারবেন। তাছাড়া প্রথম অবস্থায় আপনার ইবুক নিয়ে অনুজের অফিশিয়াল পেজ থেকে পোস্ট দেওয়া হবে। তবে আপনার বইয়ের জন্য আলাদাভাবে অনুজের পক্ষ থেকে বুস্ট রান করা হবে কিনা তা নির্ভর করে আপনার জনপ্রিয়তা, প্রকাশিত বইয়ের সংখ্যা এবং নানা বিষয়ের ওপর।',
        'en_answer':
            'Initially, your eBook will be featured on Anuj App and a poster will be provided for promotion. Additional boosts depend on popularity, number of books, and other factors.',
      },
      {
        'bn_question': 'কেউ কি আমার বই কপি করে পিডিএফ বানিয়ে ফেলতে পারবে?',
        'en_question': 'Can someone copy my book into PDF?',
        'bn_answer':
            'অনুজ ইবুক রিডার সর্বোচ্চ সিকিউরিটি অবলম্বন করবে যেন আপনার ইবুক কপি করা না যায়। এজন্য আমরা আমাদের App এ ইবুকের পিডিএফ ডাউনলোডের কোনো অপশন রাখিনি।',
        'en_answer':
            'The Anuj eBook reader uses maximum security, and PDF download is disabled to prevent copying.',
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
            ? "অনুজে প্রকাশ করুন"
            : "Publish on Anuj"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: faqs.length,
        itemBuilder: (context, index) {
          final faq = faqs[index];
          final question = languageProvider.isBangla
              ? faq['bn_question']!
              : faq['en_question']!;
          final answer =
              languageProvider.isBangla ? faq['bn_answer']! : faq['en_answer']!;
          return ExpansionTile(
            title: Text(question),
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(answer),
              ),
            ],
          );
        },
      ),
    );
  }
}
