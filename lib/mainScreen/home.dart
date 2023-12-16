import 'package:flutter/material.dart';
import 'package:latihan_dua/mainScreen/categories.dart';
import 'package:latihan_dua/mainScreen/cart.dart';
import 'package:latihan_dua/mainScreen/profile.dart';
import 'components/salesBanner.dart';
import 'components/searchBar.dart';
import 'components/header.dart';
import 'components/firstDispay.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //init
  static const List<Widget> display = [
    HomeBody(),
    CategoriesScreen(),
    CartScreen(),
  ];

  //variable
  int selectedIndex = 0;

  //function
  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "E-Commerce",
      theme: ThemeData(appBarTheme: AppBarTheme(color: Colors.white)),
      home: Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          elevation: 0,
          flexibleSpace: Container(
            // color: Colors.amber,
            padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Center(
                  child: Ink(
                    decoration: const ShapeDecoration(
                      color: Colors.black,
                      shape: CircleBorder(),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.shopping_basket_rounded),
                      color: Colors.white,
                      onPressed: () {},
                    ),
                  ),
                ),
                Center(
                  child: Ink(
                    decoration: const ShapeDecoration(
                      color: Color.fromARGB(221, 221, 221, 221),
                      shape: CircleBorder(),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.person_3),
                      color: Colors.black54,
                      onPressed: () {
                        Navigator.of(context)
                            .push(_createRoute(const ScrProfile()));
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: display.elementAt(selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          onTap: onItemTapped,
          unselectedItemColor: Colors.grey,
          selectedItemColor: Colors.black,
          // selectedIconTheme: IconThemeData(size: 10),
          currentIndex: selectedIndex,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.tag),
              label: 'Categories',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_rounded),
              label: 'Cart',
            ),
          ],
        ),
      ),
    );
  }
}

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.white,
      child: ListView(
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          height: 100,
          child: const HeaderScreenOne(),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(0, 20, 0, 30),
          alignment: Alignment.center,
          child: const SearchingBar(),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
          height: 190,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: const <Widget>[
              SalesBanner(),
              SalesBanner(),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
          child: const FirstDisplay(),
        ),
      ],
    ),
    );
  }
}

Route _createRoute(Widget screen) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => screen,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
