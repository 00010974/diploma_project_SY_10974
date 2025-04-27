// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:diplomaapp/services/course_service.dart';

// class CourseDetailPage extends StatelessWidget {
//   final String title;
//   final _courseService = CourseService();
//   final user = FirebaseAuth.instance.currentUser; 

//   const CourseDetailPage({super.key, required this.title});

//     bool isEnrolled = course.enrolledStudents.contains(user!.uid);

//   if (!isEnrolled)
//     ElevatedButton(
//       onPressed: () async {
//         await _courseService.enrollInCourse(course.id, user.uid);
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text("You have joined the course!")),
//         );
//       },
//       child: const Text("Join Course"),
//     )
//   else
//     const Text("You're enrolled ✅", style: TextStyle(color: Colors.green));

  
  

//   @override
//   Widget build(BuildContext context) {
//     final double progress = 0.45; // Пример прогресса 45%

//     return Scaffold(
//       backgroundColor: const Color(0xFFF9F9F9),
//       appBar: AppBar(
//         title: Text(title),
//         elevation: 0,
//       ),
//       body: ListView(
//         padding: const EdgeInsets.all(24),
//         children: [
//           // Картинка курса
//           Container(
//             height: 180,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(16),
//               image: const DecorationImage(
//                 image: NetworkImage('https://i.imgur.com/Vz6FCOy.png'),
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           const SizedBox(height: 24),

//           // Прогресс
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 "Your Progress",
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 8),
//               LinearProgressIndicator(
//                 value: progress,
//                 backgroundColor: Colors.grey[300],
//                 color: const Color(0xFF6A5AE0),
//                 minHeight: 8,
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               const SizedBox(height: 8),
//               Text("${(progress * 100).toStringAsFixed(1)}% completed",
//                   style: const TextStyle(color: Colors.grey)),
//             ],
//           ),
//           const SizedBox(height: 24),

//           // Описание курса
//           const Text(
//             "About this Course",
//             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 8),
//           const Text(
//             "Learn to master your skills and start generating passive income streams. "
//             "This course includes practical projects, tips and tricks from industry experts.",
//             style: TextStyle(fontSize: 14),
//           ),
//           const SizedBox(height: 24),

//           // Список модулей
//           const Text(
//             "Modules",
//             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 16),
//           _moduleItem(
//               title: "Introduction & Setup", duration: "8 min", completed: true),
//           _moduleItem(
//               title: "Fundamentals of Passive Income", duration: "14 min", completed: true),
//           _moduleItem(
//               title: "Building Your First Product", duration: "22 min", completed: false),
//           _moduleItem(
//               title: "Marketing Strategies", duration: "18 min", completed: false),
//           _moduleItem(
//               title: "Scaling Up Your Business", duration: "30 min", completed: false),
//         ],
//       ),
//     );
//   }

//   Widget _moduleItem({required String title, required String duration, required bool completed}) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 12),
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.05),
//             blurRadius: 6,
//             offset: const Offset(0, 2),
//           )
//         ],
//       ),
//       child: Row(
//         children: [
//           Icon(
//             completed ? Icons.check_circle : Icons.radio_button_unchecked,
//             color: completed ? Colors.green : Colors.grey,
//           ),
//           const SizedBox(width: 16),
//           Expanded(
//             child: Text(
//               title,
//               style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//             ),
//           ),
//           Text(
//             duration,
//             style: const TextStyle(color: Colors.grey, fontSize: 12),
//           ),
//         ],
//       ),
//     );
//   }

// }



import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:diplomaapp/services/course_service.dart';
import 'package:diplomaapp/models/course.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diplomaapp/models/lesson.dart';
import 'package:diplomaapp/models/course.dart';
import 'package:diplomaapp/models/homework.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'dart:io';





class CourseDetailPage extends StatelessWidget {
  final Course course;
  final CourseService _courseService = CourseService();

  CourseDetailPage({super.key, required this.course});

  Future<void> _uploadHomework(String courseId, String userId, BuildContext context) async {
    final result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['pdf', 'docx']);
    if (result == null) return;

    final file = File(result.files.single.path!);
    final fileName = '${userId}_${DateTime.now().millisecondsSinceEpoch}.${result.files.single.extension}';

    final ref = FirebaseStorage.instance.ref().child('homework/$courseId/$fileName');
    final uploadTask = await ref.putFile(file);
    final downloadUrl = await uploadTask.ref.getDownloadURL();

    await FirebaseFirestore.instance.collection('courses').doc(courseId).update({
      'studentStatuses.$userId.homeworkUrl': downloadUrl,
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("✅ Homework uploaded!")),
    );
  }

  Future<void> _saveHomeworkHive(Course course, String userId, BuildContext context) async {
    final result = await FilePicker.platform.pickFiles(type: FileType.any);
    if (result == null) return;

    final filePath = result.files.single.path!;
    course.homework[userId] = filePath;

    final box = await Hive.openBox<Course>('courses');
    await box.put(course.id, course);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("📝 Homework saved locally!")),
    );
  }


  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    final bool isEnrolled = course.studentStatuses.containsKey(user.uid);
    final double progress = 0.45;

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        title: Text(course.title),
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          // Course banner
          Container(
            height: 180,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: const DecorationImage(
                image: NetworkImage('https://i.imgur.com/Vz6FCOy.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Join Course Button
          isEnrolled
              ? const Text("You're enrolled ✅", style: TextStyle(color: Colors.green))
              : ElevatedButton(
                  onPressed: () async {
                    await _courseService.enrollInCourse(course.id, user.uid);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("You have joined the course!")),
                    );
                  },
                  child: const Text("Join Course"),
                ),

          const SizedBox(height: 24),

          // Progress
          const Text("Your Progress", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey[300],
            color: const Color(0xFF6A5AE0),
            minHeight: 8,
            borderRadius: BorderRadius.circular(8),
          ),
          const SizedBox(height: 8),
          Text("${(progress * 100).toStringAsFixed(1)}% completed", style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 24),

          // Description
          const Text("About this Course", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(course.description, style: const TextStyle(fontSize: 14)),
          const SizedBox(height: 24),

          // Modules
          const Text("Modules", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _moduleItem(title: "Intro & Setup", duration: "8 min", completed: true),
          _moduleItem(title: "Passive Income Basics", duration: "14 min", completed: false),
          if (user.uid == course.instructorId && course.homework.isNotEmpty) ...[
            const SizedBox(height: 32),
            const Text("📥 Submitted Homework", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ...course.homework.entries.map((entry) {
              final studentId = entry.key;
              final filePath = entry.value;

              return ListTile(
                leading: const Icon(Icons.description),
                title: Text("Student ID: $studentId"),
                subtitle: Text("File: ${filePath.split('/').last}"),
                trailing: IconButton(
                  icon: const Icon(Icons.open_in_new),
                  onPressed: () {
                    // Открыть файл
                  },
                ),
              );
            }).toList(),
          ],
          if (isEnrolled) ...[
            const SizedBox(height: 24),
            const Text("Homework Upload", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: () => _uploadHomework(course.id, user.uid, context),
              icon: const Icon(Icons.upload_file),
              label: const Text("Upload Homework"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
            ),
          ],
          if (isEnrolled) ...[
            const SizedBox(height: 24),
            const Text("Upload Local Homework", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: () => _saveHomeworkHive(course, user.uid, context),
              icon: const Icon(Icons.save_alt),
              label: const Text("Save Homework to Device"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
              ),
          ],
        ],
      ),
    );
  }

  Widget _moduleItem({required String title, required String duration, required bool completed}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: Row(
        children: [
          Icon(
            completed ? Icons.check_circle : Icons.radio_button_unchecked,
            color: completed ? Colors.green : Colors.grey,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          ),
          Text(duration, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        ],
      ),
    );
  }
}

