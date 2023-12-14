import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key, this.idText});
  final String? idText;

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  List<Map<String, dynamic>> searchResults = [];
  TextEditingController idController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.idText != null) {
      searchDatabase(widget.idText!);
    }
  }

  void searchDatabase(String plantId) async {
    final int? id = int.tryParse(plantId);
    if (id != null) {
      final response = await Supabase.instance.client
          .from('insurance')
          .select()
          .eq('id', id)
          .execute();

      if (response == null) {
        // Handle error
        print('Error when fetching data: ${response}');
        // Show a dialog or a snackbar
      } else {
        setState(() {
          searchResults = List<Map<String, dynamic>>.from(response.data ?? []);
        });
      }
    } else {
      print('Invalid ID entered: $plantId');
      // Handle invalid ID input
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff21b792),
      appBar: AppBar(
        title: Text(" Information"),
      ),
      body: ListView.builder(
        itemCount: searchResults.length,
        itemBuilder: (context, index) {
          final item = searchResults[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    width: 500,
                    height: 800,
                    color: Color(0xff21b792),
                  ),
                  Positioned(
                    top: 80,
                    left: 200,
                    child: Text(' ${item['company_name'] ?? 'No name'}',
                        style: TextStyle(fontSize: 30, color: Colors.white)),
                  ),
                  Positioned(
                    top: 120,
                    left: 200,
                    child: Text('weeks ${item['age'] ?? 'Not available'}',
                        style:
                            TextStyle(fontSize: 16, color: Colors.grey[200])),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
