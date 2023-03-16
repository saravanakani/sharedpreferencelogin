import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'main.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

   List<Widget> get drawerItems => [
    ListTile(
      leading: Icon(Icons.shopping_cart),
      title: Text("Products"),
      onTap: (){
        changePageIndex(0);
      },
    ),
    ListTile(
      leading: Icon(Icons.production_quantity_limits_sharp),
      title: Text("Orders"),
      onTap: (){
        changePageIndex(1);
      },
    ),
    ListTile(
      leading: Icon(Icons.settings),
      title: Text("settings"),
      onTap: (){
        changePageIndex(2);
      },
    ),
    ListTile(
      leading: Icon(Icons.logout),
      title: Text("LogOut"),
      onTap: (){
        changePageIndex(3);
      },
    ),
  ];

  final List<Widget> homeContent = [
    ProductsPage(),
    OrdersPage(),
    SettingsPage(),
    LogoutPage(),
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          SizedBox(width: 30),
          Column(
            children: [
              const CircleAvatar(
                backgroundImage: AssetImage(
                  "images/circle2.png",
                ),
              ),
              Row(
                children: const [
                  Text("Name :  saravana  ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                          color: Colors.black))
                ],
              )
            ],
          )
        ],
        title: Text(
          "HomePage",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: Column(
          children:  [
            const UserAccountsDrawerHeader(
              accountName: Text("Saravana kani "),
              accountEmail: Text("saravanakani@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage(
                  "images/img.png",
                ),
                radius: 40,
              ),
            ),
            for (var item in drawerItems)
              item,
          ],
        ),
      ),
      body: homeContent[currentIndex],
    );
  }

   void changePageIndex(int index) {
     setState((){
       currentIndex = index;
     });
   }
}


class ProductsPage extends StatefulWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  List p1 = [
    "Product1",
    "Product2",
    "Product3",
    "Product4",
    "Product5",
    "Product6",
    "Product7",
    "Product8",
    "Product9",
    "Product10"
  ];
  List p2 = ["pd1", "pd2", "pd3", "pd4", "pd5", "pd6", "pd7", "pd8","pd9","pd10"];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: ListView.builder(
              itemCount: p1.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: CircleAvatar(),
                  title: Text(p1[index]),
                  subtitle: Text(p2[index]),
                );
              }
          ),
        ),),
    );
  }
}


class OrdersPage extends StatefulWidget {
  const OrdersPage({Key? key}) : super(key: key);

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {

  List L1 = [
    "Order1",
    "Order2",
    "Order3",
    "Order4",
    "Order5",
    "Order6",
    "Order7",
    "Order8",
  ];
  List L2 = ["Od1", "Od2", "Od3", "Od4", "Od5", "Od6", "Od7", "Od8",];


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: ListView.builder(
              itemCount: L1.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: CircleAvatar(),
                  title: Text(L1[index]),
                  subtitle: Text(L2[index]),
                );
              }
          ),
        ),),
    );
  }
}


class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Settings Page'));
  }
}



class LogoutPage extends StatefulWidget {
  const LogoutPage({Key? key}) : super(key: key);

  @override
  State<LogoutPage> createState() => _LogoutPageState();
}

class _LogoutPageState extends State<LogoutPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Center(
          child: Text("Click to logout"),
        ),
        TextButton(
            onPressed: () async {
              Future<SharedPreferences> pref = SharedPreferences.getInstance();
              final SharedPreferences prefs = await pref;

              prefs.clear();
              Navigator.pushAndRemoveUntil(context,
                  MaterialPageRoute(builder: (context) => const Loginpage()), (Route<dynamic> route) => false);
            },
            child: const Text(
              "LogOut",
              style: TextStyle(fontWeight: FontWeight.bold),
            ))
      ],
    );
  }
}

