import 'package:flutter/material.dart';

class AddEventModal extends StatefulWidget {
  final Function(Map<String, dynamic>) onAdd;

  const AddEventModal({super.key, required this.onAdd});

  @override
  State<AddEventModal> createState() => _AddEventModalState();
}

class _AddEventModalState extends State<AddEventModal> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _subtitleController = TextEditingController();
  TimeOfDay? _selectedTime;
  String _selectedCategory = 'Envato Mastery';

  final List<String> _categories = [
    'Envato Mastery',
    'UI/UX Design Basic',
    'Mastering Git & Vercel App',
    'Live Class',
  ];

  void _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void _submit() {
    if (_formKey.currentState!.validate() && _selectedTime != null) {
      widget.onAdd({
        'title': _titleController.text,
        'subtitle': _subtitleController.text,
        'time': _selectedTime!.format(context),
        'startHour': _selectedTime!.hour,
        'color': _getColorByCategory(_selectedCategory),
      });
      Navigator.of(context).pop();
    }
  }

  Color _getColorByCategory(String category) {
    switch (category) {
      case 'Envato Mastery':
        return Colors.orange[100]!;
      case 'UI/UX Design Basic':
        return Colors.purple[100]!;
      case 'Mastering Git & Vercel App':
        return Colors.green[100]!;
      case 'Live Class':
        return Colors.yellow[100]!;
      default:
        return Colors.grey[200]!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: SingleChildScrollView( // <--- скролл здесь
        padding: EdgeInsets.only(
          top: 24,
          left: 24,
          right: 24,
          bottom: MediaQuery.of(context).viewInsets.bottom + 24,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Add New Event",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: "Title",
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Enter a title' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _subtitleController,
                decoration: const InputDecoration(
                  labelText: "Subtitle",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                items: _categories
                    .map((cat) => DropdownMenuItem(
                          value: cat,
                          child: Text(cat),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value!;
                  });
                },
                decoration: const InputDecoration(
                  labelText: "Category",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: _pickTime,
                icon: const Icon(Icons.access_time),
                label: Text(_selectedTime == null
                    ? "Pick Time"
                    : _selectedTime!.format(context)),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6A5AE0),
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text("Add Event", style: TextStyle(color: Colors.white),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
