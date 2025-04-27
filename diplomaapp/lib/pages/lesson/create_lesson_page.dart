// import 'package:flutter/material.dart';
// import 'package:file_picker/file_picker.dart';
// import 'dart:io';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import '../../models/lesson.dart';

// class CreateLessonPage extends StatefulWidget {
//   final String courseId;

//   const CreateLessonPage({super.key, required this.courseId});

//   @override
//   State<CreateLessonPage> createState() => _CreateLessonPageState();
// }

// class _CreateLessonPageState extends State<CreateLessonPage> {
//   final _titleCtrl = TextEditingController();
//   final _descCtrl = TextEditingController();
//   File? _videoFile, _pdfFile;

//   Future<void> _pickVideo() async {
//     final result = await FilePicker.platform.pickFiles(type: FileType.video);
//     if (result != null) {
//       setState(() {
//         _videoFile = File(result.files.single.path!);
//       });
//     }
//   }

//   Future<void> _pickPDF() async {
//     final result = await FilePicker.platform.pickFiles(
//       type: FileType.custom,
//       allowedExtensions: ['pdf'],
//     );
//     if (result != null) {
//       setState(() {
//         _pdfFile = File(result.files.single.path!);
//       });
//     }
//   }

//   Future<String> _uploadFile(File file, String path) async {
//     final ref = FirebaseStorage.instance.ref().child(path);
//     final upload = await ref.putFile(file);
//     return await upload.ref.getDownloadURL();
//   }

//   Future<void> _createLesson() async {
//     String? videoUrl;
//     String? pdfUrl;

//     if (_videoFile != null) {
//       videoUrl = await _uploadFile(_videoFile!, 'lesson_videos/${DateTime.now().millisecondsSinceEpoch}.mp4');
//     }
//     if (_pdfFile != null) {
//       pdfUrl = await _uploadFile(_pdfFile!, 'lesson_docs/${DateTime.now().millisecondsSinceEpoch}.pdf');
//     }

//     final lesson = Lesson(
//       id: '',
//       title: _titleCtrl.text,
//       description: _descCtrl.text,
//       videoUrl: videoUrl,
//       pdfUrl: pdfUrl,
//       homework: null,
//     );

//     await FirebaseFirestore.instance
//         .collection('courses')
//         .doc(widget.courseId)
//         .collection('lessons')
//         .add(lesson.toMap());

//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('Lesson created!')),
//     );
//     Navigator.pop(context);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Add Lesson")),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               TextField(
//                 controller: _titleCtrl,
//                 decoration: const InputDecoration(labelText: "Lesson Title"),
//               ),
//               const SizedBox(height: 16),
//               TextField(
//                 controller: _descCtrl,
//                 decoration: const InputDecoration(labelText: "Lesson Description"),
//                 maxLines: 4,
//               ),
//               const SizedBox(height: 16),
//               Row(
//                 children: [
//                   ElevatedButton(
//                     onPressed: _pickVideo,
//                     child: const Text("Upload Video"),
//                   ),
//                   const SizedBox(width: 12),
//                   ElevatedButton(
//                     onPressed: _pickPDF,
//                     child: const Text("Upload PDF"),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 32),
//               ElevatedButton(
//                 onPressed: _createLesson,
//                 child: const Text("Create Lesson"),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color(0xFF6A5AE0),
//                   minimumSize: const Size(double.infinity, 48),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import '../../models/lesson.dart';
import '../../services/lesson_service.dart';


class CreateLessonPage extends StatefulWidget {
  final String courseId;

  const CreateLessonPage({super.key, required this.courseId});

  @override
  State<CreateLessonPage> createState() => _CreateLessonPageState();
}

class _CreateLessonPageState extends State<CreateLessonPage> {
  final _titleCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  File? _video, _pdf;

  final _lessonService = LessonService();

  Future<void> _pickVideo() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.video);
    if (result != null) _video = File(result.files.single.path!);
  }

  Future<void> _pickPDF() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
    if (result != null) _pdf = File(result.files.single.path!);
  }

  Future<void> _submitLesson() async {
    String? videoUrl, pdfUrl;
    if (_video != null) {
      videoUrl = await _lessonService.uploadFile(_video!, 'videos/${_video!.path.split('/').last}');
    }
    if (_pdf != null) {
      pdfUrl = await _lessonService.uploadFile(_pdf!, 'pdfs/${_pdf!.path.split('/').last}');
    }

    final lesson = Lesson(
      id: '',
      title: _titleCtrl.text,
      description: _descCtrl.text,
      videoUrl: videoUrl,
      pdfUrl: pdfUrl,
    );

    await _lessonService.addLesson(widget.courseId, lesson);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create Lesson")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: _titleCtrl, decoration: const InputDecoration(labelText: 'Title')),
            TextField(controller: _descCtrl, decoration: const InputDecoration(labelText: 'Description')),
            Row(
              children: [
                ElevatedButton(onPressed: _pickVideo, child: const Text("Pick Video")),
                const SizedBox(width: 10),
                ElevatedButton(onPressed: _pickPDF, child: const Text("Pick PDF")),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _submitLesson, child: const Text("Save Lesson")),
          ],
        ),
      ),
    );
  }
}
