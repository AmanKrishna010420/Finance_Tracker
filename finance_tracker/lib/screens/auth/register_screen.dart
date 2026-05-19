import 'package:finance_tracker/providers/auth_provider.dart';
import 'package:finance_tracker/screens/Dashboard/dashboard.dart';
import 'package:finance_tracker/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();
  final banksController = TextEditingController();
  final balanceController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
    banksController.dispose();
    balanceController.dispose();
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
                    const SizedBox(height: 105),
                    Text(
                      "Welcome New Amigo 👲",
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Please enter your First name"),
                            ),
                          );
                          return "Enter Your First Name";
                        }
                        return null;
                      },
                      controller: firstNameController,
                      decoration: InputDecoration(
                        hintText: "Enter Your First Name",
                        label: const Text("First Name"),
                        prefixIcon: const Icon(Icons.person),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Please enter your last name"),
                            ),
                          );
                          return "Enter Last name";
                        }
                        return null;
                      },
                      controller: lastNameController,
                      decoration: InputDecoration(
                        hintText: "Enter Your Last Name",
                        label: const Text("Last Name"),
                        prefixIcon: const Icon(Icons.person),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Please enter your email Id"),
                            ),
                          );
                          return "Enter Email Id";
                        }
                        return null;
                      },
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: "Enter Your Email Id",
                        label: const Text("Email Id"),
                        prefixIcon: const Icon(Icons.email_outlined),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Please enter your password"),
                            ),
                          );
                          if ((value as String).length < 6) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  "Password must be at least 6 characters",
                                ),
                              ),
                            );
                          }
                          return "Enter your password";
                        }
                        return null;
                      },
                      controller: passwordController,
                      decoration: InputDecoration(
                        hintText: "Enter Your Password",
                        label: const Text("Password"),
                        prefixIcon: const Icon(Icons.lock_outlined),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Please enter your username"),
                            ),
                          );
                        }
                        return "Enter Your Username";
                      },
                      controller: usernameController,
                      decoration: InputDecoration(
                        hintText: "Enter Your Username",
                        label: const Text("Username"),
                        prefixIcon: const Icon(Icons.person_outline),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Please enter your banks"),
                            ),
                          );
                        }
                        return "Enter your banks";
                      },
                      controller: banksController,
                      decoration: InputDecoration(
                        hintText: "List of Banks you use (comma separated)",
                        label: const Text("Banks"),
                        prefixIcon: const Icon(Icons.account_balance_outlined),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                "You are not broke, you just need to add your income!",
                              ),
                            ),
                          );
                        }
                        return "Add Income";
                      },
                      controller: balanceController,
                      decoration: InputDecoration(
                        hintText: "Bank Balance",
                        label: const Text("Bank Balance"),
                        prefixIcon: const Icon(Icons.monetization_on_outlined),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () async {
                        try {
                          if (!formKey.currentState!.validate()) {
                            return;
                          }
                          final authProvider = Provider.of<AuthProvider>(
                            context,
                            listen: false,
                          );
                          final success = authProvider.register(
                            firstName: firstNameController.text.trim(),
                            lastName: lastNameController.text.trim(),
                            email: emailController.text.trim(),
                            password: passwordController.text.trim(),
                            username: usernameController.text.trim(),
                            banks: banksController.text.trim(),
                            balance: int.parse(balanceController.text.trim()),
                          );
                          if (await success) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (_) => Dashboard()),
                            );
                          }
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Registration failed!"),
                            ),
                          );
                        }
                      },
                      child: const Text("Register"),
                    ),

                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Already have an account? Login"),
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
