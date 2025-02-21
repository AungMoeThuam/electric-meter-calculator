import 'dart:io';
import 'package:electric_app/models/meter.dart';
import 'package:electric_app/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:pdf/widgets.dart' as pw;

import '../utils/getDownloadPath.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key, required this.data});

  final Map<String, Meter> data;

  Widget tableCell(String text, {bool isHeader = false}) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
          fontSize: 16,
        ),
      ),
    );
  }



  String getFormattedTimestamp() {
    DateTime now = DateTime.now();
    String formattedDate = "${now.day}-${now.month}-${now.year}";
    return "${now.millisecondsSinceEpoch}-$formattedDate";
  }

  Future<void> generatePdf() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            children: [
              pw.Text('Electricity Cost Report',
                  style: pw.TextStyle(
                      fontSize: 20, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 10),
              pw.Text("Date : ${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}"),
              pw.SizedBox(height: 10),
              pw.Table.fromTextArray(
                headers: ["No", "Meter Units", "Cost", "Service Charge 250+"],
                data: data.entries.map((entry) {
                  return [
                    entry.key,
                    "${entry.value.totalMeter.toString()} units",
                    "${entry.value.cost} Ks",
                    "${entry.value.cost + 250} Ks"
                  ];
                }).toList(),
                border: pw.TableBorder.all(),
              ),
            ],
          );
        },
      ),
    );

    final path = await getDownloadsPath();
    final fileName = "${getFormattedTimestamp()}_electricity.pdf";
    final file = File('$path/$fileName');
    await file.writeAsBytes(await pdf.save());

    toast("$fileName ကိုသိမ်းပြီးပါပြီ!");

    await OpenFile.open(file.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          title: Text("Result"),
        ),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Table(
                  border: TableBorder.all(),
                  columnWidths: {
                    0: FlexColumnWidth(1.2), // Adjust column widths
                    1: FlexColumnWidth(1.5),
                    2: FlexColumnWidth(2),
                    3: FlexColumnWidth(2),
                  },
                  children: [
                    TableRow(
                      decoration: BoxDecoration(color: Colors.amberAccent),
                      children: [
                        tableCell("No", isHeader: true),
                        tableCell("Meter\n(units)", isHeader: true),
                        tableCell("Cost", isHeader: true),
                        tableCell("Service charge 250+", isHeader: true),
                      ],
                    ),
                    ...data.entries.map((entry) {
                      return TableRow(children: [
                        tableCell(entry.key),
                        tableCell(entry.value.totalMeter.toString()),
                        tableCell("${entry.value.cost} Ks"),
                        tableCell("${entry.value.cost + 250} Ks"),
                      ]);
                    }),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text("Date : ${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}"),
                ),
                SizedBox(
                  height: 20,
                ),
                TextButton(
                    style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.all<Color>(Colors.amber)),
                    onPressed: generatePdf,
                    child: Text(
                      "pdf ထုတ်ရန်",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ))
              ],
            ))

        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
