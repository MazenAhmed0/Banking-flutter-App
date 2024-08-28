import 'package:banking/Pages/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}



                  //  children: [
                  //    Padding(
                  //     padding: const EdgeInsets.only(left: 34.0, right: 30,),
                  //     child: Container(
                  //       height: 88,
                  //       decoration: BoxDecoration(
                  //         color: Colors.white,
                  //         borderRadius: BorderRadius.circular(10),
                  //         boxShadow: const [
                  //           BoxShadow(
                  //             color: Colors.grey,
                  //             offset: Offset(0, 0.1),
                  //             blurRadius: 5.0,
                  //             spreadRadius: 0
                  //           )
                  //         ]
                  //       ),
                  //       child: const Padding(
                  //         padding: EdgeInsets.all(20.0),
                  //         child: Column(
                  //           children: [
                  //             Row(
                  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //               children: [
                  //                 Column(
                  //                   crossAxisAlignment: CrossAxisAlignment.start,
                  //                   children: [
                  //                     Text(
                  //                       'Shopping',
                  //                       style: TextStyle(
                  //                         fontSize: 20,
                  //                         fontWeight: FontWeight.bold,
                  //                         color: Colors.black,
                  //                       ),
                  //                     ),
                  //                     SizedBox(height: 5,),
                  //                     Text(
                  //                       'Tue 12.05.2021',
                  //                       style: TextStyle(
                  //                         fontWeight: FontWeight.w200,
                  //                         fontSize: 15,
                  //                         color: Color(0xff858585)
                  //                       ),
                  //                     )
                  //                   ],
                  //                 ),
                  //                 Text(
                  //                   '\$29.90',
                  //                   style: TextStyle(
                  //                     fontSize: 20,
                  //                     fontWeight: FontWeight.bold,
                  //                     color: Colors.black,
                  //                   ),
                  //                 )
                  //               ],
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                      
                  //     ),
                  //                      ),
                  //  ],
                   