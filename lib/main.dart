import 'package:flutter/material.dart';
import 'package:getwidget/components/appbar/gf_appbar.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BMI Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CalculatorPage(),
    );
  }
}

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({Key? key}) : super(key: key);

  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  TextEditingController heightControllerF = TextEditingController();
  TextEditingController heightControllerI = TextEditingController();
  TextEditingController weightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GFAppBar(
        leading: Icon(Icons.calculate),
        title: Text("BMI Calculator"),
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => AboutDialog(
                          applicationIcon: Icon(Icons.calculate),
                          applicationName: 'BMI Calculator',
                          applicationVersion: '1.0.0',
                          children: [
                            Text(
                                " This flutter BMI calculator is made by Ferdous Parvez"),
                            Text("01843861974")
                          ],
                        ));
              },
              icon: Icon(Icons.copyright))
        ],
      ),
      body: Center(
        child: Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width * .5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.calculate,
                size: MediaQuery.of(context).size.width * .25,
                color: Colors.blue,
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      //width: MediaQuery.of(context).size.width * .20,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: heightControllerF,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Height',
                            suffixText: 'Feet'),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      //width:  MediaQuery.of(context).size.width * .20,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: heightControllerI,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Height',
                            suffixText: 'Inch'),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextField(
                  controller: weightController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Weight',
                      hintText: 'Enter Your Weight',
                      suffixText: 'KG'),
                ),
              ),
              GFButton(
                  onPressed: () {
                    try {
                      var h1 = num.parse(heightControllerF.text);
                      var h2 = num.parse(heightControllerI.text);
                      var height = h1 * 12 + h2;

                      var hInMetre = (height * 2.54) / 100;
                      var w = num.parse(weightController.text);
                      var r = w / (hInMetre * hInMetre);
                      var result = r.toString().substring(0, 4);

                      showDialog(
                          context: context,
                          builder: (context) => Dialog(
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * .25,
                                  width:
                                      MediaQuery.of(context).size.width * .25,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Your BMI is: $result",
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                          "Info:\n Underweight = <18.5,\n Normal weight = 18.5–24.9,\n Overweight = 25–29.9,\n Obesity = BMI of 30 or greater")
                                    ],
                                  ),
                                  color: Colors.red,
                                ),
                              ));
                    } on Exception catch (_) {
                      print("Enter a number please");
                      showDialog(
                        context: context,
                        builder: (context) => Dialog(
                          child: Container(
                            height: MediaQuery.of(context).size.height * .25,
                            width: MediaQuery.of(context).size.width * .25,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.warning),
                                Text(
                                  "Input a number",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                            color: Colors.red,
                          ),
                        ),
                      );
                    }
                  },
                  shape: GFButtonShape.pills,
                  child: Text("Calculate your BMI"),
                  size: GFSize.LARGE)
            ],
          ),
        ),
      ),
    );
  }
}
