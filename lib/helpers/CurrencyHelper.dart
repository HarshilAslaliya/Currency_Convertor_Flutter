import 'dart:convert';

import 'package:currency_convertor/model/Currency.dart';
import 'package:http/http.dart' as http;

class CurrencyHelper {
  CurrencyHelper._();

  static final CurrencyHelper currencyHelper = CurrencyHelper._();

  Future<Currency?> fetchCurrency(
      {required String from,
      required String to,
      required int amount}) async {
    String api =
        "https://api.exchangerate.host/convert?from=$from&to=$to&amount=$amount";

    http.Response response = await http.get(
      Uri.parse(api),
    );

    if (response.statusCode == 200) {
      Map decodeData = jsonDecode(response.body);

      Currency currency = Currency.fromMap(data: decodeData);

      return currency;
    }
    return null;
  }
}
