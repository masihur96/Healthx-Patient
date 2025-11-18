import 'package:flutter/material.dart';


class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'continueReading': 'Continue Reading',
      'more': 'More',
      'start': 'Start',
      'switchTheme': 'Switch between light and dark theme',
      'favoriteBook': 'Favorite Book',
      'newBook': 'New Book',
      'newStories': 'New Stories',
      'category': 'Category',
      'bestFreeBook': 'Best Free Book',
      'todaysChoice': "Today's Choice",
      'newThisWeek': 'New This Week',
      'islamicBook': 'Islamic Book',
      'nonFictionEbook': 'Non-fiction Ebook',
      'popularAuthors': 'Popular Authors',
      'recommendedEbooks': 'Recommended Ebooks',
      'home': 'Home',
      'bestSeller': 'Best Seller',
      'stories': 'Stories',
      'shelf': 'Shelf',
      'purchased': 'Purchased',
      'profile': 'Profile',
      'readALittle': 'Read a Little',
      'buyNow': 'Buy Now',
      'about': 'About',
      'similarBooks': 'Similar Books',
      'checkout': 'Checkout',
      'credit': 'Credit',
      'total': 'Total',
      'haveAnyPromo': 'Have any Promo?',
      'apply': 'APPLY',
      'payment': 'Payment',
      'byProceeding': 'By proceeding, you read and agreed to',
      'termsConditions': 'Terms & Conditions',
      'privacyPolicy': 'Privacy Policy',
      'and': 'and',
      'returnRefundPolicy': 'Return & Refund Policy',
      'selectCategory': 'Select Category',
      'shortStory': 'Short Story',
      'editProfileSettings': 'Edit Profile Settings',
      'settings': 'Settings',
      'following': 'Following',
      'booksInShelf': 'Books in Shelf',
      'promo': 'Promo',
      'myWishList': 'My Wish List',
      'purchasedBooks': 'Purchased Books',
      'editProfile': 'Edit Profile',
      'name': 'Name',
      'email': 'Email',
      'saveChanges': 'Save Changes',
      'language': 'Language',
      'selectLanguage': 'Select your preferred language',
      'theme': 'Theme',
      'default': 'Default',
      'dark': 'Dark',
      'giftBook': 'Gift Book',
      'light': 'Light',
      'setDefaultFont': 'Reading',
      'audioBookControl': 'Audio book fast forward/rewind',
      'notification': 'Notifications',
      'logout': 'Logout',
      'hardCopyBook': 'Hard Copy Book',
      'defaultFont': 'Default Font',
      'setDefaultFontForBooks': 'Set default font for books',
      'skipDuration': 'Skip Duration',
      'setAudioSkipDuration': 'Set audio skip duration',
      'manageNotificationPreference': 'Manage notification preference',
      'worldOfLiterature': 'Your Journey Through Literature Begins.',
      'signInDiscover': 'Sign in to access books, subscriptions, and personalized recommendations.',
      'continueWithGoogle': 'Continue with Google',
      'continueWithFacebook': 'Continue with Facebook',
      'or': 'or',
      'continueWithPhoneEmail': 'Continue with Phone/Email',
      'createNewAccount': 'Create New Account?',
      'clickHere': 'Click here',
      'agreeToTerms': 'By continuing, you agree to our',
      'terms': 'Terms',
      'signUpTitle': 'Sign Up',
      'createYourAccount': 'Create Your Account',
      'joinUsMessage': 'Join us to discover books, manage your subscriptions, and get personalized recommendations.',
      'fullName': 'Full Name',
      'enterFullName': 'Enter your full name',
      'phoneNumber': 'Phone Number',
      'enterValidPhone': 'Enter a valid phone number',
      'enterEmail': 'Enter your email',
      'enterValidEmail': 'Enter a valid email',
      'passwordHint': 'Password must be at least 8 characters',
      'byRegistering': 'By registering, you agree to our',
      'alreadyHaveAccount': 'Already have an account?',
      'login': 'Login',
      'forgotPassword': 'Forgot Password?',
      'trending': 'Trending',
      'topFree': 'Top Free',
      'topPaid': 'Top Paid',
      'authors': 'Authors',
    },
    'bn': {
      'continueReading': 'পড়া চালিয়ে যান',
      'more': 'আরও',
      'start': 'শুরু করুন',
      'favoriteBook': 'প্রিয় বই',
      'newStories': 'নতুন গল্প',
      'newBook': 'নতুন বই',
      'category': 'বিভাগ',
      'switchTheme': 'লাইট এবং ডার্ক থিমের মধ্যে পরিবর্তন করুন',
      'bestFreeBook': 'সেরা ফ্রি বই',
      'todaysChoice': 'আজকের পছন্দ',
      'newThisWeek': 'এই সপ্তাহে নতুন',
      'islamicBook': 'ইসলামী বই',
      'giftBook': 'উপহার বই',
      'nonFictionEbook': 'অকল্পিত ইবুক',
      'popularAuthors': 'জনপ্রিয় লেখকগণ',
      'recommendedEbooks': 'প্রস্তাবিত ইবুক',
      'home': 'হোম',
      'bestSeller': 'সেরা বিক্রেতা',
      'stories': 'গল্পসমূহ',
      'purchased': 'ক্রয়কৃত',
      'profile': 'প্রোফাইল',
      'readALittle': 'অল্প পড়ুন',
      'buyNow': 'এখনই কিনুন',
      'about': 'সম্পর্কে',
      'similarBooks': 'একই ধরনের বই',
      'checkout': 'চেকআউট',
      'credit': 'ক্রেডিট',
      'total': 'মোট',
      'haveAnyPromo': 'কোনো প্রোমো আছে?',
      'apply': 'প্রয়োগ করুন',
      'payment': 'পেমেন্ট',
      'byProceeding': 'এগিয়ে গিয়ে, আপনি পড়েছেন এবং সম্মত হয়েছেন',
      'termsConditions': 'শর্তাবলী',
      'privacyPolicy': 'গোপনীয়তা নীতি',
      'and': 'এবং',
      'returnRefundPolicy': 'রিটার্ন ও রিফান্ড নীতি',
      'selectCategory': 'বিভাগ নির্বাচন করুন',
      'shortStory': 'ছোট গল্প',
      'editProfileSettings': 'প্রোফাইল সেটিংস সম্পাদনা করুন',
      'settings': 'সেটিংস',
      'following': 'অনুসরণ',
      'booksInShelf': 'শেলফে বইসমূহ',
      'promo': 'প্রোমো',
      'myWishList': 'আমার উইশ লিস্ট',
      'purchasedBooks': 'কেনা বই',
      'editProfile': 'প্রোফাইল সম্পাদনা করুন',
      'name': 'নাম',
      'email': 'ইমেইল',
      'saveChanges': 'পরিবর্তন সংরক্ষণ করুন',
      'language': 'ভাষা',
      'selectLanguage': 'আপনার পছন্দের ভাষা নির্বাচন করুন',
      'theme': 'থিম',
      'default': 'ডিফল্ট',
      'dark': 'ডার্ক',
      'light': 'লাইট',
      'setDefaultFont': 'বইয়ের জন্য ডিফল্ট ফন্ট সেট করুন',
      'audioBookControl': 'অডিও বই ফরোয়ার্ড/রিওয়াইন্ড করুন',
      'notification': 'নোটিফিকেশন',
      'logout': 'লগআউট',
      'hardCopyBook': 'হার্ড কপি বই',
      'defaultFont': 'ডিফল্ট ফন্ট',
      'setDefaultFontForBooks': 'বইয়ের জন্য ডিফল্ট ফন্ট সেট করুন',
      'skipDuration': 'স্কিপ সময়কাল',
      'setAudioSkipDuration': 'অডিও স্কিপ সময়কাল সেট করুন',
      'manageNotificationPreference': 'নোটিফিকেশন পছন্দ ম্যানেজ করুন',
      'worldOfLiterature': 'সাহিত্য ও সাহসিকতার\nএক জগৎ অপেক্ষা করছে,',
      'signInDiscover': 'বই আবিষ্কার করতে, আপনার সাবস্ক্রিপশন পরিচালনা করতে এবং ব্যক্তিগত সুপারিশ পেতে সাইন ইন করুন।',
      'continueWithGoogle': 'গুগল দিয়ে চালিয়ে যান',
      'continueWithFacebook': 'ফেসবুক দিয়ে চালিয়ে যান',
      'or': 'অথবা',
      'continueWithPhoneEmail': 'ফোন/ইমেইল দিয়ে চালিয়ে যান',
      'createNewAccount': 'নতুন একাউন্ট তৈরি করবেন?',
      'clickHere': 'এখানে ক্লিক করুন',
      'agreeToTerms': 'চালিয়ে গেলে, আপনি আমাদের সাথে একমত হন',
      'terms': 'শর্তাবলী',
      'signUpTitle': 'সাইন আপ',
      'createYourAccount': 'আপনার একাউন্ট তৈরি করুন',
      'joinUsMessage': 'আমাদের সাথে যোগ দিন, বই আবিষ্কার করুন, আপনার সাবস্ক্রিপশন পরিচালনা করুন এবং ব্যক্তিগত সুপারিশ পান।',
      'fullName': 'পূর্ণ নাম',
      'enterFullName': 'আপনার পূর্ণ নাম লিখুন',
      'phoneNumber': 'ফোন নম্বর',
      'enterValidPhone': 'বৈধ ফোন নম্বর লিখুন',
      'enterEmail': 'আপনার ইমেইল লিখুন',
      'enterValidEmail': 'বৈধ ইমেইল লিখুন',
      'passwordHint': 'পাসওয়ার্ড কমপক্ষে ৮ অক্ষরের হতে হবে',
      'byRegistering': 'নিবন্ধন করে, আপনি আমাদের সাথে একমত হন',
      'alreadyHaveAccount': 'ইতিমধ্যে একটি একাউন্ট আছে?',
      'login': 'লগইন',
      'forgotPassword': 'পাসওয়ার্ড ভুলে গেছেন?',
      'trending': 'ট্রেন্ডিং',
      'topFree': 'শীর্ষ ফ্রি',
      'topPaid': 'শীর্ষ পেইড',
      'authors': 'লেখকগণ',


    },
  };

  String _translate(String key) =>
      _localizedValues[locale.languageCode]?[key] ??
          _localizedValues['en']![key] ??
          key;

  // Getters (Example)
  String get continueReading => _translate('continueReading');
  String get more => _translate('more');
  String get start => _translate('start');
  String get favoriteBook => _translate('favoriteBook');
  String get newBook => _translate('newBook');
  String get newStories => _translate('newStories');
  String get purchased => _translate('purchased');
  String get category => _translate('category');
  String get giftBook => _translate('giftBook');
  String get bestFreeBook => _translate('bestFreeBook');
  String get todaysChoice => _translate('todaysChoice');
  String get newThisWeek => _translate('newThisWeek');
  String get islamicBook => _translate('islamicBook');
  String get switchTheme => _localizedValues[locale.languageCode]!['switchTheme']!;
  String get nonFictionEbook => _translate('nonFictionEbook');
  String get popularAuthors => _translate('popularAuthors');
  String get recommendedEbooks => _translate('recommendedEbooks');
  String get home => _translate('home');
  String get bestSeller => _translate('bestSeller');
  String get stories => _translate('stories');
  String get shelf => _translate('shelf');
  String get profile => _translate('profile');
  String get readALittle => _translate('readALittle');
  String get buyNow => _translate('buyNow');
  String get about => _translate('about');
  String get similarBooks => _translate('similarBooks');
  String get checkout => _translate('checkout');
  String get credit => _translate('credit');
  String get total => _translate('total');
  String get haveAnyPromo => _translate('haveAnyPromo');
  String get apply => _translate('apply');
  String get payment => _translate('payment');

  String get byProceeding => _translate('byProceeding');
  String get termsConditions => _translate('termsConditions');
  String get privacyPolicy => _translate('privacyPolicy');
  String get and => _translate('and');
  String get returnRefundPolicy => _translate('returnRefundPolicy');
  String get selectCategory => _translate('selectCategory');
  String get shortStory => _translate('shortStory');
  String get editProfileSettings => _translate('editProfileSettings');
  String get settings => _translate('settings');
  String get following => _translate('following');
  String get booksInShelf => _translate('booksInShelf');
  String get promo => _translate('promo');
  String get myWishList => _translate('myWishList');
  String get purchasedBooks => _translate('purchasedBooks');
  String get editProfile => _translate('editProfile');
  String get name => _translate('name');
  String get email => _translate('email');
  String get saveChanges => _translate('saveChanges');
  String get language => _translate('language');
  String get selectLanguage => _localizedValues[locale.languageCode]!['selectLanguage']!;
  String get theme => _translate('theme');
  String get defaultTheme => _translate('default');
  String get dark => _translate('dark');
  String get light => _translate('light');
  String get setDefaultFont => _translate('setDefaultFont');
  String get audioBookControl => _translate('audioBookControl');
  String get notification => _translate('notification');
  String get logout => _translate('logout');
  String get hardCopyBook => _translate('hardCopyBook');
  String get defaultFont => _translate('defaultFont');
  String get setDefaultFontForBooks => _translate('setDefaultFontForBooks');
  String get skipDuration => _translate('skipDuration');
  String get setAudioSkipDuration => _translate('setAudioSkipDuration');
  String get manageNotificationPreference => _translate('manageNotificationPreference');
  String get worldOfLiterature => _translate('worldOfLiterature');
  String get signInDiscover => _translate('signInDiscover');
  String get continueWithGoogle => _translate('continueWithGoogle');
  String get continueWithFacebook => _translate('continueWithFacebook');
  String get or => _translate('or');
  String get continueWithPhoneEmail => _translate('continueWithPhoneEmail');
  String get createNewAccount => _translate('createNewAccount');
  String get clickHere => _translate('clickHere');
  String get agreeToTerms => _translate('agreeToTerms');
  String get terms => _translate('terms');
  String get signUpTitle => _translate('signUpTitle');
  String get createYourAccount => _translate('createYourAccount');
  String get joinUsMessage => _translate('joinUsMessage');
  String get fullName => _translate('fullName');
  String get enterFullName => _translate('enterFullName');
  String get phoneNumber => _translate('phoneNumber');
  String get enterValidPhone => _translate('enterValidPhone');
  String get enterEmail => _translate('enterEmail');
  String get enterValidEmail => _translate('enterValidEmail');
  String get passwordHint => _translate('passwordHint');
  String get byRegistering => _translate('byRegistering');
  String get alreadyHaveAccount => _translate('alreadyHaveAccount');
  String get login => _translate('login');
  String get forgotPassword => _translate('forgotPassword');
  String get trending => _translate('trending');
  String get topFree => _translate('topFree');
  String get topPaid => _translate('topPaid');
  String get authors => _translate('authors');
}


class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'bn'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}