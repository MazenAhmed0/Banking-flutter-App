import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ReportsPage extends StatefulWidget {
  const ReportsPage({super.key});

  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30,),
            _moneySection(),
            const SizedBox(height: 30,),
            _monthlySpendingChart(),
            const SizedBox(height: 30,),
            _budgetSection()
          ],
        ),
      ),
        
    );
  }

  Padding _budgetSection() {
    return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                Container(
                  height: 103,
                  decoration: BoxDecoration(
                    color: const Color(0xFFD1ECF7),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'In Budget',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25
                          ),
                        ),
                        SizedBox(height: 8,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Shopping',
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w300,
                                fontSize: 20
                              ),
                            ),
                            Text(
                              '\$50.00/ \$100.00',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30,),
                Container(
                  height: 103,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFAE2EE),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Out of Budget',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25
                          ),
                        ),
                        SizedBox(height: 8,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Subscriptions',
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w300,
                                fontSize: 20
                              ),
                            ),
                            Text(
                              '\$50.00/ \$100.00',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30,),
              ],
            ),
          );
  }

  Padding _monthlySpendingChart() {
    return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 23.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(255, 221, 221, 221),
                    offset: Offset(0, 1),
                    blurRadius: 8.0,
                    spreadRadius: 0,
                  )
                ]
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 25.0, bottom: 40),
                      child: Text(
                        'Monthly Spending',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 25,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 20, right: 20),
                      height: 300,  
                      child: BarChart(
                        BarChartData(
                          maxY: 600,
                          barTouchData: BarTouchData(enabled: false),
                          titlesData: FlTitlesData(
                            show: true,
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: (double value, TitleMeta meta) {
                                  const style =TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 14
                                  );
                                  Widget text;
                                  switch (value.toInt()){
                                    case 0:
                                      text = const Text('JAN ', style: style);
                                      const SizedBox(height: 7,);
                                      break;
                                    case 1:
                                      text = const Text('FEB', style: style);
                                      const SizedBox(height: 7,);
                                      break;
                                    case 2:
                                      text = const Text('MAR', style: style);
                                      const SizedBox(height: 7,);
                                      break;
                                    case 3:
                                      text = const Text('APR', style: style);
                                      const SizedBox(height: 7,);
                                      break;
                                    case 4:
                                      text = const Text('MAY', style: style);
                                      const SizedBox(height: 7,);
                                      break;
                                    case 5:
                                      text = const Text('JUN', style: style);
                                      const SizedBox(height: 7,);
                                      break;
                                    default:
                                      text = const Text('');
                                      break;
                                  }
                
                                  return SideTitleWidget(
                                    axisSide: meta.axisSide,
                                    space: 8.0,
                                    child: text,
                                    );
                
                                },
                              )
                            ),
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: (double value, TitleMeta meta) {
                                  const style = TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 15,
                                  );
                                  return Text('${value.toInt()}', style: style);
                                },
                                interval: 100,
                                reservedSize: 28,
                              )
                            ),
                            topTitles: const AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: false,
                              )
                            ),
                            rightTitles: const AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: false,
                              )
                            )
                          ),
                          borderData: FlBorderData(
                            border: const Border(
                              top: BorderSide.none,
                              right: BorderSide.none,
                              left: BorderSide.none,
                              bottom:BorderSide(
                                width: 1,
                                color: Color(0xFF7A8AED)
                              )
                            )
                          ),
                          barGroups: _buildBarGroups(),
                          gridData: FlGridData(
                            drawHorizontalLine: true, 
                            drawVerticalLine: false,
                            horizontalInterval: 100,
                            getDrawingHorizontalLine: (value) {
                              return FlLine(
                                color: const Color(0xFF7A8AED).withOpacity(0.1),
                                strokeWidth: 1
                              );
                            },
                          )
                          // barGroups: [
                          //   BarChartGroupData(
                          //     x: 0
                          //     )
                          // ]
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }

  Row _moneySection() {
    return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 90,
                width: MediaQuery.of(context).size.width * 0.4,
                decoration: BoxDecoration(
                  color: const Color(0xFFF8E192),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Padding(
                  padding: EdgeInsets.only(left: 15.0,top: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Money In',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 20
                        ),
                      ),
                      SizedBox(height: 8,),
                      Row(
                        children: [
                          Text(
                            '+ \$3,456.98',
                            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                          ),
                          SizedBox(width: 5,),
                          Icon(
                            Icons.trending_up,
                            size: 20,
                            color: Colors.purple,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Container(
                height: 90,
                width: MediaQuery.of(context).size.width * 0.4,
                decoration: BoxDecoration(
                  color: const Color(0xFFB6E0F3),
                  borderRadius: BorderRadius.circular(8),
                ),
                                  child: const Padding(
                  padding: EdgeInsets.only(left: 15.0,top: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Money Out',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 20
                        ),
                      ),
                      SizedBox(height: 8,),
                      Row(
                        children: [
                          Text(
                            '- \$567.25',
                            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                          ),
                          SizedBox(width: 5,),
                          Icon(
                            Icons.trending_up,
                            size: 20,
                            color: Colors.purple,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              
            ],
          );
  }


    AppBar _appBar() {
    return AppBar(
      title: const Text(
        'Reoprts',
        style: TextStyle(
          color: Colors.black,
          fontSize: 25,
          fontWeight: FontWeight.bold
        ),
      ),
      backgroundColor: Colors.white,
      elevation: 0.0,
      centerTitle: true,
      leading: GestureDetector(
        onTap: () {},
        child: Container(
          margin: const EdgeInsets.only(left: 20),
          alignment: Alignment.center,
          child: Stack(
            children: [
            // Gradient border
            Container(
              padding: const EdgeInsets.all(2), // Space for the gradient border
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF133FD8),
                    Color(0x4CB7004D),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
          child: Container(
            padding: const EdgeInsets.all(1), // Inner border thickness
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white, // Inner border color
            ),
            child: const CircleAvatar(
              radius: 40, // Adjust the size of the avatar
              backgroundImage: AssetImage('assets/images/profile.jpeg'), // Replace with your image path
            ),
          ),
            ),
            // Notification dot
            Positioned(
              top: 10,
              right: 2,
              child: Container(
                width: 9,
                height: 9,
                decoration: BoxDecoration(
                  color: const Color(0xFFDB1337),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white, // Add white border to separate from the avatar
                    width: 2,
                  ),
                ),
              ),
            ),
          ],
        ),
        ),
      ),
    );
    
  }


    List<BarChartGroupData> _buildBarGroups() {
    return [
      _buildBarGroup(0, 375),
      _buildBarGroup(1, 490),
      _buildBarGroup(2, 270),
      _buildBarGroup(3, 300),
      _buildBarGroup(4, 550),
      _buildBarGroup(5, 300),
    ];
  }

    BarChartGroupData _buildBarGroup(int x, double y) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          width: 22,
          borderRadius: BorderRadius.circular(0),
          gradient: const LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Color(0xFFA6C1EE),
              Color(0xFFFBC2EB),
            ],
          ),
        ),
      ],
    );
  }


}
