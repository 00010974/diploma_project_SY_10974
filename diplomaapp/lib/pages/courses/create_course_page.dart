import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import '../../services/course_service.dart';
import '../../models/course.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CreateCoursePage extends StatefulWidget {
  @override
  _CreateCoursePageState createState() => _CreateCoursePageState();
}

class _CreateCoursePageState extends State<CreateCoursePage> {
  final _titleCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  File? _videoFile, _pdfFile;

  final _courseService = CourseService();

  Future<void> _pickVideo() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.video);
    if (result != null) _videoFile = File(result.files.single.path!);
  }

  Future<void> _pickPDF() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
    if (result != null) _pdfFile = File(result.files.single.path!);
  }

  Future<void> _submitCourse() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    String? videoUrl, pdfUrl;

    if (_videoFile != null)
      videoUrl = await _courseService.uploadFile(_videoFile!, 'videos/${DateTime.now()}.mp4');

    if (_pdfFile != null)
      pdfUrl = await _courseService.uploadFile(_pdfFile!, 'pdfs/${DateTime.now()}.pdf');

    final course = Course(
      id: '',
      title: _titleCtrl.text,
      description: _descCtrl.text,
      instructorId: uid,
      videoUrl: videoUrl,
      pdfUrl: pdfUrl,
      enrolledStudents: [],
    );

    await _courseService.createCourse(course);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Курс создан")));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Создать курс")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: _titleCtrl, decoration: InputDecoration(labelText: 'Название курса')),
            TextField(controller: _descCtrl, decoration: InputDecoration(labelText: 'Описание курса')),
            Row(
              children: [
                ElevatedButton(onPressed: _pickVideo, child: Text("Загрузить видео")),
                SizedBox(width: 10),
                ElevatedButton(onPressed: _pickPDF, child: Text("Загрузить PDF")),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: _submitCourse, child: Text("Создать")),
          ],
        ),
      ),
    );
  }
}
