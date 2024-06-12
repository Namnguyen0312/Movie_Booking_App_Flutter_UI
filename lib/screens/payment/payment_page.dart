import 'package:flutter/material.dart';
import 'package:movie_ticker_app_flutter/provider/ticket_provider.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  late WebViewController controller;
  late VNPayProvider ticketProvider;

  @override
  void initState() {
    super.initState();
    ticketProvider = Provider.of<VNPayProvider>(context, listen: false);
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.disabled)
      ..loadRequest(Uri.parse(ticketProvider.url!));
  }

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(
      controller: controller,
    );
  }
}
