import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:healthx_patient/configs/custom_size.dart';
// import 'package:healthx_patient/features/appointment/view/appointment_screen.dart';
import 'package:healthx_patient/features/auth/data/models/auth_user.dart';
import 'package:healthx_patient/features/auth/presentation/views/help_support_screen.dart';
import 'package:healthx_patient/features/auth/presentation/views/login_screen.dart';
import 'package:healthx_patient/features/auth/presentation/views/privacy_policy_screen.dart';
import 'package:healthx_patient/features/auth/presentation/views/terms_condition_screen.dart';
import 'package:healthx_patient/features/doctor/presentation/views/doctor_screen.dart';
import 'package:healthx_patient/features/home_tab/bottom_nav_screen.dart';
import 'package:healthx_patient/features/home_tab/doctor_setting_screen.dart';
import 'package:healthx_patient/features/medicine/presentation/views/medicine_screen.dart';
import 'package:healthx_patient/shared/avater_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

final ZoomDrawerController z = ZoomDrawerController();

class DrawerScreen extends StatefulWidget {
  final AuthUser authUser;
  static const String id = "admin_dashboard_screen";
  const DrawerScreen({super.key, required this.authUser});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen>
    with WidgetsBindingObserver {
  AuthUser? authVM;
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    fetchProfile();
    super.initState();
  }

  fetchProfile() async {
    authVM = AuthUser();
    setState(() {});
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: ZoomDrawer(
        menuScreenOverlayColor: Colors.blueAccent,
        mainScreenTapClose: true,
        controller: z,
        borderRadius: 24,
        style: DrawerStyle.defaultStyle,
        androidCloseOnBackTap: true,
        showShadow: true,
        angle: 0.0,
        drawerShadowsBackgroundColor: Colors.grey,
        slideWidth: MediaQuery.of(context).size.width * .65,
        openCurve: Curves.fastOutSlowIn,
        closeCurve: Curves.bounceIn,
        duration: const Duration(milliseconds: 500),
        menuBackgroundColor: Color(0xff7CB0F0),
        // Provider.of<ThemeProvider>(context).getIsDarkMode
        //     ? AKEColor.textColor
        //     : AKEColor.backgroundBlue,
        mainScreen: BottomNavScreen(),
        menuScreen: Theme(
          data: ThemeData.dark(),
          child: Scaffold(
              backgroundColor: Color(0xff1A73E8),

              // Provider.of<ThemeProvider>(context).getIsDarkMode
              //     ? AKEColor.textColor
              //     : AKEColor.backgroundBlue.withOpacity(.3),
              body: Padding(
                padding: const EdgeInsets.only(left: 16),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: screenSize(context, .2),
                      ),
                      CircleAvatar(
                        radius: 35,
                        backgroundColor: Colors.white,
                        child: authVM?.avatarUrl == null
                            ? Icon(
                                Icons.person,
                                size: 40,
                                color: Color(0xFF2196F3),
                              )
                            : getAvatarWidget(authVM?.avatarUrl ?? "",
                                authVM?.name ?? "", authVM?.name ?? ""),
                      ),
                      SizedBox(
                        height: screenSize(context, .05),
                      ),
                      Text(
                        authVM?.name ?? "",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Divider(
                        color: Colors.white,
                      ),
                      SizedBox(
                        height: screenSize(context, .05),
                      ),
                      menuBtn(
                        menuIcon: Icon(Icons.dashboard_outlined),
                        name: "Dashboard",
                        onTap: () {
                          HapticFeedback.selectionClick();

                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => BottomNavScreen(),
                            ),
                          );
                        },
                      ),
                      menuBtn(
                        menuIcon: const Icon(Icons.group_outlined),
                        name: "Consultation",
                        onTap: () async {
                          HapticFeedback.selectionClick();
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => DoctorScreen(
                                isForm: true,
                              ),
                            ),
                          );
                        },
                      ),
                      menuBtn(
                        menuIcon: const Icon(Icons.do_disturb_on_outlined),
                        name: "Medicine Orders",
                        onTap: () async {
                          HapticFeedback.selectionClick();
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => MedicineScreen(
                                isForm: true,
                              ),
                            ),
                          );
                        },
                      ),
                      menuBtn(
                        menuIcon: const Icon(Icons.note_alt_outlined),
                        name: "Lab Test",
                        onTap: () async {
                          // HapticFeedback.selectionClick();
                          // Navigator.of(context).push(
                          //   MaterialPageRoute(
                          //     builder: (_) => PrescriptionScreen(
                          //       isForm: true,
                          //     ),
                          //   ),
                          // );
                        },
                      ),
                      menuBtn(
                        menuIcon: const Icon(Icons.calendar_month_outlined),
                        name: "Health plan",
                        onTap: () async {
                          // HapticFeedback.selectionClick();
                          // Navigator.of(context).push(
                          //   MaterialPageRoute(
                          //     builder: (_) => AppointmentRequestScreen(),
                          //   ),
                          // );
                        },
                      ),
                      menuBtn(
                        menuIcon: const Icon(Icons.message_outlined),
                        name: "Schedule",
                        onTap: () async {
                          HapticFeedback.selectionClick();
                        },
                      ),
                      menuBtn(
                        menuIcon: const Icon(Icons.headphones),
                        name: "Help & Support",
                        onTap: () async {
                          HapticFeedback.selectionClick();
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => HelpSupportDoctorScreen(),
                            ),
                          );
                        },
                      ),
                      menuBtn(
                        menuIcon: const Icon(Icons.settings_outlined),
                        name: "Settings",
                        onTap: () async {
                          HapticFeedback.selectionClick();
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => DoctorSettingsScreen(),
                            ),
                          );
                        },
                      ),
                      Divider(
                        color: Colors.white,
                      ),
                      menuBtn(
                        menuIcon: const Icon(Icons.delete_outline_outlined),
                        name: "Privacy & Policy",
                        onTap: () async {
                          HapticFeedback.selectionClick();
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => PrivacyPolicyScreen(),
                            ),
                          );
                        },
                      ),
                      menuBtn(
                        menuIcon: const Icon(Icons.delete_outline_outlined),
                        name: "Terms & Condition",
                        onTap: () async {
                          HapticFeedback.selectionClick();
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => TermsConditionsScreen(),
                            ),
                          );
                        },
                      ),
                      SizedBox(
                        height: screenSize(context, 0.1),
                      ),
                      menuBtn(
                        menuIcon: const Icon(Icons.logout),
                        name: "Log Out",
                        onTap: () async {
                          final prefs = await SharedPreferences.getInstance();
                          prefs.clear();

                          HapticFeedback.selectionClick();
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => LoginScreen(),
                            ),
                          );
                        },
                      ),
                      SizedBox(
                        height: screenSize(context, 0.06),
                      ),
                    ],
                  ),
                ),
              )),
        ),
      ),
    );
  }

  Widget menuBtn({
    required String name,
    required Icon menuIcon,
    required Function() onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          children: [
            menuIcon,
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                name,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Colors.white,
                    fontSize: screenSize(context, .04),
                    overflow: TextOverflow.ellipsis),
                maxLines: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
