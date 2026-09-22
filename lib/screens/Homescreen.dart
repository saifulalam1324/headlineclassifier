import 'package:flutter/material.dart';
import '../service/api_service.dart';
import '../services/api_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController headlineController =
  TextEditingController();

  String? result;
  bool loading = false;

  Future<void> classify() async {
    final headline = headlineController.text.trim();

    if (headline.isEmpty) {
      return;
    }

    setState(() {
      loading = true;
      result = null;
    });

    try {
      final prediction = await ApiService.classifyHeadline(headline);

      setState(() {
        result = prediction;
      });
    } catch (e) {
      print("Flutter Error: $e");

      setState(() {
        result = "Prediction error: $e";
      });
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  void dispose() {
    headlineController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Headline Classifier"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: headlineController,
              maxLines: 5,
              decoration: const InputDecoration(
                hintText: "Enter a news headline...",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: loading ? null : classify,
              child: loading
                  ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(),
              )
                  : const Text("CLASSIFY"),
            ),

            const SizedBox(height: 30),

            if (result != null)
              Text(
                "Prediction: $result",
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
          ],
        ),
      ),
    );
  }
}