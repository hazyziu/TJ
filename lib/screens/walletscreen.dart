import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../constants.dart'; // تأكد من استيراد القيم الثابتة والمكونات الأساسية

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Wallet"),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: kTextColor),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(kDefaultPaddin),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildWalletBalanceCard(context),
                const SizedBox(height: kDefaultPaddin),
                Text(
                  "Wallet History",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.bold, color: kTextColor),
                ),
                const SizedBox(height: kDefaultPaddin / 2),
                _buildWalletHistoryList(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWalletBalanceCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(kDefaultPaddin),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 8),
            blurRadius: 24,
            color: primaryColor.withOpacity(0.2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Your current balance",
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Colors.white, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: kDefaultPaddin / 2),
          Text(
            "\$384.90",
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: kDefaultPaddin),
          ElevatedButton(
            onPressed: () {
              // وظيفة شحن الرصيد
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(
                  vertical: 12, horizontal: kDefaultPaddin),
            ),
            child: const Text("+ Charge Balance"),
          ),
        ],
      ),
    );
  }

  Widget _buildWalletHistoryList(BuildContext context) {
    return Column(
      children: List.generate(
        4,
            (index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin / 2),
          child: _buildWalletHistoryCard(
            context,
            date: "JUN 12, 2020",
            amount: index % 2 == 0 ? 129 : 85,
            isReturn: index % 2 == 0,
            products: [
              {
                'image': 'assets/images/product1.png',
                'title': 'Mountain Warehouse for Women',
                'brandName': 'Lipsy London',
                'price': 540,
                'priceAfterDiscount': 420,
              },
              {
                'image': 'assets/images/product2.png',
                'title': 'Mountain Beta Warehouse',
                'brandName': 'Lipsy London',
                'price': 800,
              },
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWalletHistoryCard(
      BuildContext context, {
        required String date,
        required double amount,
        required bool isReturn,
        required List<Map<String, dynamic>> products,
      }) {
    return Container(
      padding: const EdgeInsets.all(kDefaultPaddin),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 8),
            blurRadius: 24,
            color: Colors.black12,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: SvgPicture.asset(
              isReturn ? "assets/icons/Return.svg" : "assets/icons/Product.svg",
              height: 24,
              width: 24,
              color: kTextColor,
            ),
            title: Text(
              isReturn ? "Return" : "Purchase",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            subtitle: Text(
              date,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            trailing: Text(
              "${isReturn ? '+' : '-'} \$${amount.toStringAsFixed(2)}",
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: isReturn ? Colors.green : Colors.redAccent),
            ),
          ),
          const Divider(),
          ...List.generate(
            products.length,
                (index) => Padding(
              padding: const EdgeInsets.only(bottom: kDefaultPaddin / 2),
              child: Row(
                children: [
                  Image.asset(
                    products[index]['image'],
                    width: 50,
                    height: 50,
                  ),
                  const SizedBox(width: kDefaultPaddin),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          products[index]['title'],
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Text(
                          products[index]['brandName'],
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(color: kTextLightColor),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "\$${products[index]['priceAfterDiscount'] ?? products[index]['price']}",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
