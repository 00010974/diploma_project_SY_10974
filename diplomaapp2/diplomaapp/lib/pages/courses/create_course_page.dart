import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:diplomaapp/pages/dashboard/instructor_dashboard.dart';

class CreateCoursePage extends StatefulWidget {
  const CreateCoursePage({super.key});

  @override
  State<CreateCoursePage> createState() => _CreateCoursePageState();
}

class _CreateCoursePageState extends State<CreateCoursePage> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _categoryController = TextEditingController();
  File? _pickedImage;
  bool _isLoading = false;
  String? _error;

  Future<void> _pickImage() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null && result.files.single.path != null) {
      setState(() {
        _pickedImage = File(result.files.single.path!);
      });
    }
  }

  Future<void> _createCourse() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) return;

    final title = _titleController.text.trim();
    final description = _descriptionController.text.trim();
    final priceText = _priceController.text.trim();
    final category = _categoryController.text.trim();

    if (title.isEmpty || description.isEmpty || priceText.isEmpty || category.isEmpty) {
      setState(() => _error = "Please fill all fields.");
      return;
    }

    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      String? imageUrl;
      if (_pickedImage != null) {
        final fileName = DateTime.now().millisecondsSinceEpoch.toString();
        final storageResponse = await Supabase.instance.client.storage
            .from('course-thumbnails')
            .uploadBinary('thumbnails/$fileName.png', await _pickedImage!.readAsBytes());

        if (storageResponse.isNotEmpty) {
          imageUrl = Supabase.instance.client.storage
              .from('course-thumbnails')
              .getPublicUrl('thumbnails/$fileName.png');
        }
      }

      imageUrl ??= 'https://st.depositphotos.com/2001755/4215/i/450/depositphotos_42159641-stock-photo-boat-on-water.jpg';

      await Supabase.instance.client.from('courses').insert({
        'title': title,
        'description': description,
        'teacher_id': user.id,
        'price': double.tryParse(priceText) ?? 0,
        'category': category,
        'thumbnail_url': imageUrl,
        'created_at': DateTime.now().toIso8601String(),
      });

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Course created successfully!")),
      );
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const InstructorDashboard()),
        (route) => false,
      );
    } catch (e) {
      setState(() => _error = "Error creating course: $e");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create New Course'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
        foregroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const InstructorDashboard()),
            (route) => false,
          ),
        ),
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 600),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 5,
                blurRadius: 10,
              ),
            ],
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _textField("Course Title", _titleController),
                const SizedBox(height: 16),
                _textField("Course Description", _descriptionController, maxLines: 5),
                const SizedBox(height: 16),
                _textField("Price (e.g., 59.99)", _priceController),
                const SizedBox(height: 16),
                _textField("Category (e.g., IT, Design, Marketing)", _categoryController),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _pickImage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6A5AE0),
                    minimumSize: const Size(double.infinity, 48),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text("Pick Course Image", style: TextStyle(color: Colors.white),),
                ),
                if (_pickedImage != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Image.file(_pickedImage!, height: 120),
                  ),
                if (_error != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(_error!, style: const TextStyle(color: Colors.red)),
                  ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _isLoading ? null : _createCourse,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6A5AE0),
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text("Save", style: TextStyle(fontSize: 18, color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: const Color(0xFFF9F9F9),
    );
  }

  Widget _textField(String hint, TextEditingController controller, {int maxLines = 1}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
