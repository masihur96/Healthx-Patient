import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:healthx_patient/core/constants/app_colors.dart';
import 'package:healthx_patient/features/doctor/presentation/views/doctor_screen.dart';
import 'package:healthx_patient/features/home_tab/view/home_screen.dart';
import 'package:healthx_patient/features/lab_test/presentation/views/lab_test_screen.dart';
import 'package:healthx_patient/features/medicine/presentation/views/medicine_screen.dart';
import 'package:healthx_patient/features/profile/presentation/views/profile_screen.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});
  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int pageIndex = 0;
  SharedAxisTransitionType? _transitionType =
      SharedAxisTransitionType.horizontal;
  bool _isLoggedIn = false;

  List<Widget> pageList = <Widget>[
    HomeScreen(),
    DoctorScreen(
      isForm: false,
    ),
    LabTestScreen(),
    MedicineScreen(),
    ProfileScreen(),
  ];

  void _updateTransitionType(SharedAxisTransitionType? newType) {
    setState(() {
      _transitionType = newType;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Mobile View
        return _mobileView();
      },
    );
  }

  Widget _mobileView() {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: PageTransitionSwitcher(
            reverse: _isLoggedIn,
            transitionBuilder: (
              Widget child,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
            ) {
              return SharedAxisTransition(
                animation: animation,
                secondaryAnimation: secondaryAnimation,
                transitionType: _transitionType!,
                child: child,
              );
            },
            child: pageList[pageIndex],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: pageIndex,
        selectedItemColor: AppColors.buttonColor,
        unselectedItemColor: AppColors.black,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Doctors',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box_outlined),
            label: 'Lab Tests',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long),
            label: 'Medicine',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  void _onItemTapped(int index) {
    if (pageIndex > index) {
      setState(() {
        _isLoggedIn = false;
      });
    } else {
      setState(() {
        _isLoggedIn = true;
      });
    }
    setState(() {
      pageIndex = index;
    });
  }
}
