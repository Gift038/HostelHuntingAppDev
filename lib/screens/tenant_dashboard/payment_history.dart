import 'package:flutter/material.dart';

class PaymentRecord {
  final String id;
  final String method;
  final int amount;
  final String status;
  final DateTime date;
  PaymentRecord({required this.id, required this.method, required this.amount, required this.status, required this.date});
}

Future<List<PaymentRecord>> fetchPaymentHistory() async {
  // TODO: Replace with real database fetch
  await Future.delayed(const Duration(seconds: 1));
  return [
    PaymentRecord(id: '1', method: 'Mobile Money', amount: 600000, status: 'Success', date: DateTime.now().subtract(const Duration(days: 2))),
    PaymentRecord(id: '2', method: 'Card', amount: 500000, status: 'Pending', date: DateTime.now().subtract(const Duration(days: 10))),
    PaymentRecord(id: '3', method: 'Bank Transfer', amount: 700000, status: 'Failed', date: DateTime.now().subtract(const Duration(days: 20))),
  ];
}

class PaymentHistoryScreen extends StatelessWidget {
  const PaymentHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color coffeeBrown = const Color(0xFF4B2E05);
    final Color lightCoffeeBrown = const Color(0xFF9C7A5F);
    final Color tan = const Color(0xFFF8F5F2);
    return Scaffold(
      backgroundColor: tan,
      appBar: AppBar(
        backgroundColor: tan,
        elevation: 0,
        foregroundColor: coffeeBrown,
        title: const Text('Payment History', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: FutureBuilder<List<PaymentRecord>>(
        future: fetchPaymentHistory(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No payment history found.'));
          }
          final payments = snapshot.data!;
          return ListView.separated(
            padding: const EdgeInsets.all(20),
            itemCount: payments.length,
            separatorBuilder: (_, __) => const SizedBox(height: 14),
            itemBuilder: (context, i) {
              final p = payments[i];
              return Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 2,
                child: ListTile(
                  leading: Icon(
                    p.method == 'Mobile Money'
                        ? Icons.smartphone
                        : p.method == 'Card'
                            ? Icons.credit_card
                            : Icons.account_balance,
                    color: coffeeBrown,
                    size: 32,
                  ),
                  title: Text(
                    '${p.method} - UGX ${p.amount}',
                    style: TextStyle(fontWeight: FontWeight.bold, color: coffeeBrown),
                  ),
                  subtitle: Text(
                    '${p.status} • ${p.date.day}/${p.date.month}/${p.date.year}',
                    style: TextStyle(color: lightCoffeeBrown),
                  ),
                  trailing: Icon(
                    p.status == 'Success'
                        ? Icons.check_circle
                        : p.status == 'Pending'
                            ? Icons.hourglass_top
                            : Icons.cancel,
                    color: p.status == 'Success'
                        ? Colors.green
                        : p.status == 'Pending'
                            ? Colors.orange
                            : Colors.red,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
} 