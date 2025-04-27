import 'dart:html' as html;
import 'package:flutter/material.dart';

class PaymentSuccessPage extends StatelessWidget {
  const PaymentSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    final uri = Uri.parse(html.window.location.href);

    final paymentId = uri.queryParameters['payment_id'];
    final amount = uri.queryParameters['amount'];

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.check_circle_outline, size: 80, color: Colors.green),
              const SizedBox(height: 16),
              const Text(
                'Payment Successful!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Text('Payment ID: $paymentId'),
              Text('Amount: ${(int.parse(amount ?? '0') / 100).toStringAsFixed(2)} сум'),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  // Вернуться на главную
                  Navigator.pushNamed(context, '/');
                },
                child: const Text('Go to Dashboard'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
