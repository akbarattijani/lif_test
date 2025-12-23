import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../components/edit_field.dart';
import '../const/app_colors.dart';
import '../controllers/authentication_controller.dart';

class LoginActivity extends StatelessWidget {
    final TextEditingController emailCtrl = TextEditingController();
    final TextEditingController passCtrl = TextEditingController();
    final AuthController authController = Get.find<AuthController>();

    LoginActivity({super.key});

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            backgroundColor: kPrimaryYellow,
            body: Center(
                child: SingleChildScrollView(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                            const Icon(Icons.check_circle_outline, size: 80, color: Colors.white),
                            const SizedBox(height: 20),
                            const Text(
                                "Welcome Back!",
                                style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                            ),
                            const SizedBox(height: 40),
                            Container(
                                margin: const EdgeInsets.symmetric(horizontal: 24),
                                padding: const EdgeInsets.all(24),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(24),
                                    boxShadow: [
                                        BoxShadow(
                                            color: Colors.black.withOpacity(0.1),
                                            blurRadius: 10,
                                            offset: const Offset(0, 5))
                                    ],
                                ),
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                        const SizedBox(height: 30),
                                        EditField(
                                            controller: emailCtrl,
                                            label: "Email Address",
                                            hint: "Enter your email",
                                            icon: Icons.email_outlined,
                                            keyboardType: TextInputType.emailAddress,
                                            isPassword: false,
                                        ),
                                        const SizedBox(height: 20),
                                        EditField(
                                            controller: passCtrl,
                                            label: "Password",
                                            hint: "Enter your password",
                                            icon: Icons.lock_outline,
                                            isPassword: true,
                                        ),
                                        const SizedBox(height: 30),
                                        SizedBox(
                                            width: double.infinity,
                                            height: 50,
                                            child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor: const Color(0xFFFFC107),
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(12),
                                                    ),
                                                ),
                                                onPressed: () {
                                                    authController.login(emailCtrl.text.trim(), passCtrl.text.trim());
                                                },
                                                child: const Text(
                                                    "Login",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.bold),
                                                ),
                                            ),
                                        ),
                                    ],
                                ),
                            ),
                        ],
                    ),
                ),
            ),
        );
    }
}