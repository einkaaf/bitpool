import 'package:bitpool/Repository/coinRepository.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../Model/currency.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: CoinRepository().fetchCryptocurrencyPrices(),
      builder: (context, snapshot) {
        debugPrint('------' + snapshot.hasError.toString());
        debugPrint('------' + snapshot.hasData.toString());

        if (snapshot.hasError) {
          return Scaffold();
        }

        if (snapshot.hasData) {
          return Scaffold(
            backgroundColor: Colors.black87,
            body: SafeArea(
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                physics: BouncingScrollPhysics(),
                children: List.generate(
                  snapshot.data!.length,
                  (index) => Coin(
                    currency: snapshot.data![index],
                  ),
                ),
              ),
            ),
          );
        } else if (snapshot.hasError &&
            snapshot.data != null &&
            snapshot.data!.isEmpty) {
          return Scaffold(
            body: Center(
              child: ElevatedButton(
                  onPressed: () {}, child: const Text('Retry !')),
            ),
          );
        } else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}

class Coin extends StatelessWidget {
  final Currency currency;

  const Coin({super.key, required this.currency});

  LineChartData mainData() {
    return LineChartData(
      lineTouchData: const LineTouchData(enabled: false),
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: Colors.white12,
            strokeWidth: 0.5,
          );
        },
      ),
      titlesData: const FlTitlesData(
        show: false,
      ),
      borderData: FlBorderData(
        show: false,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 0,
      maxX: 10,
      minY: 0,
      maxY: 7,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 3),
            FlSpot(2.6, 2),
            FlSpot(4.9, 5),
            FlSpot(6.8, 3.1),
            FlSpot(8, 4),
            FlSpot(9.5, 3),
            FlSpot(11, 4),
            FlSpot(11, 4),
          ],
          isCurved: true,
          gradient: const LinearGradient(
            colors: [
              Colors.cyan,
              Colors.tealAccent,
            ],
          ),
          barWidth: 2,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [Colors.teal.withAlpha(50), Colors.cyan.withAlpha(50)],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white10,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: (currency.priceChangePercentage24h! > 0)
                      ? Colors.green
                      : Colors.red,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24))),
              width: double.maxFinite,
              child: Center(
                  child: Text(
                '${currency.priceChangePercentage24h!.toStringAsFixed(3)}%',
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 16),
              )),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 8, 18, 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        currency.name.toString(),
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      Text(
                        '\$ ${currency.currentPrice!.toStringAsFixed(4)}',
                        style: const TextStyle(color: Colors.white),
                      ),
                      Text(
                        'IR ${currency.currentPrice!.toStringAsFixed(4)}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  Container(
                    child: Image.network(
                      currency.image.toString(),
                      height: 35,
                      width: 30,
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: LineChart(
                  mainData(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
