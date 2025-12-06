import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:healthx_patient/configs/custom_size.dart';
import 'package:healthx_patient/features/auth/data/models/auth_user.dart';
import 'package:healthx_patient/features/home_tab/drawer_screen.dart';
import 'package:healthx_patient/shared/app_snackbar.dart';
import 'package:healthx_patient/shared/avater_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final auth = AuthUser(); // Replace with Provider later

    return Scaffold(
      // KEEPING YOUR OLD APPBAR
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _customAppBar(auth),
            // _welcomeHeader(auth),
            const SizedBox(height: 12),
            _promoBanner(),
            const SizedBox(height: 22),
            _sectionTitle("Overview"),
            const SizedBox(height: 12),
            _quickAccessGrid(),
            const SizedBox(height: 22),
            _sectionTitle("Upcoming Appointment"),
            const SizedBox(height: 12),
            _appointmentCard(),
            const SizedBox(height: 22),
            _sectionTitle("Health Insights"),
            const SizedBox(height: 12),
            _insightCards(),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  //──────────────────────────────────────────
  // A. WELCOME HEADER – Premium Style
  //──────────────────────────────────────────
  Widget _welcomeHeader(AuthUser user) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: _boxStyle(),
      child: Row(
        children: [
          CircleAvatar(
            radius: 32,
            backgroundColor: Colors.blue.shade50,
            child: (user.avatarUrl == null)
                ? const Icon(Icons.person, size: 40, color: Colors.blue)
                : getAvatarWidget(user.avatarUrl, user.name, user.name),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hello,",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
                Text(
                  user.name ?? "User",
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "We wish you a healthy day 💙",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //──────────────────────────────────────────
  // B. QUICK ACCESS GRID – More Premium
  //──────────────────────────────────────────
  Widget _quickAccessGrid() {
    List<Map<String, dynamic>> services = [
      {"title": "Doctor", "icon": Icons.medical_services_outlined},
      {"title": "Lab Test", "icon": Icons.biotech_outlined},
      {"title": "Medicine", "icon": Icons.local_pharmacy_outlined},
      {"title": "Health Plans", "icon": Icons.health_and_safety_outlined},
      {"title": "Appointments", "icon": Icons.calendar_month_outlined},
    ];

    return GridView.builder(
      padding: EdgeInsets.zero,
      itemCount: services.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisExtent: 115,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemBuilder: (_, i) {
        final item = services[i];

        return GestureDetector(
          onTap: () {
            AppSnackBar.show(context, message: "${item["title"]} coming soon!");
          },
          child: Container(
            // padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
            decoration: _boxStyle(radius: 18),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(item["icon"], size: 38, color: Colors.blue.shade700),
                const SizedBox(height: 12),
                Text(
                  item["title"],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: Colors.grey.shade800,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  //──────────────────────────────────────────
  // C. UPCOMING APPOINTMENT – Premium Card
  //──────────────────────────────────────────
  Widget _appointmentCard() {
    bool hasAppointment = true; // Replace later with API

    if (!hasAppointment) {
      return Container(
        padding: const EdgeInsets.all(20),
        decoration: _boxStyle(),
        child: Column(
          children: [
            const Text(
              "No appointments scheduled",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {},
              child: const Text("Book Appointment"),
            )
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: _boxStyle(),
      child: Row(
        children: [
          Container(
            width: 62,
            height: 62,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue.shade50,
              image: const DecorationImage(
                  image: AssetImage("assets/images/onboarding_preview1.png"),
                  fit: BoxFit.cover),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Dr. Jonathan Smith",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                const SizedBox(height: 3),
                Text("Cardiologist",
                    style: TextStyle(color: Colors.grey.shade600)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.calendar_today,
                        size: 16, color: Colors.blue.shade700),
                    const SizedBox(width: 6),
                    const Text("Mon, 12 Dec"),
                    const SizedBox(width: 16),
                    Icon(Icons.access_time,
                        size: 16, color: Colors.blue.shade700),
                    const SizedBox(width: 6),
                    const Text("10:30 AM"),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //──────────────────────────────────────────
  // D. HEALTH INSIGHTS – More Premium
  //──────────────────────────────────────────
  Widget _insightCards() {
    List<Map<String, String>> data = [
      {"title": "Completed Tests", "value": "03"},
      {"title": "Active Medicines", "value": "02"},
      {"title": "Pending Reports", "value": "01"},
    ];

    return Container(
      decoration: _boxStyle(),
      child: Column(
        children: data.map((item) {
          return Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(item["title"]!,
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500)),
                    Text(item["value"]!,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.blue.shade700,
                        )),
                  ],
                ),
              ),
              if (item != data.last)
                Divider(height: 1, color: Colors.grey.shade300),
            ],
          );
        }).toList(),
      ),
    );
  }

  //──────────────────────────────────────────
  // E. PROMO BANNER – Clean Modern
  //──────────────────────────────────────────
  Widget _promoBanner() {
    return Container(
      height: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        image: const DecorationImage(
          image: AssetImage("assets/images/promo_banner.png"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  //──────────────────────────────────────────
  // REUSABLE STYLES
  //──────────────────────────────────────────
  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
    );
  }

  BoxDecoration _boxStyle({double radius = 20}) {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(radius),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 8,
          offset: const Offset(0, 3),
        ),
      ],
    );
  }

  // KEEPING YOUR ORIGINAL APPBAR
  Widget _customAppBar(AuthUser authVM) {
    // if (authVM.error != null) {
    //   return Text("${authVM.error}");
    // }
    // if (authVM.profileModel == null) {
    //   return Text("No Data Found");
    // }
    // if (authVM.profileModel?.doctorInfo == null) {
    //   return Text("No Doctor info Found");
    // }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: Colors.white,
            child: authVM.avatarUrl.isEmpty
                ? Icon(
                    Icons.person,
                    size: 40,
                    color: Color(0xFF2196F3),
                  )
                : getAvatarWidget(authVM.avatarUrl, authVM.name, authVM.name),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Welcome Back",
                  style: TextStyle(fontSize: 14, color: Colors.grey)),
              Text("${authVM.name} ${authVM.name}",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
          const Spacer(),
          IconButton(
            onPressed: () {
              // Navigator.push(
              //     context, MaterialPageRoute(builder: (_) => SearchScreen()));
            },
            icon: Icon(Icons.search_outlined, size: 28),
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
        ],
      ),
    );
  }
}
