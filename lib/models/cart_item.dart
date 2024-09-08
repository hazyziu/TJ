// lib/models/cart_item.dart

import 'product.dart'; // استيراد نموذج المنتج

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});

  // دالة لزيادة الكمية
  void incrementQuantity() {
    quantity++;
  }

  // دالة لتقليل الكمية
  void decrementQuantity() {
    if (quantity > 0) {
      quantity--;
    }
  }
}
