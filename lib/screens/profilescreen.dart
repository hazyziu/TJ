import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_app/screens/my_address_screen.dart';
import '../../constants.dart';
import 'orders_screen.dart';
import 'product_returns_screen.dart'; // استيراد صفحة ProductReturnsScreen

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset(
            "assets/icons/back.svg",
            colorFilter: const ColorFilter.mode(kTextColor, BlendMode.srcIn),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Profile",
          style: TextStyle(color: kTextColor),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: SvgPicture.asset(
              "assets/icons/cart.svg",
              colorFilter: const ColorFilter.mode(kTextColor, BlendMode.srcIn),
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(kDefaultPaddin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Card with Edit Option
              ProfileCard(
                name: "User Name",
                email: "user@example.com",
                imageSrc: "https://i.imgur.com/IXnwbLk.png",
                press: () {
                  // Navigate to edit profile screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditProfileScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(height: kDefaultPaddin),

              // Account Section
              buildSectionTitle(context, "Account"),
              buildProfileMenuItem(
                context,
                text: "Orders",
                iconPath: "assets/icons/Order.svg",
                onTap: () {
                  // Navigate to Orders screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrdersScreen(), // يجب التأكد من تعريف OrdersScreen
                    ),
                  );
                },
              ),
              buildProfileMenuItem(
                context,
                text: "Returns",
                iconPath: "assets/icons/Return.svg",
                onTap: () {
                  // Navigate to Product Returns screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProductReturnsScreen(),
                    ),
                  );
                },
              ),
              buildProfileMenuItem(
                context,
                text: "Wishlist",
                iconPath: "assets/icons/Wishlist.svg",
                onTap: () {},
              ),
              buildProfileMenuItem(
                context,
                text: "Addresses",  // تحديث خانة العنوان
                iconPath: "assets/icons/Address.svg",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MyAddressScreen(), // الانتقال إلى صفحة العنوان
                    ),
                  );
                },
              ),

              buildProfileMenuItem(
                context,
                text: "Payment",
                iconPath: "assets/icons/card.svg",
                onTap: () {},
              ),
              buildProfileMenuItem(
                context,
                text: "Wallet",
                iconPath: "assets/icons/Wallet.svg",
                onTap: () {},
              ),

              const SizedBox(height: kDefaultPaddin),

              // Personalization Section
              buildSectionTitle(context, "Personalization"),
              buildProfileMenuItem(
                context,
                text: "Notification",
                iconPath: "assets/icons/Notification.svg",
                onTap: () {},
              ),
              buildProfileMenuItem(
                context,
                text: "Preferences",
                iconPath: "assets/icons/Preferences.svg",
                onTap: () {},
              ),

              const SizedBox(height: kDefaultPaddin),

              // Settings Section
              buildSectionTitle(context, "Settings"),
              buildProfileMenuItem(
                context,
                text: "Language",
                iconPath: "assets/icons/Language.svg",
                onTap: () {},
              ),
              buildProfileMenuItem(
                context,
                text: "Location",
                iconPath: "assets/icons/Location.svg",
                onTap: () {},
              ),

              const SizedBox(height: kDefaultPaddin),

              // Help & Support Section
              buildSectionTitle(context, "Help & Support"),
              buildProfileMenuItem(
                context,
                text: "Get Help",
                iconPath: "assets/icons/Help.svg",
                onTap: () {},
              ),
              buildProfileMenuItem(
                context,
                text: "FAQ",
                iconPath: "assets/icons/FAQ.svg",
                onTap: () {},
              ),

              const SizedBox(height: kDefaultPaddin),

              // Logout Section
              ListTile(
                onTap: () {
                  // Logout action
                },
                leading: SvgPicture.asset(
                  "assets/icons/Logout.svg",
                  height: 24,
                  width: 24,
                  colorFilter: const ColorFilter.mode(
                    Colors.red,
                    BlendMode.srcIn,
                  ),
                ),
                title: const Text(
                  "Log Out",
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin / 2),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
          fontWeight: FontWeight.bold,
          color: kTextColor,
        ),
      ),
    );
  }

  Widget buildProfileMenuItem(
      BuildContext context, {
        required String text,
        required String iconPath,
        required VoidCallback onTap,
      }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
      onTap: onTap,
      leading: SvgPicture.asset(
        iconPath,
        height: 24,
        width: 24,
        colorFilter: ColorFilter.mode(
          Theme.of(context).iconTheme.color!,
          BlendMode.srcIn,
        ),
      ),
      title: Text(
        text,
        style: const TextStyle(fontSize: 14),
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  final String name;
  final String email;
  final String imageSrc;
  final VoidCallback press;

  const ProfileCard({
    super.key,
    required this.name,
    required this.email,
    required this.imageSrc,
    required this.press,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press, // Allows editing profile on tap
      child: Container(
        padding: const EdgeInsets.all(kDefaultPaddin),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              offset: Offset(0, 15),
              blurRadius: 25,
              color: Colors.black12,
            ),
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(imageSrc),
              radius: 28,
            ),
            const SizedBox(width: kDefaultPaddin),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hi, $name",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(email, style: const TextStyle(color: kTextLightColor)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController nameController =
  TextEditingController(text: "User Name");
  final TextEditingController emailController =
  TextEditingController(text: "user@example.com");
  final TextEditingController phoneController =
  TextEditingController(text: "0123456789");
  String imageUrl = "https://i.imgur.com/IXnwbLk.png"; // الصورة الافتراضية

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // باقي محتوى شاشة تحرير الملف الشخصي
          ],
        ),
      ),
    );
  }
}
