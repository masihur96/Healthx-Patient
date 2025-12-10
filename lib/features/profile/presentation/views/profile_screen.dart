import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:healthx_patient/configs/custom_size.dart';
import 'package:healthx_patient/core/constants/app_colors.dart';
import 'package:healthx_patient/features/auth/data/models/auth_user.dart';
import 'package:healthx_patient/features/home_tab/drawer_screen.dart';
import 'package:healthx_patient/features/profile/presentation/views/faq_screen.dart';
import 'package:healthx_patient/features/profile/presentation/views/my_order_screen.dart';
import 'package:healthx_patient/features/profile/presentation/views/refund_screen.dart';
import 'package:healthx_patient/features/profile/settings_screen.dart';
import 'package:healthx_patient/shared/app_snackbar.dart';
import 'package:healthx_patient/shared/avater_widget.dart';
import 'package:healthx_patient/shared/providers/language_provider.dart';
import 'package:healthx_patient/shared/providers/theme_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isLogged = false;
  // List<CartItem> cartBooks = [];
  //
  // UserProfile? userProfile;
  // final ImagePicker _picker = ImagePicker();
  // UserProfileViewModel? _userProfileVM; // Add this line to store the reference

  @override
  void initState() {
    // getUser();

    // _loadCart();
    super.initState();
  }

  // Add listener for profile updates
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Listen to UserProfileViewModel changes
    // _userProfileVM =
    //     context.read<UserProfileViewModel>(); // Store the reference
    // _userProfileVM!.addListener(_onProfileUpdated);
  }

  @override
  void dispose() {
    // Remove listener when widget is disposed
    //_userProfileVM?.removeListener(_onProfileUpdated); // Use stored reference
    super.dispose();
  }

  void _onProfileUpdated() {
    // Refresh user data when profile is updated
    //  getUser();
  }
  //
  // Future<void> _loadCart() async {
  //   cartBooks = await FavoriteService.getCarts();
  //   if (!mounted) return;
  //   setState(() {});
  // }

  // getUser() async {
  //   if (!mounted) return;
  //   setState(() {
  //     isLogged = true;
  //   });
  //
  //   final auth = AuthUser(); // Replace with Provider later
  //
  //   try {
  //     UserProfileResponse? userProfileResponse =
  //         await StorageService.getUserProfileData();
  //     if (userProfileResponse != null) {
  //       if (!mounted) return; // ✅ prevent after-await crash
  //       setState(() {
  //         userProfile = userProfileResponse.data;
  //         isLogged = false;
  //       });
  //     } else {
  //       if (!mounted) return; // ✅ prevent after-await crash
  //       setState(() {
  //         userProfile = null;
  //         isLogged = false;
  //       });
  //     }
  //   } catch (e) {
  //     if (!mounted) return;
  //     setState(() {
  //       isLogged = false;
  //     });
  //   }
  // }

  Future<void> _showImageSourceDialog() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Image Source'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Camera'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      // final XFile? pickedFile = await _picker.pickImage(
      //   source: source,
      //   maxWidth: 512,
      //   maxHeight: 512,
      //   imageQuality: 80,
      // );
      //
      // if (pickedFile != null) {
      //   // Show loading indicator
      //   showDialog(
      //     context: context,
      //     barrierDismissible: false,
      //     builder: (BuildContext context) {
      //       return Center(
      //         child: CircularProgressIndicator(),
      //       );
      //     },
      //   );
      //
      //   try {
      //     final userProfileVM = context.read<UserProfileViewModel>();
      //     await userProfileVM.updateAvatar(pickedFile);
      //
      //     // Refresh user profile data immediately
      //     await getUser();
      //
      //     // Hide loading indicator
      //     Navigator.pop(context);
      //
      //     AppSnackBar.show(
      //       context,
      //       message: "Profile picture updated successfully!",
      //     );
      //   } catch (e) {
      //     // Hide loading indicator
      //     Navigator.pop(context);
      //
      //     AppSnackBar.show(
      //       context,
      //       message: "Failed to update profile picture: ${e.toString()}",
      //     );
      //   }
      // }
    } catch (e) {
      AppSnackBar.show(
        context,
        message: "Error picking image: ${e.toString()}.",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = AuthUser(); // Replace with Provider later
    // final authVM = Provider.of<AuthViewModel>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    final languageProvider = Provider.of<LanguageProvider>(context);
    //
    // if (isLogged) {
    //   return Center(child: SafeArea(child: ProfileShimmer()));
    // }
    //
    // if (userProfile == null) {
    //   return const LoggedOutScreen();
    // }

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: Row(
            children: [
              Text(
                'Profile',
                style: TextStyle(
                    fontSize: screenSize(context, .05),
                    fontWeight: FontWeight.w600),
              ),
              Spacer(),
              Stack(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.shopping_cart_outlined,
                      color: themeProvider.isDarkMode
                          ? Colors.white
                          : Colors.black,
                      size: screenSize(context, .07),
                    ),
                    onPressed: () {
                      // if (cartBooks.isNotEmpty) {
                      //   Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => const CheckoutScreen(
                      //               comeFrom: "PROFILE",
                      //             )),
                      //   );
                      // } else {
                      //   AppSnackBar.show(
                      //     context,
                      //     message:
                      //         "Your cart is empty. Please add an item to continue.",
                      //   );
                      // }
                    },
                  ),
                  Positioned(
                    right: 0,
                    child: CircleAvatar(
                        radius: 10,
                        backgroundColor: AppColors.red,
                        child: Text(
                          "0",
                          // cartBooks.length.toString(),
                          style:
                              const TextStyle(color: Colors.white, fontSize: 8),
                        )),
                  ),
                ],
              ),
              Builder(
                builder: (ctx) => GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Icon(
                      Icons.menu,
                      size: screenSize(context, .08),
                    ),
                  ),
                  onTap: () {
                    z.toggle?.call();
                    HapticFeedback.selectionClick();
                  },
                ),
              ),
              const SizedBox(width: 8),
            ],
          )),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    CircleAvatar(
                      radius: screenSize(context, 0.15),
                      backgroundColor: Colors.grey.shade200,
                      child: getAvatarWidget(
                        auth.avatarUrl ?? "",
                        auth.name ?? "",
                        auth.name ?? "",
                      ),
                    ),
                    Positioned(
                      bottom: 4,
                      right: 4,
                      child: InkWell(
                        onTap: () {
                          _showImageSourceDialog();
                        },
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 4,
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.camera_alt_outlined,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  auth.name,
                  // userProfile?.fullName ?? 'User',
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(auth.phoneNumber ?? ''),
                Text(auth.email ?? ''),
                const SizedBox(height: 16),
                IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "Gender",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Provider.of<ThemeProvider>(context)
                                          .isDarkMode
                                      ? Colors.white
                                      : Colors.black),
                            ),
                            Text(
                              "MALE",
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Provider.of<ThemeProvider>(context)
                                          .isDarkMode
                                      ? Colors.white
                                      : Colors.black),
                            ),
                          ],
                        ),
                      ),
                      VerticalDivider(
                        width: 1,
                        color: Colors.black38,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "Date of Birth",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Provider.of<ThemeProvider>(context)
                                          .isDarkMode
                                      ? Colors.white
                                      : Colors.black),
                            ),
                            Text(
                              "10 July 2000",
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Provider.of<ThemeProvider>(context)
                                        .isDarkMode
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                          onPressed: () async {
                            // final result = await Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (_) => EditProfileScreen(
                            //             userProfile: userProfile!)));
                            //
                            // // Refresh profile data if edit was successful
                            // if (result == true) {
                            //   await getUser();
                            // }
                          },
                          child: Text(
                            "Edit Profile",
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.black26,
                            side: const BorderSide(
                              // border style
                              color: Colors.white30,
                              width: 1.5,
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => SettingsScreen(),
                              ),
                            );
                          },
                          child: Text("Settings")),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.shopping_basket_outlined),
                  title: Text("My Orders"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MedicineOrderScreen(),
                      ),
                    );
                    // Handle purchased books action
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.question_answer_outlined),
                  title: Text("FAQ"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => FaqScreen(),
                      ),
                    );
                    // Handle promo action
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.rule_outlined),
                  title: Text("Return & Refund Policy"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => RefundScreen(),
                      ),
                    );
                    // Handle promo action
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String formatDate(String? date) {
    if (date == null || date.isEmpty) return "N/A";
    try {
      final parsedDate = DateTime.parse(date); // e.g., "2024-01-12"
      return DateFormat("d MMM, y").format(parsedDate); // → "12 Jan, 2024"
    } catch (e) {
      return "N/A";
    }
  }
}
