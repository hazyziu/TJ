// lib/screens/cartscreen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../constants.dart';
import '../../models/cart_item.dart';
import '../../models/cart_model.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartProvider);
    final totalPrice = ref.read(cartProvider.notifier).totalPrice;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: kTextColor),
      ),
      body: Padding(
        padding: const EdgeInsets.all(kDefaultPaddin),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  return _buildCartItem(context, cartItems[index], ref);
                },
              ),
            ),
            const SizedBox(height: kDefaultPaddin),
            _buildCartSummary(context, totalPrice),
            const SizedBox(height: kDefaultPaddin),
            _buildCartButtons(context),
          ],
        ),
      ),
    );
  }

  Widget _buildCartSummary(BuildContext context, double totalPrice) {
    return Column(
      children: [
        Text(
          "Total: \$${totalPrice.toStringAsFixed(2)}",
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildCartButtons(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            // وظيفة إتمام الشراء
          },
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 48),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            backgroundColor: Colors.green,
          ),
          child: const Text(
            "Checkout",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: kDefaultPaddin / 2),
        OutlinedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: OutlinedButton.styleFrom(
            minimumSize: const Size(double.infinity, 48),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
          ),
          child: const Text("Continue shopping"),
        ),
      ],
    );
  }

  Widget _buildCartItem(BuildContext context, CartItem cartItem, WidgetRef ref) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: kDefaultPaddin / 2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(kDefaultPaddin),
        child: Row(
          children: [
            Image.asset(
              cartItem.product.image,
              width: 80,
              height: 80,
            ),
            const SizedBox(width: kDefaultPaddin),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cartItem.product.title,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "\$${cartItem.product.price.toStringAsFixed(2)}",
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () {
                    ref.read(cartProvider.notifier).decrementItem(cartItem);
                  },
                ),
                Text(
                  cartItem.quantity.toString(),
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    ref.read(cartProvider.notifier).incrementItem(cartItem);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
