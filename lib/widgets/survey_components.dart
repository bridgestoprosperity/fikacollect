// survey_components.dart

import 'package:flutter/material.dart';

// Multiple Choice Component
class MultipleChoiceCard extends StatefulWidget {
  final String question;
  final List<String> options;
  final Function(String) onChanged;
  final String? initialValue;

  const MultipleChoiceCard({
    super.key,
    required this.question,
    required this.options,
    required this.onChanged,
    this.initialValue,
  });

  @override
  State<MultipleChoiceCard> createState() => _MultipleChoiceCardState();
}

class _MultipleChoiceCardState extends State<MultipleChoiceCard> {
  String? _selectedOption;

  @override
  void initState() {
    super.initState();
    _selectedOption = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.question,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            ...widget.options.map((option) => ListTile(
                  title: Text(option),
                  leading: Radio<String>(
                    value: option,
                    groupValue: _selectedOption,
                    onChanged: (String? value) {
                      setState(() {
                        _selectedOption = value;
                      });
                      if (value != null) {
                        widget.onChanged(value);
                      }
                    },
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

// Short Answer Component
class ShortAnswerCard extends StatelessWidget {
  final String question;
  final Function(String) onChanged;
  final String? initialValue;
  final String? hintText;

  const ShortAnswerCard({
    super.key,
    required this.question,
    required this.onChanged,
    this.initialValue,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              question,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              initialValue: initialValue,
              decoration: InputDecoration(
                hintText: hintText ?? 'Enter your answer',
                border: const OutlineInputBorder(),
              ),
              onChanged: onChanged,
            ),
          ],
        ),
      ),
    );
  }
}

// Long Answer Component
class LongAnswerCard extends StatelessWidget {
  final String question;
  final Function(String) onChanged;
  final String? initialValue;
  final String? hintText;

  const LongAnswerCard({
    super.key,
    required this.question,
    required this.onChanged,
    this.initialValue,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              question,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              initialValue: initialValue,
              decoration: InputDecoration(
                hintText: hintText ?? 'Enter your detailed response',
                border: const OutlineInputBorder(),
              ),
              maxLines: 4,
              onChanged: onChanged,
            ),
          ],
        ),
      ),
    );
  }
}