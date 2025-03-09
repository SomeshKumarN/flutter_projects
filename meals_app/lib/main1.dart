import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(FinancialCalculatorApp());

class FinancialCalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Financial Calculator',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        textTheme: TextTheme(
          titleLarge: TextStyle(
              color: Colors.teal.shade900, fontWeight: FontWeight.bold),
        ),
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Financial Calculator'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          CalculatorTile(
              title: 'Loan Calculator', destination: LoanCalculator()),
          CalculatorTile(
              title: 'Inflation Calculator',
              destination: InflationCalculator()),
          CalculatorTile(
              title: 'Future Value Calculator',
              destination: FutureValueCalculator()),
          CalculatorTile(
              title: 'Investment Plan Calculator (India)',
              destination: InvestmentPlanCalculator()),
        ],
      ),
    );
  }
}

class CalculatorTile extends StatelessWidget {
  final String title;
  final Widget destination;

  CalculatorTile({required this.title, required this.destination});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.teal.shade50,
      margin: EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: ListTile(
        title: Text(title, style: TextStyle(fontWeight: FontWeight.w600)),
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.teal),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destination),
        ),
      ),
    );
  }
}

class LoanCalculator extends StatefulWidget {
  @override
  _LoanCalculatorState createState() => _LoanCalculatorState();
}

class _LoanCalculatorState extends State<LoanCalculator> {
  final TextEditingController principalController = TextEditingController();
  final TextEditingController rateController = TextEditingController();
  final TextEditingController tenureController = TextEditingController();

  double emiResult = 0.0;

  void calculateEMI() {
    double principal = double.parse(principalController.text);
    double rate = double.parse(rateController.text) / 12 / 100;
    int tenure = int.parse(tenureController.text);

    emiResult = (principal * rate * pow(1 + rate, tenure)) /
        (pow(1 + rate, tenure) - 1);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Loan Calculator')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            buildInputField(principalController, 'Principal Amount'),
            buildInputField(rateController, 'Annual Interest Rate (%)'),
            buildInputField(tenureController, 'Tenure (Months)'),
            SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: calculateEMI,
              child: Text('Calculate EMI'),
            ),
            SizedBox(height: 16),
            Text('EMI: ₹${emiResult.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }

  Widget buildInputField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }
}

class InflationCalculator extends StatefulWidget {
  @override
  _InflationCalculatorState createState() => _InflationCalculatorState();
}

class _InflationCalculatorState extends State<InflationCalculator> {
  final TextEditingController currentValueController = TextEditingController();
  final TextEditingController inflationRateController = TextEditingController();
  final TextEditingController yearsController = TextEditingController();

  double futureValue = 0.0;

  void calculateFutureValue() {
    double currentValue = double.parse(currentValueController.text);
    double rate = double.parse(inflationRateController.text) / 100;
    int years = int.parse(yearsController.text);

    futureValue = currentValue * pow(1 + rate, years);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Inflation Calculator')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            buildInputField(currentValueController, 'Current Value (₹)'),
            buildInputField(
                inflationRateController, 'Annual Inflation Rate (%)'),
            buildInputField(yearsController, 'Number of Years'),
            SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: calculateFutureValue,
              child: Text('Calculate Future Value'),
            ),
            SizedBox(height: 16),
            Text('Future Value: ₹${futureValue.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }

  Widget buildInputField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }
}

class FutureValueCalculator extends StatefulWidget {
  @override
  _FutureValueCalculatorState createState() => _FutureValueCalculatorState();
}

class _FutureValueCalculatorState extends State<FutureValueCalculator> {
  final TextEditingController principalController = TextEditingController();
  final TextEditingController rateController = TextEditingController();
  final TextEditingController yearsController = TextEditingController();

  double futureValue = 0.0;

  void calculateFutureValue() {
    double principal = double.parse(principalController.text);
    double rate = double.parse(rateController.text) / 100;
    int years = int.parse(yearsController.text);

    futureValue = principal * pow(1 + rate, years);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Future Value Calculator')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            buildInputField(principalController, 'Principal Amount (₹)'),
            buildInputField(rateController, 'Annual Interest Rate (%)'),
            buildInputField(yearsController, 'Number of Years'),
            SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: calculateFutureValue,
              child: Text('Calculate Future Value'),
            ),
            SizedBox(height: 16),
            Text('Future Value: ₹${futureValue.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }

  Widget buildInputField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }
}

class InvestmentPlanCalculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Investment Plan Calculator (India)')),
      body: Center(
        child: Text(
          'Coming Soon: SIP, PPF, FD, and NPS Calculators!',
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
