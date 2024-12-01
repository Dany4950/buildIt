


import 'package:buildittt/providers/authProvider/loginScreenProvider.dart';
import 'package:buildittt/screens/signup/signIn.dart';
import 'package:buildittt/widgets/bottomNavBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginScreenProvider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            const Center(
              child: Text(
                "Login to Your Account",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 40),
            // Email input field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                controller: loginProvider.emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Password input field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                controller: loginProvider.passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Login button
            ElevatedButton(
              onPressed: loginProvider.isLoading
                  ? null
                  : () async {
                      final success = await loginProvider.onLoginTap();
                      if (success) {
                        Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MainNavigationScreenn()));
                      } else {
                        // Show error if login fails
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(loginProvider.errorMessage ?? 'Login failed.'),
                          ),
                        );
                      }
                    },
              child: loginProvider.isLoading
                  ? const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    )
                  : const Text('Login'),
            ),
            const SizedBox(height: 20),
            // Error message display
            if (loginProvider.errorMessage != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  loginProvider.errorMessage!,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
              Row(
              children: [
                SizedBox(width: 100),
                Text("dont have Account ? "),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SignupScreen()));
                  },
                  child:  const Text(
                    "Singup",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
