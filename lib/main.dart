import 'package:flutter/material.dart';

void main() {
  runApp(const SmartDecisionApp());
}

class SmartDecisionApp extends StatelessWidget {
  const SmartDecisionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Decision Maker',
      theme: ThemeData(
        colorSchemeSeed: Colors.indigo,
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController questionController =
      TextEditingController();

  final List<String> options = [];
  final TextEditingController optionController =
      TextEditingController();

  String result = '';

  void addOption() {
    final value = optionController.text.trim();

    if (value.isEmpty) return;

    setState(() {
      options.add(value);
      optionController.clear();
      result = '';
    });
  }

  void decide() {
    if (questionController.text.trim().isEmpty ||
        options.length < 2) {
      setState(() {
        result = 'প্রশ্ন লিখুন এবং অন্তত ২টি অপশন যোগ করুন।';
      });
      return;
    }

    final now = DateTime.now().millisecondsSinceEpoch;
    final index = now % options.length;

    setState(() {
      result = 'আমার পরামর্শ: ${options[index]}';
    });
  }

  @override
  void dispose() {
    questionController.dispose();
    optionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart Decision Maker'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            const Text(
              'আপনার সিদ্ধান্ত নিতে সাহায্য করুন',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: questionController,
              decoration: const InputDecoration(
                labelText: 'আপনার প্রশ্ন লিখুন',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: optionController,
              decoration: const InputDecoration(
                labelText: 'একটি অপশন লিখুন',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: addOption,
              child: const Text('অপশন যোগ করুন'),
            ),
            const SizedBox(height: 15),
            const Text(
              'আপনার অপশনগুলো:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            ...options.map(
              (option) => ListTile(
                leading: const Icon(Icons.check_circle),
                title: Text(option),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: decide,
              child: const Text('সিদ্ধান্ত নিন'),
            ),
            const SizedBox(height: 20),
            if (result.isNotEmpty)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Text(
                    result,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
