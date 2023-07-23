import 'package:dio/dio.dart';

class CoinRepository {
  Dio dio = Dio();

  void fetchCryptocurrencyPrices() async {
    try {
      // Cryptocurrencies to monitor
      List<String> cryptocurrencies = [
        'bitcoin',
        'cardano',
        'ripple',
        'ethereum'
      ];

      for (String crypto in cryptocurrencies) {
        // Make an API request to get the cryptocurrency price
        String apiUrl =
            'https://api.coingecko.com/api/v3/simple/price?ids=$crypto&vs_currencies=usd';
        Response response = await dio.get(apiUrl);

        if (response.statusCode == 200) {
          double price = response.data[crypto]['usd'];

          // Access the price data here and perform any desired actions
          print(
              '${crypto.toUpperCase()} Price: \$${price.toStringAsFixed(4)} USD');
        } else {
          print(
              'Failed to fetch ${crypto.toUpperCase()} price. Status Code: ${response.statusCode}');
        }
      }
    } catch (e) {
      print('An error occurred: $e');
    }
  }
}
