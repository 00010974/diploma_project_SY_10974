import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../models/lesson.dart';

class LessonService {
  CollectionReference lessonsRef(String courseId) =>
      FirebaseFirestore.instance.collection('courses/$courseId/lessons');

  Future<void> addLesson(String courseId, Lesson lesson) async {
    await lessonsRef(courseId).add(lesson.toMap());
  }

  Future<void> deleteLesson(String courseId, String lessonId) async {
    await lessonsRef(courseId).doc(lessonId).delete();
  }

  Future<void> updateLesson(String courseId, String lessonId, Lesson lesson) async {
    await lessonsRef(courseId).doc(lessonId).update(lesson.toMap());
  }

  Stream<List<Lesson>> getLessons(String courseId) {
    return lessonsRef(courseId).snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => Lesson.fromMap(doc.id, doc.data() as Map<String, dynamic>))
          .toList();
    });
  }

  Future<String> uploadFile(File file, String path) async {
    final ref = FirebaseStorage.instance.ref().child(path);
    await ref.putFile(file);
    return await ref.getDownloadURL();
  }
}
