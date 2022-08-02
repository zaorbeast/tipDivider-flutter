import 'package:flutter/material.dart';
import 'package:tip_divider/couleurs/Couleurs.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Tip_divider(),
    );
  }
}

class Tip_divider extends StatefulWidget {
  Tip_divider({Key? key}) : super(key: key);

  @override
  State<Tip_divider> createState() => _Tip_dividerState();
}

class _Tip_dividerState extends State<Tip_divider> {
  int _Pourboire = 0;
  int _pourcentage = 0;
  int _Personne = 1;
  double _Montant = 0.0;
  double _totalPersonne = 0.0;
  Color _Vert = Couleur("#19A338");
  Color _Purple = Couleur("#6908D6");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
        child: ListView(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.all(20.5),
          children: [
            Container(
              width: 350,
              height: 200,
              decoration: BoxDecoration(
                color: _Vert.withOpacity(0.2), //Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Total par personne",
                    style: TextStyle(
                      color: _Purple,
                      fontSize: 17.0,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    "\$ ${CalculerMontantTotal(_Montant, _pourcentage, _Personne)}",
                    style: TextStyle(
                        color: _Purple,
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20.0),
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(
                    color: Colors.blueGrey.shade100, style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(children: [
                TextField(
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  style: TextStyle(
                    color: _Purple,
                    fontStyle: FontStyle.italic,
                  ),
                  decoration: InputDecoration(
                      prefixText: "Montant :",
                      prefixIcon: Icon(Icons.attach_money)),
                  onChanged: (String value) {
                    try {
                      _Montant = double.parse(value);
                    } catch (Exception) {
                      _Montant = 0.0;
                    }
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Division",
                      style: TextStyle(
                          color: Colors.grey.shade700,
                          fontStyle: FontStyle.italic,
                          fontSize: 17.0),
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              if (_Personne > 1) {
                                _Personne--;
                              } else {}
                            });
                          },
                          child: Container(
                            width: 40.0,
                            height: 40.0,
                            margin: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: _Purple.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(7.9),
                            ),
                            child: Center(
                              child: Text(
                                "-",
                                style:
                                    TextStyle(color: _Purple, fontSize: 27.0),
                              ),
                            ),
                          ),
                        ),
                        Text(
                          "$_Personne",
                          style: TextStyle(
                              color: _Purple,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              _Personne++;
                            });
                          },
                          child: Container(
                            width: 40.0,
                            height: 40.0,
                            margin: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: _Purple.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(7.9),
                            ),
                            child: Center(
                              child: Text(
                                "+",
                                style:
                                    TextStyle(color: _Purple, fontSize: 27.0),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Pourboir",
                      style: TextStyle(
                          color: Colors.grey.shade700,
                          fontStyle: FontStyle.italic,
                          fontSize: 17.0),
                    ),
                    Padding(
                      padding: EdgeInsets.all(18.0),
                      child: Text(
                          "\$ ${CalculerPourboire(_Montant, _pourcentage)}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: _Purple,
                              fontSize: 17.0)),
                    )
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "$_pourcentage %",
                      style: TextStyle(
                        color: _Purple,
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Slider(
                        min: 0,
                        max: 100,
                        activeColor: _Purple,
                        inactiveColor: Colors.grey.shade600,
                        divisions: 20,
                        value: _pourcentage.toDouble(),
                        onChanged: (double value) {
                          setState(() {
                            _pourcentage = value.round();
                          });
                        })
                  ],
                )
              ]),
            )
          ],
        ),
      ),
    );
  }

  CalculerPourboire(double montant, int pourcentage) {
    double pourboir = (montant * pourcentage) / 100;
    return pourboir;
  }

  CalculerMontantTotal(double montant, int pourcentage, int personne) {
    var Montant =
        (montant + CalculerPourboire(montant, pourcentage)) / personne;
    return Montant.toStringAsFixed(2);
  }
}
