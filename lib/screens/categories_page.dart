import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

const double defaultPadding = 16.0; // تعريف defaultPadding

// نموذج الفئة (Category)
class CategoryModel {
  final String title;
  final String? image, svgSrc;
  final List<CategoryModel>? subCategories;

  CategoryModel({
    required this.title,
    this.image,
    this.svgSrc,
    this.subCategories,
  });
}

// قائمة الفئات الرئيسية مع الصور
final List<CategoryModel> demoCategoriesWithImage = [
  CategoryModel(title: "Woman’s", image: "https://i.imgur.com/5M89G2P.png"),
  CategoryModel(title: "Man’s", image: "https://i.imgur.com/UM3GdWg.png"),
  CategoryModel(title: "Kid’s", image: "https://i.imgur.com/Lp0D6k5.png"),
  CategoryModel(title: "Accessories", image: "https://i.imgur.com/3mSE5sN.png"),
];

// قائمة الفئات مع الأيقونات والفئات الفرعية
final List<CategoryModel> demoCategories = [
  CategoryModel(
    title: "On sale",
    svgSrc: "assets/icons/Sale.svg",
    subCategories: [
      CategoryModel(title: "All Clothing"),
      CategoryModel(title: "New In"),
      CategoryModel(title: "Coats & Jackets"),
      CategoryModel(title: "Dresses"),
      CategoryModel(title: "Jeans"),
    ],
  ),
  CategoryModel(
    title: "Man’s & Woman’s",
    svgSrc: "assets/icons/Man&Woman.svg",
    subCategories: [
      CategoryModel(title: "All Clothing"),
      CategoryModel(title: "New In"),
      CategoryModel(title: "Coats & Jackets"),
    ],
  ),
  CategoryModel(
    title: "Kids",
    svgSrc: "assets/icons/Child.svg",
    subCategories: [
      CategoryModel(title: "All Clothing"),
      CategoryModel(title: "New In"),
      CategoryModel(title: "Coats & Jackets"),
    ],
  ),
  CategoryModel(
    title: "Accessories",
    svgSrc: "assets/icons/Accessories.svg",
    subCategories: [
      CategoryModel(title: "All Clothing"),
      CategoryModel(title: "New In"),
    ],
  ),
];

// صفحة عرض الفئات (Category Page)
class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الفئات'),
        backgroundColor: Colors.blue, // استخدم اللون الخاص بتطبيقك هنا
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: const Text(
              "اختر فئة لعرض المنتجات",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: demoCategories.length,
              itemBuilder: (context, index) {
                return CategoryTile(
                  category: demoCategories[index],
                  onTap: () {
                    // فتح صفحة الفئات الفرعية
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SubCategoryScreen(
                          category: demoCategories[index],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// عنصر عرض الفئة (CategoryTile)
class CategoryTile extends StatelessWidget {
  final CategoryModel category;
  final VoidCallback onTap;

  const CategoryTile({super.key, required this.category, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: category.svgSrc != null
          ? SvgPicture.asset(
        category.svgSrc!,
        height: 30,
        colorFilter: ColorFilter.mode(
          Theme.of(context).primaryColor,
          BlendMode.srcIn,
        ),
      )
          : const Icon(Icons.category), // رمز افتراضي في حال عدم وجود صورة
      title: Text(
        category.title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: onTap,
    );
  }
}

// صفحة عرض الفئات الفرعية (SubCategoryScreen)
class SubCategoryScreen extends StatelessWidget {
  final CategoryModel category;

  const SubCategoryScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('الفئات الفرعية - ${category.title}'),
        backgroundColor: Colors.blue, // استخدم اللون الخاص بتطبيقك هنا
      ),
      body: category.subCategories == null
          ? const Center(child: Text('لا توجد فئات فرعية'))
          : ListView.builder(
        itemCount: category.subCategories!.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(category.subCategories![index].title),
          );
        },
      ),
    );
  }
}
