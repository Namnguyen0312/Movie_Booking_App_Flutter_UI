import 'package:flutter/material.dart';
import 'package:movie_ticker_app_flutter/provider/user_provider.dart';
import 'package:movie_ticker_app_flutter/screens/resetpassword/verify_otp_page.dart';
import 'package:movie_ticker_app_flutter/utils/animate_left_curve.dart';
import 'package:provider/provider.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({super.key});

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  final TextEditingController _emailController = TextEditingController();
  Future<void>? _verifyEmailFuture;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Column(
              textDirection: TextDirection.ltr,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Xác thực email',
                  style: TextStyle(
                    color: Color(0xFF755DC1),
                    fontSize: 27,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: _emailController,
                  style: const TextStyle(
                    color: Color(0xFF393939),
                    fontSize: 13,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(
                      color: Color(0xFF755DC1),
                      fontSize: 15,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(
                        width: 1,
                        color: Color(0xFF837E93),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(
                        width: 1,
                        color: Color(0xFF9F7BFF),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                FutureBuilder<void>(
                  future: _verifyEmailFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(307, 56),
                          backgroundColor: const Color(0xFF755DC1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            _verifyEmailFuture = _verifyEmail();
                          });
                        },
                        child: const Text(
                          'Gửi OTP',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _verifyEmail() async {
    final email = _emailController.text;

    if (email.isNotEmpty) {
      try {
        final userProvider = Provider.of<UserProvider>(context, listen: false);
        await userProvider.verifyEmail(email);
        if (!mounted) return;
        Navigator.of(context).push(
          AnimateLeftCurve.createRoute(const VerifyOtpPage()),
        );
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Không thể gửi OTP. Vui lòng thử lại sau'),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Vui lòng nhập email.'),
        ),
      );
    }
  }
}
