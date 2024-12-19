
import 'package:buildittt/providers/authProvider/singupProvider.dart';
import 'package:buildittt/screens/signup/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
        double screenHeight = MediaQuery.of(context).size.height;
    // double screenWidth = MediaQuery.of(context).size.width;
    final signupProvider = Provider.of<SignupProvider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              SizedBox(height: screenHeight*0.05,),
            Container(
                height: screenHeight * 0.19,
                child: Image.asset('assets/images/appLogo.png')),
            const SizedBox(height: 40),

            const Text(
              "Sign Up to BarCode Scanner",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),

            // Username Input
            TextField(
              controller: signupProvider.usernameController,
              decoration: InputDecoration(
                
                labelText: 'Username',
                prefixIcon: const Icon(Icons.person),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              style: const TextStyle(
    color: Colors.black, // Sets the text color to black
  ),
            ),
            const SizedBox(height: 20),

            // Email Input
            TextField(
              controller: signupProvider.emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                prefixIcon: const Icon(Icons.email),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              style: const TextStyle(
    color: Colors.black, // Sets the text color to black 
  ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 20),

            // Password Input
            TextField(
              controller: signupProvider.passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: const Icon(Icons.lock),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              style: const TextStyle(
    color: Colors.black, // Sets the text color to black
  ),
              obscureText: true,
            ),
            const SizedBox(height: 30),

            // Signup Button
            Center(
              child: ElevatedButton(
                
                onPressed: signupProvider.isLoading
                    ? null // Disable button while loading
                    : () async {
                        final success = await signupProvider.signup();
                        if (success) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Signup successful!")),
                          );
                          Navigator.pushReplacementNamed(context, '/login');
                        } else {
                          _showErrorDialog(context,
                              signupProvider.errorMessage ?? "Signup failed.");
                        }
                      },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                child: signupProvider.isLoading
                    ? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                      )
                    : Container(
                      width: double.infinity,
                      child: Center(child: const Text("Sign Up" , style: TextStyle( fontWeight: FontWeight.bold,color: Colors.black),))),
              ),
            ),
            const SizedBox(height: 20),

            // Login Redirect
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account? "),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                  child: const Text("Login"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
