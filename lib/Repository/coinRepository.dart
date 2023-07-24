import 'package:dio/dio.dart';

import '../Model/currency.dart';

class CoinRepository {
  Dio dio = Dio();

  Future<List<Currency>> fetchCryptocurrencyPrices() async {
    try {
      // Cryptocurrencies to monitor
      List<String> cryptocurrencies = [
        'bitcoin',
        'cardano',
        'ripple',
        'ethereum'
      ];

      List<Currency> currencies = [];

      for (String crypto in cryptocurrencies) {
        // Make an API request to get the cryptocurrency price
        String apiUrl =
            'https://api.coingecko.com/api/v3/simple/price?ids=$crypto&vs_currencies=usd&include_market_cap=true&include_24hr_vol=true&include_24hr_change=true&include_last_updated_at=true&precision=';
        Response response = await dio.get(apiUrl);

        if (response.statusCode == 200) {
          double price = double.parse(response.data[crypto]['usd'].toString());
          double usd_market_cap =
              double.parse(response.data[crypto]['usd_market_cap'].toString());
          double usd_24h_vol =
              double.parse(response.data[crypto]['usd_24h_vol'].toString());
          double usd_24h_change =
              double.parse(response.data[crypto]['usd_24h_change'].toString());
          int last_updated_at = response.data[crypto]['last_updated_at'];

          currencies.add(Currency(price, usd_market_cap, usd_24h_vol,
              usd_24h_change, last_updated_at, crypto.toUpperCase()));

          // Access the price data here and perform any desired actions
          print(
              '${crypto.toUpperCase()} Price: \$${price.toStringAsFixed(4)} USD');
        } else {
          print(
              'Failed to fetch ${crypto.toUpperCase()} price. Status Code: ${response.statusCode}');
        }
      }
//https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=true&locale=en
      return currencies;
    } catch (e) {
      print('An error occurred: $e');
      return [];
    }
  }
}
