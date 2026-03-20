import 'package:flutter/material.dart';
import 'package:jiveda_appointment/utilities/color_data.dart';
import 'package:provider/provider.dart';
import 'package:jiveda_appointment/Presentation/providers/bottom_navigation_provider.dart';
import 'package:jiveda_appointment/utilities/image_data.dart';

class BottomNavigationPage extends StatefulWidget {
  const BottomNavigationPage({super.key});

  @override
  State<BottomNavigationPage> createState() => BottomNavigationPageState();
}

class BottomNavigationPageState extends State<BottomNavigationPage> {

  @override
  Widget build(BuildContext context) {

    final navigationProvider = Provider.of<BottomNavigationProvider>(context);

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: navigationProvider.currentScreen[navigationProvider.currentIndex],
          ),
        ],
      ),
      bottomNavigationBar: Stack(
        children: [
          BottomNavigationBar(
            selectedItemColor: appColor,
            unselectedItemColor: textHintColor,
            backgroundColor: Colors.white,
            elevation: 8,
            selectedFontSize: 12,
            unselectedFontSize: 12,
            currentIndex: navigationProvider.currentIndex,
            onTap: (index) {
              navigationProvider.updateIndex(index);
            },
            items: [
              BottomNavigationBarItem(
                icon: Column(
                  children: [
                    Image.asset(
                      homeImage,
                      scale: 25,
                      color: navigationProvider.currentIndex == 0
                          ? appColor
                          : textHintColor,
                    ),
                    const SizedBox(height: 5),
                  ],
                ),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Column(
                  children: [
                    Image.asset(
                      appointmentImage,
                      scale: 25,
                      color: navigationProvider.currentIndex == 1
                          ? appColor
                          : textHintColor,
                    ),
                    const SizedBox(height: 5),
                  ],
                ),
                label: "Appointment",
              ),

              BottomNavigationBarItem(
                icon: Column(
                  children: [
                    Image.asset(
                      profileImage,
                      scale: 25,
                      color: navigationProvider.currentIndex == 2
                          ? appColor
                          : textHintColor,
                    ),
                    const SizedBox(height: 5),
                  ],
                ),
                label: "Profile",
              ),
            ],
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            top: 0,
            left:
                (navigationProvider.currentIndex *
                        MediaQuery.of(context).size.width /
                        3) +
                    (MediaQuery.of(context).size.width / 3 - 40) / 2,

            child: Container(
              height: 3,
              width: 40,
              decoration: const BoxDecoration(
                color: appColor,
                borderRadius: BorderRadius.all(Radius.circular(2)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}