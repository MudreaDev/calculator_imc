import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator IMC',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        useMaterial3: true,
      ),
      home: const BmiCalculatorPage(),
    );
  }
}

class BmiCalculatorPage extends StatefulWidget {
  const BmiCalculatorPage({super.key});

  @override
  State<BmiCalculatorPage> createState() => _BmiCalculatorPageState();
}

class _BmiCalculatorPageState extends State<BmiCalculatorPage> {
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();

  String _result = '';
  Color _resultColor = Colors.black;

  void _calculateBmi() {
    final String weightText = _weightController.text.trim();
    final String heightText = _heightController.text.trim();

    if (weightText.isEmpty || heightText.isEmpty) {
      setState(() {
        _result = 'Introduceți greutatea și înălțimea.';
        _resultColor = Colors.red;
      });
      return;
    }

    final double? weight = double.tryParse(weightText.replaceAll(',', '.'));
    final double? heightCm = double.tryParse(heightText.replaceAll(',', '.'));

    if (weight == null || heightCm == null || weight <= 0 || heightCm <= 0) {
      setState(() {
        _result = 'Introduceți valori numerice valide.';
        _resultColor = Colors.red;
      });
      return;
    }

    final double heightM = heightCm / 100;
    final double bmi = weight / (heightM * heightM);

    String category;
    Color color;

    if (bmi < 18.5) {
      category = 'Subponderal';
      color = Colors.orange;
    } else if (bmi < 25) {
      category = 'Normal';
      color = Colors.green;
    } else if (bmi < 30) {
      category = 'Supraponderal';
      color = Colors.orange;
    } else if (bmi < 35) {
      category = 'Obezitate grad I';
      color = Colors.red;
    } else if (bmi < 40) {
      category = 'Obezitate grad II';
      color = Colors.red;
    } else {
      category = 'Obezitate grad III';
      color = Colors.red.shade900;
    }

    setState(() {
      _result = 'IMC: ${bmi.toStringAsFixed(2)}\nCategorie: $category';
      _resultColor = color;
    });
  }

  @override
  void dispose() {
    _weightController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator IMC'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            const Icon(Icons.monitor_weight, size: 80, color: Colors.teal),
            const SizedBox(height: 30),

            // TextField pentru greutate
            TextField(
              controller: _weightController,
              keyboardType:
              const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Greutate (kg)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.fitness_center),
              ),
            ),
            const SizedBox(height: 16),

            // TextField pentru înălțime
            TextField(
              controller: _heightController,
              keyboardType:
              const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Înălțime (cm)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.height),
              ),
            ),
            const SizedBox(height: 24),

            // Butonul de calcul
            ElevatedButton(
              onPressed: _calculateBmi,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
              ),
              child: const Text(
                'Calculează IMC',
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 30),

            // Rezultatul
            Text(
              _result,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: _resultColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}