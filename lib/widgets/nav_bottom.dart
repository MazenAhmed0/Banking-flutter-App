import 'package:flutter/material.dart';

class NavBottom extends StatelessWidget {
  final int currentPage;
  final Function(int) onItemTapped;

  const NavBottom({
    super.key,
    required this.currentPage,
    required this. onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 56,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => onItemTapped(0),
              child: Icon(
                Icons.credit_card,
                size: 25,
                color: currentPage == 0 ? const Color(0xFF7B1FA2) : Colors.grey,
              ),
            ),
            GestureDetector(
              onTap: () => onItemTapped(1),
              child: Image.asset(
                'assets/icons/application.png',
                height: 25,
                width: 25,
                color: currentPage == 1 ? const Color(0xFF7B1FA2) : Colors.grey,
              ),
            ),
             GestureDetector(
              onTap: () => onItemTapped(2),
               child: Image.asset(
              'assets/icons/chart.png',
              height: 25,
              width: 25,
              color: currentPage == 2 ? const Color(0xFF7B1FA2) : Colors.grey,
            ),
            ),
             GestureDetector(
              onTap: () => onItemTapped(3),
              child: Icon(
              Icons.more_horiz,
              size: 25,
              color: currentPage == 3 ? const Color(0xFF7B1FA2) : Colors.grey,
            ),
             ),
          ],
        ),
      ),
   
    );
  }
}