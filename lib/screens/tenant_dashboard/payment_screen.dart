import 'package:flutter/material.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Payment")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(decoration: InputDecoration(labelText: 'Card Number')),
            TextFormField(decoration: InputDecoration(labelText: 'Expiry Date')),
            TextFormField(decoration: InputDecoration(labelText: 'CVV')),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/notifications');
              },
              child: Text('Pay UGX 600,000'),
            )
          ],
        ),
      ),

    );
  }
}
