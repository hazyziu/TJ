// lib/models/cart_model.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'cart_item.dart';
import 'product.dart';

class CartNotifier extends StateNotifier<List<CartItem>> {
  CartNotifier() : super([]);

  double get totalPrice => state.fold(
    0,
        (total, item) => total + (item.product.price * item.quantity),
  );

  void addItem(Product product, int quantity) {
    if (quantity <= 0) return;

    final existingIndex =
    state.indexWhere((item) => item.product.id == product.id);
    if (existingIndex >= 0) {
      state = [
        for (int i = 0; i < state.length; i++)
          if (i == existingIndex)
            CartItem(
              product: state[i].product,
              quantity: state[i].quantity + quantity,
            )
          else
            state[i]
      ];
    } else {
      state = [...state, CartItem(product: product, quantity: quantity)];
    }
  }

  void removeItem(Product product) {
    state = state.where((item) => item.product.id != product.id).toList();
  }

  void incrementItem(CartItem item) {
    addItem(item.product, 1);
  }

  void decrementItem(CartItem item) {
    final existingIndex =
    state.indexWhere((cartItem) => cartItem.product.id == item.product.id);
    if (existingIndex >= 0 && state[existingIndex].quantity > 1) {
      state = [
        for (int i = 0; i < state.length; i++)
          if (i == existingIndex)
            CartItem(
              product: state[i].product,
              quantity: state[i].quantity - 1,
            )
          else
            state[i]
      ];
    } else {
      removeItem(item.product);
    }
  }
}

final cartProvider = StateNotifierProvider<CartNotifier, List<CartItem>>(
      (ref) => CartNotifier(),
);
