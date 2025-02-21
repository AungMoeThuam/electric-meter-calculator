import 'package:electric_app/models/meter.dart';
import 'package:electric_app/pages/result_page.dart';
import 'package:electric_app/utils/calculate_cost.dart';
import 'package:electric_app/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';



class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final previousMeterText0 = TextEditingController();
  final currentMeterText0 = TextEditingController();
  final previousMeterText1 = TextEditingController();
  final currentMeterText1 = TextEditingController();

  void calculate(){

    if(previousMeterText0.text.trim() == ""  || currentMeterText0.text.trim()  == "" || previousMeterText1.text.trim()  == "" || currentMeterText1.text.trim()  == "") {
      return toast("မီတာ အားလုံးဖြည့်သွင်းရမည်!");
    }

    if(int.parse(previousMeterText0.text) > int.parse(currentMeterText0.text) || int.parse(previousMeterText1.text) > int.parse(currentMeterText1.text)) {
      return toast("ယခင် မီတာက ယခု မီတာထက်ကြီးရမည်!");
    }

    final meter0 = calculateCost(previousMeterText0.text, currentMeterText0.text);
    final meter1 = calculateCost(previousMeterText1.text, currentMeterText1.text);



    final data = {
      "ko swe" : Meter(name: "Swe",cost: meter0),
      "painting" : Meter(name: "Swe",cost: meter1)
    };

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ResultPage(
                data:data
            ))
    );

  }

  @override
  Widget build(BuildContext context) {
    double a = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text(widget.title),
      ),
      body:
      Container(
        decoration: BoxDecoration(
          color: Colors.white30
        ),
        child:
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Colors.white,
                border: Border.all(width: 2,color: Colors.black12),
                  borderRadius: BorderRadius.circular(20)
              ),
              child:
              Column(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10,),
                      Text("Painting"),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: a * 0.38,
                            child: TextField(
                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                              keyboardType: TextInputType.number,
                              controller: previousMeterText0,
                              decoration: InputDecoration(
                                  hintText: "ယခင်လမီတာ", border: OutlineInputBorder()),
                            ),

                          ),
                          SizedBox(width: 10,),
                          SizedBox(
                            width: a * 0.38,
                            child: TextField(
                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                              keyboardType: TextInputType.number,
                              controller: currentMeterText0,
                              decoration: InputDecoration(
                                  hintText: "ယခုလမီတာ", border: OutlineInputBorder()),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10,),
                      Text("KO SWE"),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: a * 0.38,
                            child: TextField(
                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                              keyboardType: TextInputType.number,
                              controller: previousMeterText1,
                              decoration: InputDecoration(

                                  hintText: "ယခင်လမီတာ", border: OutlineInputBorder()),
                            ),
                          ),
                          SizedBox(width: 10,),
                          SizedBox(
                            width: a * 0.38,
                            child: TextField(
                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                              keyboardType: TextInputType.number,
                              controller: currentMeterText1,
                              decoration: InputDecoration(
                                  hintText: "ယခုလမီတာ", border: OutlineInputBorder()),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 10,),
                  TextButton(
                      style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all<Color>(Colors.amber)
                      ),
                      onPressed: calculate, child: Text("တွက်မယ်")

                  )
                ],
              ),
            )
          ],
        ),
      ),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
