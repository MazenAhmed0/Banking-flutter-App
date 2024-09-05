import 'package:flutter/material.dart';

class BackgroundTheme extends StatelessWidget {
  const BackgroundTheme({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: -74,
              left: 251, 
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: const BoxDecoration(
                    color: Color(0xFFF8E192),
                    shape: BoxShape.circle,
                  ),
            )
          ),
            Positioned(
              top: 246,
              left: -72, 
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: const BoxDecoration(
                    color: Color(0x4D2FCBFC),
                    shape: BoxShape.circle,
                  ),
            )
          ),
          
          ],
      ),
      
      ),
    );
  }
}







