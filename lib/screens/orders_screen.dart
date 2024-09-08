import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../constants.dart'; // تأكد من استيراد القيم الثابتة والمكونات الأساسية

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: kTextColor),
      ),
      body: Padding(
        padding: const EdgeInsets.all(kDefaultPaddin),
        child: ListView.builder(
          itemCount: 5, // عدد الطلبات (يمكنك تغييرها حسب الحاجة)
          itemBuilder: (context, index) {
            return OrderCard(
              orderNumber: '#12345$index', // رقم الطلب (مثال)
              orderDate: '12 July, 2024', // تاريخ الطلب (مثال)
              orderStatus: index % 2 == 0 ? 'Delivered' : 'Pending', // حالة الطلب
              onCancel: () {
                // عند الضغط على زر الإلغاء
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Cancel Order'),
                      content: const Text('Are you sure you want to cancel this order?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('No'),
                        ),
                        TextButton(
                          onPressed: () {
                            // وضع الإلغاء هنا
                            Navigator.pop(context);
                          },
                          child: const Text('Yes'),
                        ),
                      ],
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class OrderCard extends StatelessWidget {
  final String orderNumber;
  final String orderDate;
  final String orderStatus;
  final VoidCallback onCancel;

  const OrderCard({
    super.key,
    required this.orderNumber,
    required this.orderDate,
    required this.orderStatus,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: kDefaultPaddin),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(kDefaultPaddin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order: $orderNumber',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Text(
              'Date: $orderDate',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 5),
            Text(
              'Status: $orderStatus',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: kDefaultPaddin / 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: onCancel,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Cancel Order'),
                ),
                TextButton(
                  onPressed: () {
                    // هنا يمكن وضع وظائف لرؤية تفاصيل الطلب
                  },
                  child: const Text('View Details'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
