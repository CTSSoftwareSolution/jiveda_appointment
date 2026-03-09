import 'package:flutter/material.dart';
import 'package:jiveda_appointment/providers/send_otp_provider.dart';
import 'package:jiveda_appointment/utilities/color_data.dart';
import 'package:jiveda_appointment/utilities/extension.dart';
import 'package:jiveda_appointment/utilities/input_formatters.dart';
import 'package:jiveda_appointment/widgets/custom_image.dart';
import 'package:jiveda_appointment/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

import '../../utilities/image_data.dart';
import '../../utilities/validators.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController mobileController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final Color scaffoldBgColor = Theme.of(context).scaffoldBackgroundColor;
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      60.height,
                      Center(
                        child: CustomImage(image: appLogo,scale: 20,)
                      ),
                      60.height,
                      CustomText(
                        text: "Mobile Number",
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        fontFamily: "",
                        overflow: TextOverflow.ellipsis,
                      ),
                      10.height,
                      CustomTextField(
                        contentPadding: EdgeInsets.symmetric(horizontal: 7.0),
                        fillColor: scaffoldBgColor,
                        inputFormatters: InputFormatters.mobileNumber,
                        validator: (value) => Validators.mobileValidation(value!,context),
                        hint: "Enter your mobile number",
                          controller: mobileController,
                        hintStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: textHintColor),
                          readOnly: false,
                          keyboardType: TextInputType.number,
                        textCapitalization: TextCapitalization.none,
                      ),
                      50.height,
                      Consumer<SendOtpProvider>(
                        builder: (context, provider, child) {
                          return CustomButton(
                            height: 50,
                            width: double.infinity,
                            buttonText: "Send OTP",
                            onPress: () async{
                              if(formKey.currentState!.validate()){}
                            },
                            backgroundColor: appColor,
                            foregroundColor: whiteColor,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          );
                        },
                      ),
                    ],
                  ),
                ),
                10.height,

              ],
            ),
          ),
        ),
      ),
    );
  }
}
