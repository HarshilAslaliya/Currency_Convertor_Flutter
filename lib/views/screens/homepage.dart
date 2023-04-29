import 'package:currency_convertor/controller/themeprovider.dart';
import 'package:currency_convertor/helpers/CurrencyHelper.dart';
import 'package:currency_convertor/model/Currency.dart';
import 'package:currency_convertor/views/components/numpad.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../model/globals.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<Currency?> future;

  TextEditingController amountController = TextEditingController();
  String _inputText = '1';

  void _onKeyPressed(String value) {
    setState(() {
      if (value == 'DEL') {
        if (_inputText.isNotEmpty) {
          _inputText = _inputText.substring(0, _inputText.length - 1);
        }
      } else if (value == "✔") {
        if (_inputText.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              //  backgroundColor: Global.appColor,
              behavior: SnackBarBehavior.floating,
              content: Text("Please Enter Amount"),
            ),
          );
        } else {
          int amount = int.parse(_inputText);
          setState(() {
            future = CurrencyHelper.currencyHelper.fetchCurrency(
                from: fromCurrency, to: toCurrency, amount: amount);
          });
        }
      } else {
        _inputText += value;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    future = CurrencyHelper.currencyHelper
        .fetchCurrency(from: "USD", to: "INR", amount: 1);

    amountController.text = "1";
  }

  // ThemeController themeController = Get.put(ThemeController());

  String fromCurrency = "USD";
  String toCurrency = "INR";

  bool _darkTheme = true;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          "Currency Convertor",
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                            fontSize: 30,
                            color: Globals.themeMode
                                ? Colors.white
                                : Globals.darkColor,
                            fontWeight: FontWeight.w700,
                          )),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: IconButton(
                            icon: Globals.themeMode
                                ? Icon(Icons.dark_mode)
                                : Icon(Icons.dark_mode_outlined),
                            onPressed: () {
                              themeProvider.toggleTheme();
                              setState(() {
                                Globals.themeMode = !Globals.themeMode;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: size.height * 0.38,
                      width: size.width,
                      decoration: BoxDecoration(
                        color: Globals.themeMode
                            ? Colors.white
                            : Globals.darkColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: FutureBuilder(
                          future: future,
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Center(
                                child: Text("${snapshot.error}"),
                              );
                            } else if (snapshot.hasData) {
                              Currency? data = snapshot.data;
                              return (data != null)
                                  ? Padding(
                                      padding: const EdgeInsets.all(15),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "From",
                                                style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w700,
                                                    color: Globals.themeMode
                                                        ? Globals.darkColor
                                                        : Colors.white,
                                                  ),
                                                ),
                                              ),
                                              Spacer(),
                                              Container(
                                                height: size.height * 0.06,
                                                width: size.width * 0.3,
                                                child: DropdownButtonFormField(
                                                    value: fromCurrency,
                                                    decoration: InputDecoration(
                                                      enabledBorder:
                                                          UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors
                                                                .transparent),
                                                      ),
                                                      focusedBorder:
                                                          UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors
                                                                .transparent),
                                                      ),
                                                    ),
                                                    iconEnabledColor:
                                                        Globals.themeMode
                                                            ? Globals.darkColor
                                                            : Colors.white,
                                                    dropdownColor:
                                                        Globals.themeMode
                                                            ? Colors.white
                                                            : Globals.darkColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    items: Globals.currency
                                                        .map(
                                                          (e) =>
                                                              DropdownMenuItem(
                                                            value: e,
                                                            child: Text(
                                                              "  ${e}",
                                                              style: GoogleFonts.poppins(
                                                                  textStyle: TextStyle(
                                                                      color: Globals.themeMode
                                                                          ? Globals
                                                                              .darkColor
                                                                          : Colors
                                                                              .white,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600)),
                                                            ),
                                                          ),
                                                        )
                                                        .toList(),
                                                    onChanged: (val) {
                                                      setState(() {
                                                        fromCurrency =
                                                            val!.toString();
                                                      });
                                                    }),
                                              ),
                                            ],
                                          ),
                                          TextField(
                                            readOnly: true,
                                            controller: TextEditingController(
                                                text: _inputText),
                                            keyboardType: TextInputType.number,
                                            style: TextStyle(
                                              color: Globals.themeMode
                                                  ? Globals.darkColor
                                                  : Colors.white,
                                              fontSize: 25,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            decoration: InputDecoration(
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Globals.themeMode
                                                        ? Globals.darkColor
                                                        : Colors.white),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Globals.themeMode
                                                        ? Globals.darkColor
                                                        : Colors.white),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              contentPadding:
                                                  const EdgeInsets.only(
                                                      left: 20),
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "To",
                                                style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w700,
                                                    color: Globals.themeMode
                                                        ? Globals.darkColor
                                                        : Colors.white,
                                                  ),
                                                ),
                                              ),
                                              Spacer(),
                                              Container(
                                                height: size.height * 0.06,
                                                width: size.width * 0.3,
                                                child: DropdownButtonFormField(
                                                    value: toCurrency,
                                                    decoration: InputDecoration(
                                                      enabledBorder:
                                                          UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors
                                                                .transparent),
                                                      ),
                                                      focusedBorder:
                                                          UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors
                                                                .transparent),
                                                      ),
                                                    ),
                                                    iconEnabledColor:
                                                        Globals.themeMode
                                                            ? Globals.darkColor
                                                            : Colors.white,
                                                    dropdownColor:
                                                        Globals.themeMode
                                                            ? Colors.white
                                                            : Globals.darkColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    items: Globals.currency
                                                        .map(
                                                          (e) =>
                                                              DropdownMenuItem(
                                                            value: e,
                                                            child: Text(
                                                              "  ${e}",
                                                              style: GoogleFonts.poppins(
                                                                  textStyle: TextStyle(
                                                                      color: Globals.themeMode
                                                                          ? Globals
                                                                              .darkColor
                                                                          : Colors
                                                                              .white,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600)),
                                                            ),
                                                          ),
                                                        )
                                                        .toList(),
                                                    onChanged: (val) {
                                                      setState(() {
                                                        toCurrency =
                                                            val!.toString();
                                                      });
                                                    }),
                                              ),
                                            ],
                                          ),
                                          TextField(
                                            readOnly: true,
                                            keyboardType: TextInputType.number,
                                            style: TextStyle(
                                              color: Globals.themeMode
                                                  ? Globals.darkColor
                                                  : Colors.white,
                                              fontSize: 25,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            decoration: InputDecoration(
                                              hintText: "${data.result}",
                                              hintStyle: TextStyle(
                                                color: Globals.themeMode
                                                    ? Globals.darkColor
                                                    : Colors.white,
                                                fontSize: 25,
                                                fontWeight: FontWeight.w600,
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Globals.themeMode
                                                        ? Globals.darkColor
                                                        : Colors.white),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Globals.themeMode
                                                        ? Globals.darkColor
                                                        : Colors.white),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              contentPadding:
                                                  const EdgeInsets.only(
                                                      left: 20),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Currency Rate : ",
                                                style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                    fontSize: 20,
                                                    color: Globals.themeMode
                                                        ? Globals.darkColor
                                                        : Colors.white,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                "${data.rate.toString().split(".")[0]}",
                                                style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                    fontSize: 20,
                                                    color: Globals.themeMode
                                                        ? Globals.darkColor
                                                        : Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  : const Center(
                                      child: Text("Data Not Found"),
                                    );
                            }
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(child: NumPad(onKeyPressed: _onKeyPressed)),
            ),
          ],
        ),
      ),
    );
  }
}
