import 'package:dio/dio.dart';

import '../Model/currency.dart';

class CoinRepository {
  Dio dio = Dio();

  Future<List<Currency>> fetchCryptocurrencyPrices() async {
    try {
      List<Currency> currencies = [];

      // String apiUrl =
      //     'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=true&locale=en';

      String apiUrl = 'https://divlife.ir/mk/sample.json';
      Response response = await dio.get(apiUrl);
      if (response.statusCode == 200) {
        for (var a in response.data) {
          Currency aa = Currency.fromJson(a);
          currencies.add(aa);
        }
      }
      return currencies;
    } catch (e) {
      print('An error occurred: $e');
      return [];
    }
  }
}
