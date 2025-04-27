import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../models/course.dart';
import 'dart:io';

class CourseService {
  final _courseRef = FirebaseFirestore.instance.collection('courses');

  Future<void> createCourse(Course course) async {
    await _courseRef.add(course.toMap());
  }

  Stream<List<Course>> getCourses() {
    return _courseRef.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Course.fromMap(doc.id, doc.data())).toList();
    });
  }

  Future<String> uploadFile(File file, String path) async {
    final ref = FirebaseStorage.instance.ref().child(path);
    final upload = await ref.putFile(file);
    return await upload.ref.getDownloadURL();
  }

  Future<String> uploadVideoFile(File file) async {
    final ref = FirebaseStorage.instance.ref().child('videos/${file.path.split('/').last}');
    final uploadTask = await ref.putFile(file);
    return await uploadTask.ref.getDownloadURL();
  }
}
