import 'package:shoe_store/features/caterogy/caterogy_page_screen.dart';

import 'package:shoe_store/features/home_page/home_page_screen.dart';
import 'package:shoe_store/features/order/order_page_screen.dart';
import 'package:shoe_store/features/setting/setting_page_screen.dart';
import 'package:shoe_store/gen/assets.gen.dart';
import 'package:shoe_store/shared/extensions/extensions.dart';
import 'package:shoe_store/shared/widgets/bottom_navigation/custom_bottom_navigation.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final bottomNavKey = GlobalKey<BottomNavigationState>();

  @override
  Widget build(BuildContext context) {
    return BottomNavigation(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
          )
        ],
      ),
      items: [
        BottomNavigationItem(
          icon: Assets.icons.home.path,
          page: const HomePageScreen(),
        ),
        BottomNavigationItem(
          icon: Assets.icons.shoppingCart.path,
          page: const OrderScreen(),
        ),
        BottomNavigationItem(
          icon: Assets.icons.other.path,
          page: const CaterogyScreen(),
        ),
        BottomNavigationItem(
          icon: Assets.icons.settings.path,
          page: const SettingScreen(),
        ),
      ],
      activeColor: context.colors.primaryColor,
    );
  }
}
// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:shoe_store/shared/widgets/app_layout.dart';
// import 'package:shoe_store/shared/widgets/app_text.dart';
// import 'package:http/http.dart' as http;

// class MainScreen extends StatefulWidget {
//   const MainScreen({super.key});

//   @override
//   State<MainScreen> createState() => _MainScreenState();
// }

// class _MainScreenState extends State<MainScreen> {
//   String temperature = "";
//   String humi = "";
//   String weatherDescription = "Loading...";
//   String apiKey = "ad853302d5f63942fe6970979c850bcd";

//   Future<Map<String, dynamic>> fetchWeather() async {
//     String url =
//         "https://api.openweathermap.org/data/2.5/weather?q=Hanoi&appid=$apiKey&units=metric";
//     final response = await http.get(Uri.parse(url));
//     if (response.statusCode == 200) {
//       return jsonDecode(response.body);
//     } else {
//       return {
//         "main": {"temp": "N/A"},
//         "weather": [
//           {"description": "N/A"}
//         ]
//       };
//     }
//   }

//   Stream<Map<String, dynamic>> weatherStream() async* {
//     while (true) {
//       await Future.delayed(Duration(seconds: 30)); // Cập nhật mỗi 1 phút
//       yield await fetchWeather();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AppLayout(
//       child: Padding(
//         padding: EdgeInsets.all(30),
//         child: Center(
//           child: StreamBuilder<Map<String, dynamic>>(
//               stream: weatherStream(),
//               builder: (context, snapshot) {
//                 if (!snapshot.hasData) return CircularProgressIndicator();
//                 var data = snapshot.data!;
//                 String temperature = "${data['main']['temp']}°C";
//                 String humi = "${data['main']['humidity']}%";
//                 String weatherDescription = data['weather'][0]['description'];

//                 return Column(
//                   children: [
//                     AppText('thoi tiet tai ha noi'),
//                     AppText("Temperature: $temperature",
//                         style: TextStyle(fontSize: 20)),
//                     AppText("Humi: $humi", style: TextStyle(fontSize: 20)),
//                     AppText("Weather: $weatherDescription",
//                         style: TextStyle(fontSize: 18)),
                        

                      
//                   ],
//                 );
//               }),
//         ),
//       ),
//     );
//   }
// }
