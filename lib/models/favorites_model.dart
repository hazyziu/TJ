import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'product.dart';  // تأكد من استيراد `Product` أو تعديل المسار إذا كان مختلفًا

class FavoriteModel extends StateNotifier<List<Product>> {
  FavoriteModel() : super([]);

  void addFavorite(Product product) {
    if (!state.contains(product)) {
      state = [...state, product];
    }
  }

  void removeFavorite(Product product) {
    state = state.where((p) => p.id != product.id).toList();
  }

  bool isFavorite(Product product) {
    return state.contains(product);
  }
}

final favoriteProvider = StateNotifierProvider<FavoriteModel, List<Product>>((ref) {
  return FavoriteModel();
});
