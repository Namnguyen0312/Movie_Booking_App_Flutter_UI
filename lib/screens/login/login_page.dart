import 'package:flutter/material.dart';
import 'package:movie_ticker_app_flutter/common/widgets/stateful/custom_dialog.dart';
import 'package:movie_ticker_app_flutter/common/widgets/stateless/arrow_back_black.dart';
import 'package:movie_ticker_app_flutter/screens/register/register_page.dart';
import 'package:movie_ticker_app_flutter/utils/constants.dart';

import '../../common/widgets/stateless/my_button.dart';
import '../../common/widgets/stateless/my_textfield.dart';
import '../../common/widgets/stateless/square_tile.dart';

// ignore: must_be_immutable
class LoginPage extends StatefulWidget {
  static const String routeName = '/login';
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //text editing controller
  final usernameController = TextEditingController();

  final passwordController = TextEditingController();

  // sign in method
  void signUserIn() async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  void inCorrect() {
    showDialog(
        context: context,
        anchorPoint: const Offset(10, 10),
        builder: (context) {
          return const CustomDialog(message: 'Login Success');
        });
  }

  // error message show dialog
  void wrongMessage(String message) {
    showDialog(
        context: context,
        builder: (context) {
          return CustomDialog(message: message);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: ArrowBackBlack(topPadding: kTop32Padding),
            ),
            //icon
            const SizedBox(
              height: 12,
            ),
            const Icon(
              Icons.ac_unit,
              size: 100,
            ),

            //welcome
            const SizedBox(
              height: 48,
            ),
            Text(
              "Welcome to Travel App DreamTeam",
              style: TextStyle(
                  color: Colors.grey.shade700,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),

            //username
            const SizedBox(
              height: 26,
            ),
            MyTextField(
              controller: usernameController,
              hintText: "Enter your email",
              obscureText: false,
            ),

            //password
            const SizedBox(
              height: 16,
            ),
            MyTextField(
              controller: passwordController,
              hintText: "Enter your password",
              obscureText: true,
            ),

            //forgot password
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Forgot password?",
                    style: TextStyle(
                        color: Colors.blueAccent, fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            ),

            //Btn Sign In
            const SizedBox(
              height: 45,
            ),
            MyButton(
              onTap: signUserIn,
              textBtn: 'Sign In',
            ),

            //divider continue
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Divider(
                      thickness: 0.5,
                      color: Colors.grey.shade400,
                    ),
                  ),
                  Text(
                    " or continue with ",
                    style: TextStyle(color: Colors.grey.shade700),
                  ),
                  Expanded(
                    child: Divider(
                      thickness: 0.5,
                      color: Colors.grey.shade400,
                    ),
                  ),
                ],
              ),
            ),

            // google + apple sign in button
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // google
                SquareTile(
                  onTap: () {},
                  imgPath: 'assets/images/google.png',
                ),

                //Image(image: AssetImage('lib/images/apple.png'), height: 30,),
                const SizedBox(
                  width: 24,
                ),

                // apple
                SquareTile(
                  onTap: () {},
                  imgPath: "assets/images/apple.png",
                ),
              ],
            ),

            // not a member? register
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Not a member?',
                  style: TextStyle(
                    color: Colors.grey.shade700,
                  ),
                ),
                const SizedBox(
                  width: 4,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(RegisterPage.routeName);
                  },
                  child: const Text(
                    'Register',
                    style: TextStyle(
                        color: Colors.blueAccent,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold),
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
