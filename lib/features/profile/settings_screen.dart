import 'package:flutter/material.dart';
import 'package:healthx_patient/configs/app_localizations.dart';
import 'package:healthx_patient/core/constants/app_colors.dart';
import 'package:healthx_patient/shared/providers/language_provider.dart';
import 'package:healthx_patient/shared/providers/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isDarkMode = false;
  String _currentLanguage = 'English';
  String _selectedFont = "Inter";
  String _selectedSkip = "15s";
  String _selectedNotification = "Promo";

  // Change password form controllers
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _changePasswordFormKey = GlobalKey<FormState>();
  bool _isChangingPassword = false;
  bool _obscureCurrentPassword = true;
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkMode = prefs.getBool('dark_mode') ?? false;
      _currentLanguage = prefs.getString('language') ?? 'English';
    });
  }

  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('dark_mode', _isDarkMode);
    await prefs.setString('language', _currentLanguage);
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final languageProvider = Provider.of<LanguageProvider>(context);

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
        title: Text(languageProvider.isBangla ? "সেটিংস" : "Settings"),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _sectionTitle(languageProvider.isBangla ? "ভাষা" : "Language"),
          _languageSetting(languageProvider),

          const SizedBox(height: 16),
          _sectionTitle(languageProvider.isBangla ? "থিম" : "Theme"),
          _themeSetting(languageProvider),

          //Change Password
          const SizedBox(height: 16),
          _sectionTitle(languageProvider.isBangla
              ? "পাসওয়ার্ড পরিবর্তন করুন"
              : "Change Password"),
          _changePasswordWidget(languageProvider),

          // _themeSetting(localizations),
          // const SizedBox(height: 16),
          // _sectionTitle(localizations.setDefaultFont),
          // _fontSetting(localizations),

          // _audioControl(localizations),

          // const SizedBox(height: 16),
          // _sectionTitle(localizations.notification),
          // _notificationSetting(localizations),

          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 8),
      child: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _languageSetting(LanguageProvider languageProvider) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.language),
        title: Text(languageProvider.isBangla ? "ভাষা" : "Language"),
        subtitle: Text(languageProvider.isBangla
            ? "আপনার পছন্দের ভাষা নির্বাচন করুন"
            : "Select your preferred language"),
        trailing: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            icon: Icon(Icons.chevron_right),
            value: Provider.of<LanguageProvider>(context)
                .currentLocale
                .languageCode,
            items: const [
              DropdownMenuItem(value: 'en', child: Text('English')),
              DropdownMenuItem(value: 'bn', child: Text('বাংলা')),
            ],
            onChanged: (value) {
              if (value != null) {
                Provider.of<LanguageProvider>(context, listen: false)
                    .changeLanguage(value);
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _themeSetting(LanguageProvider languageProvider) {
    return Card(
      child: SwitchListTile(
        activeColor: AppColors.buttonColor,
        inactiveThumbColor: AppColors.black,
        title: Text(languageProvider.isBangla ? "থিম" : "Theme"),
        subtitle: Text(languageProvider.isBangla
            ? "লাইট এবং ডার্ক থিমের মধ্যে পরিবর্তন করুন"
            : "Switch between light and dark theme"),
        secondary: const Icon(Icons.dark_mode),
        value: _isDarkMode,
        onChanged: (value) async {
          setState(() => _isDarkMode = value);
          Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
          await _saveSettings();
        },
      ),
    );
  }

  Widget _fontSetting(AppLocalizations localizations) {
    final fonts = ["Inter", "Roboto", "OpenSans"];
    return Column(
      children: [
        Card(
          child: ListTile(
            leading: const Icon(Icons.text_fields),
            title: Text(localizations.defaultFont),
            subtitle: Text(localizations.setDefaultFontForBooks),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: fonts.map((font) {
              final isSelected = _selectedFont == font;
              return Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        isSelected ? Colors.yellow : Colors.grey[200],
                    foregroundColor: isSelected ? Colors.black : Colors.black54,
                    shape: const StadiumBorder(),
                    elevation: 0,
                  ),
                  onPressed: () {
                    setState(() => _selectedFont = font);
                  },
                  child: Text(font),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _audioControl(AppLocalizations localizations) {
    final skips = ["10s", "15s", "30s"];
    return Column(
      children: [
        Card(
          child: ListTile(
            leading: const Icon(Icons.headphones),
            title: Text(localizations.skipDuration),
            subtitle: Text(localizations.setAudioSkipDuration),
          ),
        ),
        Row(
          children: skips.map((skip) {
            final isSelected = _selectedSkip == skip;
            return Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      isSelected ? Colors.yellow : Colors.grey[200],
                  foregroundColor: isSelected ? Colors.black : Colors.black54,
                  shape: StadiumBorder(),
                  elevation: 0,
                ),
                onPressed: () {
                  setState(() => _selectedSkip = skip);
                },
                child: Text(skip),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _notificationSetting(AppLocalizations localizations) {
    final notification = ["Promo", "New Book"];
    return Column(
      children: [
        Card(
          child: ListTile(
            leading: const Icon(Icons.notifications_active),
            title: Text(localizations.notification),
            subtitle: Text(localizations.manageNotificationPreference),
          ),
        ),
        Row(
          children: notification.map((notification) {
            final isSelected = _selectedNotification == notification;
            return Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      isSelected ? Colors.yellow : Colors.grey[200],
                  foregroundColor: isSelected ? Colors.black : Colors.black54,
                  shape: StadiumBorder(),
                  elevation: 0,
                ),
                onPressed: () {
                  setState(() => _selectedNotification = notification);
                },
                child: Text(notification),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _logoutButton(AppLocalizations localizations) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {
              // Add logout logic
            },
            icon: const Icon(Icons.logout, color: Colors.white),
            label: Text(localizations.logout,
                style: const TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),
        ),
      ],
    );
  }

  Widget _notificationButton(IconData icon, String label) {
    return ElevatedButton(
      onPressed: () {
        // Handle notification preference
      },
      child: Text(label),
    );
  }

  Widget _changePasswordWidget(LanguageProvider languageProvider) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _changePasswordFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.lock),
                  const SizedBox(width: 8),
                  Text(
                    languageProvider.isBangla
                        ? "পাসওয়ার্ড পরিবর্তন"
                        : "Change Password",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Current Password Field
              TextFormField(
                controller: _currentPasswordController,
                obscureText: _obscureCurrentPassword,
                decoration: InputDecoration(
                  labelText: languageProvider.isBangla
                      ? "বর্তমান পাসওয়ার্ড"
                      : "Current Password",
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureCurrentPassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureCurrentPassword = !_obscureCurrentPassword;
                      });
                    },
                  ),
                  border: const OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your current password";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // New Password Field
              TextFormField(
                controller: _newPasswordController,
                obscureText: _obscureNewPassword,
                decoration: InputDecoration(
                  labelText: languageProvider.isBangla
                      ? "নতুন পাসওয়ার্ড"
                      : "New Password",
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureNewPassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureNewPassword = !_obscureNewPassword;
                      });
                    },
                  ),
                  border: const OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a new password";
                  }
                  if (value.length < 8) {
                    return "Password must be at least 8 characters";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Confirm Password Field
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: _obscureConfirmPassword,
                decoration: InputDecoration(
                  labelText: languageProvider.isBangla
                      ? "নতুন পাসওয়ার্ড নিশ্চিত করুন"
                      : "Confirm New Password",
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureConfirmPassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureConfirmPassword = !_obscureConfirmPassword;
                      });
                    },
                  ),
                  border: const OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please confirm your new password";
                  }
                  if (value != _newPasswordController.text) {
                    return "Passwords do not match";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Change Password Button
              SizedBox(
                width: double.infinity,
                child: _isChangingPassword
                    ? const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.black),
                            ),
                          ),
                          SizedBox(width: 8),
                          Text("Changing Password..."),
                        ],
                      )
                    : ElevatedButton(
                        onPressed: () {},
                        // onPressed: _isChangingPassword ? null : _changePassword,
                        // // onPressed: _isChangingPassword ? null : _changePassword,
                        // // style: ElevatedButton.styleFrom(
                        // //   backgroundColor: AppColors.buttonColor,
                        // //   foregroundColor: Colors.black,
                        // //   padding: const EdgeInsets.symmetric(vertical: 12),
                        // //   shape: RoundedRectangleBorder(
                        // //     borderRadius: BorderRadius.circular(8),
                        // //   ),
                        // // ),
                        child: Text(
                          languageProvider.isBangla
                              ? "পাসওয়ার্ড পরিবর্তন"
                              : "Change Password",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Future<void> _changePassword() async {
  //   if (!_changePasswordFormKey.currentState!.validate()) {
  //     return;
  //   }
  //
  //   setState(() {
  //     _isChangingPassword = true;
  //   });
  //
  //   try {
  //     final authService = AuthService();
  //     final isSuccess = await authService.changePassword(
  //       currentPassword: _currentPasswordController.text,
  //       newPassword: _newPasswordController.text,
  //       confirmPassword: _confirmPasswordController.text,
  //     );
  //
  //     if (isSuccess) {
  //       // Show success message
  //       if (mounted) {
  //         AppSnackBar.show(
  //           context,
  //           message: 'Password changed successfully!',
  //         );
  //
  //         // Clear form
  //         _currentPasswordController.clear();
  //         _newPasswordController.clear();
  //         _confirmPasswordController.clear();
  //         Navigator.pop(context);
  //       }
  //     } else {
  //       // Show error message
  //       if (mounted) {
  //         AppSnackBar.show(
  //           context,
  //           message: 'Current Password is Wrong',
  //         );
  //       }
  //     }
  //   } catch (e) {
  //     if (mounted) {
  //       AppSnackBar.show(
  //         context,
  //         message: 'An error occurred: ${e.toString()}',
  //       );
  //     }
  //   } finally {
  //     if (mounted) {
  //       setState(() {
  //         _isChangingPassword = false;
  //       });
  //     }
  //   }
  // }
}
