import 'package:bicycle_rent/core/view_models/login_view_model.dart';
import 'package:bicycle_rent/ui/widgets/custom_button.dart';
import 'package:bicycle_rent/ui/widgets/custom_input.dart';
import 'package:bicycle_rent/ui/widgets/custom_text.dart';
import 'package:bicycle_rent/ui/widgets/wave_widget%20.dart';
import 'package:bicycle_rent/utils/constance.dart';

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final LoginViewModel controller = Get.find(tag: 'login_view_model');
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          Container(
            height: size.height - 200,
            color: loginColors[0],
          ),
          Obx(
            () => AnimatedPositioned(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeOutQuad,
              top: controller.keyboardOpen.value ? -size.height / 3.7 : 0.0,
              child: WaveWidget(
                size: size,
                yOffset: size.height / 3.0,
                color: Colors.white,
              ),
            ),
          ),
          Obx(() =>
              controller.isLoginForm ? loginFormWidget() : signUpFormWidget())
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    KeyboardVisibilityController().onChange.listen((isVisible) {
      controller.keyboardOpen.value = isVisible;
    });
  }

  Widget loginFormWidget() {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 100.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              Text(
                'Login',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40.0,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomInput(
                text: 'Email',
                hint: 'Enter Your Email',
                type: TextInputType.emailAddress,
                onChange: (input) {
                  controller.email = input;
                },
                suffixIcon: null,
              ),
              const SizedBox(
                height: 10.0,
              ),
              Obx(
                () => CustomInput(
                  text: 'Password',
                  hint: 'Enter Your Password',
                  type: TextInputType.visiblePassword,
                  obscureText: controller.visibilityIcon.value,
                  icon: Icons.lock,
                  onChange: (input) {
                    controller.password = input;
                  },
                  suffixIcon: controller.visibilityIcon.value
                      ? Icons.visibility_off
                      : Icons.visibility,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              CustomButton(
                text: 'LOGIN',
                onPressed: () => controller.login(),
              ),
              const SizedBox(
                height: 10.0,
              ),
              CustomButton(
                text: 'SIGN UP',
                onPressed: () => controller.changeForm(),
                hasBorder: true,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Obx(() {
                  switch (controller.loading) {
                    case 1:
                      return SizedBox(
                        width: 25,
                        height: 25,
                        child: CircularProgressIndicator(
                          color: loginColors[0],
                        ),
                      );
                    default:
                      return Container();
                  }
                }),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget signUpFormWidget() {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 100.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              Text(
                'Sign Up',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40.0,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomInput(
                text: 'Email',
                hint: 'Enter Your Email',
                type: TextInputType.emailAddress,
                onChange: (input) {
                  controller.email = input;
                },
                suffixIcon: null,
              ),
              const SizedBox(
                height: 10.0,
              ),
              Obx(
                () => CustomInput(
                  text: 'Password',
                  hint: 'Enter Your Password',
                  type: TextInputType.visiblePassword,
                  obscureText: controller.visibilityIcon.value,
                  icon: Icons.lock,
                  onChange: (input) {
                    controller.password = input;
                  },
                  suffixIcon: controller.visibilityIcon.value
                      ? Icons.visibility_off
                      : Icons.visibility,
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              CustomInput(
                text: 'National ID',
                hint: 'Enter Your National ID',
                type: TextInputType.number,
                onChange: (input) {
                  controller.nationalId = input;
                },
                suffixIcon: null,
              ),
              const SizedBox(
                height: 20.0,
              ),
              CustomButton(
                text: 'SIGN UP',
                onPressed: () => controller.signUp(),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Obx(
                () => controller.keyboardOpen.value
                    ? Container()
                    : CustomButton(
                        text: 'BACK TO LOGIN',
                        onPressed: () => controller.changeForm(),
                        hasBorder: true,
                      ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Obx(() {
                  switch (controller.loading) {
                    case 1:
                      return SizedBox(
                        width: 25,
                        height: 25,
                        child: CircularProgressIndicator(
                          color: loginColors[0],
                        ),
                      );
                    default:
                      return Container();
                  }
                }),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
