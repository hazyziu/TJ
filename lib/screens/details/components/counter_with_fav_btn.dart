import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/product.dart';
import '../../../models/favorites_model.dart';

class CounterWithFavBtn extends ConsumerWidget {
  final int quantity;
  final VoidCallback increment;
  final VoidCallback decrement;
  final Product product; // إضافة المنتج كمعامل

  const CounterWithFavBtn({
    super.key,
    required this.quantity,
    required this.increment,
    required this.decrement,
    required this.product, // تمرير المنتج هنا
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: [
            SizedBox(
              width: 40,
              height: 32,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(13),
                  ),
                ),
                onPressed: decrement,
                child: const Icon(Icons.remove),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                quantity.toString().padLeft(2, "0"), // عرض الكمية
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            SizedBox(
              width: 40,
              height: 32,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(13),
                  ),
                ),
                onPressed: increment,
                child: const Icon(Icons.add),
              ),
            ),
          ],
        ),
        // زر القلب
        Consumer(
          builder: (context, ref, child) {
            final isFavorite = ref.watch(favoriteProvider.notifier).isFavorite(product);
            return IconButton(
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : Colors.grey,
              ),
              onPressed: () {
                if (isFavorite) {
                  ref.read(favoriteProvider.notifier).removeFavorite(product);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Removed from Wishlist")),
                  );
                } else {
                  ref.read(favoriteProvider.notifier).addFavorite(product);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Added to Wishlist")),
                  );
                }
              },
            );
          },
        ),
      ],
    );
  }
}
