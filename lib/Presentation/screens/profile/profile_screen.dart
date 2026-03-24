import 'package:extensions_pro/extensions_pro.dart';
import 'package:flutter/material.dart';
import 'package:jiveda_appointment/Presentation/providers/send_otp_provider.dart';
import 'package:jiveda_appointment/Presentation/screens/login/login_screen.dart';
import 'package:jiveda_appointment/utilities/color_data.dart';
import 'package:jiveda_appointment/utilities/image_data.dart';
import 'package:jiveda_appointment/widgets/logout_dialog.dart';
import 'package:jiveda_appointment/widgets/profile_menu_item.dart';
import 'package:jiveda_appointment/utilities/preferences.dart';
import 'package:provider/provider.dart';
import '../../../widgets/custom_text.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColor,
        elevation: 0,
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: const CustomText(
          text: "Profile",
          textColor: whiteColor,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
      backgroundColor: surfaceColor,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: appColor,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: Preferences.getUserName(),
                              textColor: whiteColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            SizedBox(height: 5),
                            CustomText(
                              text: Preferences.getEmail(),
                              textColor: lightWhiteColor,
                              fontSize: 14,
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            color: whiteColor,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.edit,
                            size: 18,
                            color: appColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const MenuItem(title: "Terms & Conditions", imagePath: termsAndConditionImage),
                  const MenuItem(title: "Privacy Policy", imagePath: privacyPolicyImage),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => LogoutDialog(
                          onYes: () async {
                            Navigator.of(context).pop();
                            await Preferences.clear();
                            final sendOtpProvider = context.read<SendOtpProvider>();
                              sendOtpProvider.mobileController.clear();
                              sendOtpProvider.notifyListeners();
                              context.push(LoginScreen());
                          },
                          onNo: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      );
                    },
                    child: const MenuItem(
                      title: "Logout",
                      imagePath: logoutImage,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            alignment: Alignment.center,
            color: surfaceColor,
            child: const CustomText(
              text: "Version: 1.1.130",
              textColor: blackColor,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}