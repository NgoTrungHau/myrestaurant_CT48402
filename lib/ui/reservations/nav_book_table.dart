// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../../ui/reservations/book_table_screen.dart';// 
// import 'orders_item_card.dart';

// import '../shared/app_drawer.dart';
// // BottomNavigation


// class BottomNavigation extends StatefulWidget {
//   const BottomNavigation({Key? key}) : super(key: key);

//   @override
//   State<BottomNavigation> createState() => _TableBook();
// }

// class _TableBook extends State<BottomNavigation> {
//   int _selectedIndex = 0;

//   static final List<Widget> _pages = [
//     const ReservationScreen(),
//     const 
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _pages[_selectedIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         selectedItemColor: Theme.of(context).textSelectionTheme.selectionColor,
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.card_giftcard),
//             label: 'Card',
//           ),
//         ],
//         currentIndex: _selectedIndex,
//         onTap: (index) {
//           setState(() {
//             _selectedIndex = index;
//           });
//         },
//       ),
//     );
//   }
// }
