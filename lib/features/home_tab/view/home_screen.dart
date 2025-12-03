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
  // Responsive padding helper
  double _getResponsivePadding(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width > 600) return 32.0;
    if (width > 400) return 20.0;
    return 16.0;
  }

  // Get responsive grid count
  int _getGridCrossAxisCount(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width > 600) return 5;
    if (width > 400) return 3;
    return 3;
  }

  @override
  Widget build(BuildContext context) {
    final auth = AuthUser();
    final horizontalPadding = _getResponsivePadding(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFB),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: _enhancedAppBar(auth),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              _promoBanner(context),
              const SizedBox(height: 32),
              _sectionTitle("Quick Access"),
              const SizedBox(height: 16),
              _quickAccessGrid(context),
              const SizedBox(height: 32),
              _sectionTitle("Upcoming Appointment"),
              const SizedBox(height: 16),
              _appointmentCard(context),
              const SizedBox(height: 32),
              _sectionTitle("Health Insights"),
              const SizedBox(height: 16),
              _insightCards(context),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  //──────────────────────────────────────────
  // ENHANCED APP BAR – Premium Gradient Style
  //──────────────────────────────────────────
  Widget _enhancedAppBar(AuthUser authVM) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF2196F3),
            const Color(0xFF1976D2),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2196F3).withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white.withOpacity(0.3), width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: CircleAvatar(
                  radius: 28,
                  backgroundColor: Colors.white,
                  child: authVM.avatarUrl.isEmpty
                      ? const Icon(
                          Icons.person,
                          size: 32,
                          color: Color(0xFF2196F3),
                        )
                      : getAvatarWidget(authVM.avatarUrl, authVM.name, authVM.name),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Welcome Back",
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.white.withOpacity(0.9),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      authVM.name.isNotEmpty ? authVM.name : "User",
                      style: const TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 0.3,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  onPressed: () {
                    // Search functionality
                  },
                  icon: const Icon(
                    Icons.search_outlined,
                    size: 26,
                    color: Colors.white,
                  ),
                  tooltip: 'Search',
                ),
              ),
              const SizedBox(width: 8),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Builder(
                  builder: (ctx) => IconButton(
                    onPressed: () {
                      z.toggle?.call();
                      HapticFeedback.lightImpact();
                    },
                    icon: const Icon(
                      Icons.menu_rounded,
                      size: 26,
                      color: Colors.white,
                    ),
                    tooltip: 'Menu',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //──────────────────────────────────────────
  // QUICK ACCESS GRID – Responsive & Premium
  //──────────────────────────────────────────
  Widget _quickAccessGrid(BuildContext context) {
    List<Map<String, dynamic>> services = [
      {
        "title": "Doctor",
        "icon": Icons.medical_services_outlined,
        "color": const Color(0xFF4CAF50),
      },
      {
        "title": "Lab Test",
        "icon": Icons.biotech_outlined,
        "color": const Color(0xFFFF9800),
      },
      {
        "title": "Medicine",
        "icon": Icons.local_pharmacy_outlined,
        "color": const Color(0xFFE91E63),
      },
      {
        "title": "Health Plans",
        "icon": Icons.health_and_safety_outlined,
        "color": const Color(0xFF9C27B0),
      },
      {
        "title": "Appointments",
        "icon": Icons.calendar_month_outlined,
        "color": const Color(0xFF2196F3),
      },
    ];

    return GridView.builder(
      itemCount: services.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: _getGridCrossAxisCount(context),
        mainAxisExtent: 120,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemBuilder: (_, i) {
        final item = services[i];

        return Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              HapticFeedback.selectionClick();
              AppSnackBar.show(context, message: "${item["title"]} coming soon!");
            },
            borderRadius: BorderRadius.circular(20),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: item["color"].withOpacity(0.15),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: item["color"].withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      item["icon"],
                      size: 32,
                      color: item["color"],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    item["title"],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                      color: Colors.grey.shade800,
                      letterSpacing: 0.2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  //──────────────────────────────────────────
  // UPCOMING APPOINTMENT – Premium Card
  //──────────────────────────────────────────
  Widget _appointmentCard(BuildContext context) {
    bool hasAppointment = true;

    if (!hasAppointment) {
      return Container(
        padding: const EdgeInsets.all(24),
        decoration: _premiumBoxStyle(),
        child: Column(
          children: [
            Icon(
              Icons.event_busy_outlined,
              size: 48,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 16),
            Text(
              "No appointments scheduled",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade700,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add),
              label: const Text("Book Appointment"),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2196F3),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            )
          ],
        ),
      );
    }

    return Container(
      decoration: _premiumBoxStyle(),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFF2196F3).withOpacity(0.3),
                        const Color(0xFF1976D2).withOpacity(0.3),
                      ],
                    ),
                    border: Border.all(
                      color: const Color(0xFF2196F3).withOpacity(0.3),
                      width: 2,
                    ),
                    image: const DecorationImage(
                      image: AssetImage("assets/images/onboarding_preview1.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Dr. Jonathan Smith",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          letterSpacing: 0.2,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            "Cardiologist",
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF4CAF50).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text(
                              "Confirmed",
                              style: TextStyle(
                                color: Color(0xFF4CAF50),
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today_outlined,
                            size: 16,
                            color: const Color(0xFF2196F3),
                          ),
                          const SizedBox(width: 6),
                          const Text(
                            "Mon, 12 Dec",
                            style: TextStyle(fontSize: 13),
                          ),
                          const SizedBox(width: 16),
                          Icon(
                            Icons.access_time_outlined,
                            size: 16,
                            color: const Color(0xFF2196F3),
                          ),
                          const SizedBox(width: 6),
                          const Text(
                            "10:30 AM",
                            style: TextStyle(fontSize: 13),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFF2196F3).withOpacity(0.05),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _appointmentAction(
                  Icons.message_outlined,
                  "Message",
                  const Color(0xFF2196F3),
                ),
                Container(
                  width: 1,
                  height: 24,
                  color: Colors.grey.shade300,
                ),
                _appointmentAction(
                  Icons.videocam_outlined,
                  "Video Call",
                  const Color(0xFF4CAF50),
                ),
                Container(
                  width: 1,
                  height: 24,
                  color: Colors.grey.shade300,
                ),
                _appointmentAction(
                  Icons.directions_outlined,
                  "Directions",
                  const Color(0xFFFF9800),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _appointmentAction(IconData icon, String label, Color color) {
    return Row(
      children: [
        Icon(icon, size: 18, color: color),
        const SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
      ],
    );
  }

  //──────────────────────────────────────────
  // HEALTH INSIGHTS – Premium Cards
  //──────────────────────────────────────────
  Widget _insightCards(BuildContext context) {
    List<Map<String, dynamic>> data = [
      {
        "title": "Completed Tests",
        "value": "03",
        "icon": Icons.check_circle_outline,
        "color": const Color(0xFF4CAF50),
      },
      {
        "title": "Active Medicines",
        "value": "02",
        "icon": Icons.medication_outlined,
        "color": const Color(0xFF2196F3),
      },
      {
        "title": "Pending Reports",
        "value": "01",
        "icon": Icons.pending_actions_outlined,
        "color": const Color(0xFFFF9800),
      },
    ];

    return Container(
      decoration: _premiumBoxStyle(),
      child: Column(
        children: data.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;
          final isLast = index == data.length - 1;

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: item["color"].withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        item["icon"],
                        size: 24,
                        color: item["color"],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        item["title"]!,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.2,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            item["color"].withOpacity(0.1),
                            item["color"].withOpacity(0.05),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        item["value"]!,
                        style: TextStyle(
                          fontSize: 20,
                          color: item["color"],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (!isLast)
                Divider(
                  height: 1,
                  thickness: 1,
                  color: Colors.grey.shade200,
                  indent: 20,
                  endIndent: 20,
                ),
            ],
          );
        }).toList(),
      ),
    );
  }

  //──────────────────────────────────────────
  // PROMO BANNER – Enhanced with Gradient Overlay
  //──────────────────────────────────────────
  Widget _promoBanner(BuildContext context) {
    return Container(
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2196F3).withOpacity(0.2),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          children: [
            // Background Image
            Positioned.fill(
              child: Image.asset(
                "assets/images/promo_banner.png",
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFF2196F3),
                          const Color(0xFF1976D2),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  );
                },
              ),
            ),
            // Gradient Overlay for better text visibility
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(0.3),
                      Colors.transparent,
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
            ),
          ],
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
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 22,
        letterSpacing: 0.3,
        color: Color(0xFF1A1A1A),
      ),
    );
  }

  BoxDecoration _premiumBoxStyle({double radius = 20}) {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(radius),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.06),
          blurRadius: 16,
          offset: const Offset(0, 4),
        ),
        BoxShadow(
          color: Colors.black.withOpacity(0.02),
          blurRadius: 6,
          offset: const Offset(0, 2),
        ),
      ],
    );
  }
}
