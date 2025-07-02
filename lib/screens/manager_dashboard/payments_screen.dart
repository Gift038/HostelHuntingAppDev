import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PaymentsScreen extends StatefulWidget {
  const PaymentsScreen({super.key});

  @override
  State<PaymentsScreen> createState() => _PaymentsScreenState();
}

class _PaymentsScreenState extends State<PaymentsScreen> {
  String selectedStatus = 'All';
  DateTimeRange? dateRange;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payments'),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('payments')
            .orderBy('date', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No payments found.'));
          }

          final allDocs = snapshot.data!.docs;
          final allPayments = allDocs.map((doc) {
            final data = doc.data() as Map<String, dynamic>?;
            if (data == null) return null;
            return {
              'id': doc.id,
              'resident': data['resident'] ?? 'Unknown',
              'room': data['room'] ?? 'Unknown',
              'status': (data['status'] ?? 'unknown').toString().toLowerCase(),
              'amount': data['amount'] is num ? data['amount'] : 0,
              'date': data['date'],
            };
          }).where((p) => p != null).cast<Map<String, dynamic>>().toList();

          final filtered = allPayments.where((p) {
            final statusMatch = selectedStatus == 'All' ||
                (p['status']?.toString().toLowerCase() == selectedStatus.toLowerCase());
            DateTime? date;
            if (p['date'] is Timestamp) {
              date = (p['date'] as Timestamp).toDate();
            } else if (p['date'] is DateTime) {
              date = p['date'] as DateTime;
            }
            final dateMatch = dateRange == null ||
                (date != null &&
                    date.isAfter(dateRange!.start.subtract(const Duration(days: 1))) &&
                    date.isBefore(dateRange!.end.add(const Duration(days: 1))));
            return statusMatch && dateMatch;
          }).toList();

          final receivedTotal = allPayments
              .where((p) => p['status'] == 'received')
              .fold(0, (sum, p) => sum + ((p['amount'] is num) ? (p['amount'] as num).toInt() : 0));
          final dueTotal = allPayments
              .where((p) => p['status'] == 'due')
              .fold(0, (sum, p) => sum + ((p['amount'] is num) ? (p['amount'] as num).toInt() : 0));

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(children: [
                  _SummaryCard(
                      title: 'Total Payments\nReceived',
                      amount: '\$24$receivedTotal'),
                  const SizedBox(width: 12),
                  _SummaryCard(
                      title: 'Outstanding\nBalance', amount: '\$24$dueTotal'),
                ]),
                const SizedBox(height: 12),
                Row(
                  children: [
                    DropdownButton<String>(
                      value: selectedStatus,
                      items: ['All', 'Received', 'Due']
                          .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                          .toList(),
                      onChanged: (v) => setState(() => selectedStatus = v!),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                        onPressed: () async {
                          final picked = await showDateRangePicker(
                            context: context,
                            firstDate: DateTime(2020),
                            lastDate: DateTime(2100),
                          );
                          if (picked != null) {
                            setState(() => dateRange = picked);
                          }
                        },
                        child: const Text('Pick Dates')),
                    if (dateRange != null)
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: OutlinedButton(
                          onPressed: () {}, // => setState(() => dateRange = null),
                          child: const Text('Clear Dates'),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: filtered.isEmpty
                      ? const Center(child: Text('No payments match the filter.'))
                      : ListView.builder(
                          itemCount: filtered.length,
                          itemBuilder: (context, i) {
                            final p = filtered[i];
                            DateTime? date;
                            if (p['date'] is Timestamp) {
                              date = (p['date'] as Timestamp).toDate();
                            } else if (p['date'] is DateTime) {
                              date = p['date'] as DateTime;
                            }
                            return Card(
                              child: ListTile(
                                leading: Icon(
                                    p['status'] == 'received'
                                        ? Icons.attach_money
                                        : Icons.bed,
                                    color: p['status'] == 'received'
                                        ? Colors.green
                                        : Colors.black),
                                title: Text('${p['resident']} - ${p['room']}'),
                                subtitle: Text('${p['status']?.toString().toUpperCase()}'),
                                trailing: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                        '\$24${p['amount']}',
                                        style: const TextStyle(fontWeight: FontWeight.bold)),
                                    //Text(
                                    //    date != null
                                    //        ? DateFormat.yMd().format(date)
                                    //        : 'No date',
                                    //    style: const TextStyle(fontSize: 12)),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String title;
  final String amount;

  const _SummaryCard({required this.title, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        color: Colors.grey[100],
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(fontSize: 14, color: Colors.black54)),
              const SizedBox(height: 8),
              Text(amount,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}