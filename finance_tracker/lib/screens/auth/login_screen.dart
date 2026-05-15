import 'package:finance_tracker/screens/Dashboard/dashboard.dart';
import 'package:finance_tracker/screens/auth/register_screen.dart';
import 'package:finance_tracker/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();
  bool isObscure = true;
  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            child: SizedBox(
              height: size.height * 0.9,
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    const Spacer(),
                    Text(
                      "Welcome Amigo! 🤵",
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    const Spacer(),
                    const SizedBox(height: 10),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your email";
                        }
                        if (!value.contains("@")) {
                          return "Please enter a valid email";
                        }

                        return null;
                      },
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: "Enter Your Email",
                        labelText: "Email",
                        prefixIcon: Icon(Icons.email_outlined),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your password";
                        }
                        if (value.length < 6) {
                          return "Password must be at least 6 characters";
                        }

                        return null;
                      },
                      controller: passwordController,
                      obscureText: isObscure,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isObscure = !isObscure;
                            });
                          },
                          icon: Icon(
                            isObscure ? Icons.visibility_off : Icons.visibility,
                          ),
                        ),
                        hintText: "Enter Your Password",
                        labelText: "Password",
                        prefixIcon: Icon(Icons.lock_outline),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          authService
                              .login(
                                email: emailController.text,
                                password: passwordController.text,
                              )
                              .then((response) async {
                                final prefs =
                                    await SharedPreferences.getInstance();
                                await prefs.setString(
                                  "email",
                                  emailController.text,
                                );
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Dashboard(),
                                  ),
                                );
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Login successful!")),
                                );
                              })
                              .catchError((error) {
                                print(error);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Login failed!")),
                                );
                              });
                        }
                      },
                      child: const Text("Login"),
                    ),
                    const SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Why are you late 🔪",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const RegisterScreen(),
                              ),
                            );
                          },
                          child: const Text("Register Now!"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
