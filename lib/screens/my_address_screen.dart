import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class MyAddressScreen extends StatefulWidget {
  const MyAddressScreen({super.key});

  @override
  _MyAddressScreenState createState() => _MyAddressScreenState();
}

class _MyAddressScreenState extends State<MyAddressScreen> {
  List<String> savedAddresses = [
    'طابلينو',
    'دار الشفاء',
    'دار بنغازي سريع',
    'مزرعة عمر العريبي'
  ]; // قائمة بالعناوين المحفوظة

  String? selectedAddress;

  void _navigateToAddNewAddress() async {
    final newAddress = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddNewAddressScreen()),
    );

    if (newAddress != null) {
      setState(() {
        savedAddresses.add(newAddress);
        selectedAddress = newAddress; // تعيين العنوان الجديد كالعنوان المختار
      });
    }
  }

  void _confirmSelectedAddress() {
    if (selectedAddress != null) {
      // إضافة منطق لتأكيد العنوان المختار
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('تم تأكيد الموقع: $selectedAddress')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('يرجى اختيار موقع لتأكيده')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('عناويني'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: _navigateToAddNewAddress,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange, // نفس لون زر "BUY NOW"
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: const Text('إضافة عنوان جديد'),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: savedAddresses.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(savedAddresses[index]),
                  leading: Radio<String>(
                    value: savedAddresses[index],
                    groupValue: selectedAddress,
                    onChanged: (value) {
                      setState(() {
                        selectedAddress = value;
                      });
                    },
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: _confirmSelectedAddress,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange, // نفس لون زر "BUY NOW"
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: const Text('تأكيد الموقع'),
            ),
          ),
        ],
      ),
    );
  }
}

class AddNewAddressScreen extends StatefulWidget {
  const AddNewAddressScreen({super.key});

  @override
  _AddNewAddressScreenState createState() => _AddNewAddressScreenState();
}

class _AddNewAddressScreenState extends State<AddNewAddressScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  void _navigateToMapScreen() async {
    final selectedLocation = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              MapScreen(name: _nameController.text, description: _descriptionController.text)),
    );

    if (selectedLocation != null) {
      Navigator.pop(context, _nameController.text); // العودة للصفحة الرئيسية مع العنوان الجديد
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('بيانات إضافية للموقع'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'حدد اسم للعنوان',
                prefixIcon: Icon(Icons.location_on),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'وصف كتابي للموقع (اختياري)',
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _navigateToMapScreen,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange, // نفس لون زر "BUY NOW"
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: const Text('تأكيد البيانات'),
            ),
          ],
        ),
      ),
    );
  }
}

class MapScreen extends StatefulWidget {
  final String name;
  final String description;

  const MapScreen({super.key, required this.name, required this.description});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController _mapController;
  LatLng? _currentPosition;

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _currentPosition = LatLng(position.latitude, position.longitude);
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    if (_currentPosition != null) {
      _mapController.animateCamera(
        CameraUpdate.newLatLngZoom(_currentPosition!, 15),
      );
    }
  }

  void _setCurrentLocation() async {
    await _determinePosition();
    if (_currentPosition != null) {
      _mapController.animateCamera(
        CameraUpdate.newLatLngZoom(_currentPosition!, 15),
      );
    }
  }

  void _saveLocation() {
    Navigator.pop(context, _currentPosition);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('اختيار موقع: ${widget.name}'),
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _currentPosition ?? const LatLng(32.8872, 13.1913), // موقع بنغازي كموقع افتراضي
              zoom: 15,
            ),
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            onTap: (position) {
              setState(() {
                _currentPosition = position;
              });
            },
          ),
          Positioned(
            top: 20,
            left: 20,
            right: 20,
            child: TextField(
              decoration: InputDecoration(
                hintText: 'ابحث باسم منطقة، شارع...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 100,
            left: 20,
            right: 20,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange, // نفس لون زر "BUY NOW"
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onPressed: _setCurrentLocation,
              child: const Text('حدد موقعي تلقائياً'),
            ),
          ),
          Positioned(
            bottom: 40,
            left: 20,
            right: 20,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange, // نفس لون زر "BUY NOW"
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onPressed: _saveLocation,
              child: const Text('تأكيد'),
            ),
          ),
        ],
      ),
    );
  }
}
