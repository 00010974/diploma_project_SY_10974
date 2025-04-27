import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../models/course.dart';

class CourseService {
  final _courseRef = FirebaseFirestore.instance.collection('courses');

  // создание курса
  Future<void> createCourse(Course course) async {
    await _courseRef.add(course.toMap());
  }

  // получение курсов по роли пользователя
  Stream<List<Course>> getCoursesForUser(String uid, String role) {
    return _courseRef.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) {
            final course = Course.fromMap(doc.id, doc.data());
            if (role == 'teacher') {
              return course.instructorId == uid ? course : null;
            } else {
              return course.studentStatuses.containsKey(uid) ? course : null;
            }
          })
          .whereType<Course>()
          .toList();
    });
  }

  //метод для получения курсов, в которых участвует текущий студент
  Stream<List<Course>> getStudentCourses(String uid) {
    return _courseRef.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) {
            final course = Course.fromMap(doc.id, doc.data());
            return course.studentStatuses.containsKey(uid) ? course : null;
          })
          .whereType<Course>()
          .toList();
       });
    }

  Future<void> enrollInCourse(String courseId, String userId) async {
    final doc = _courseRef.doc(courseId);
    await doc.update({
      'enrolledStudents': FieldValue.arrayUnion([userId]),
      'studentStatuses.$userId': 'in_progress',
    });
  }

  // Future<void> addLessonToCourse(String courseId, Lesson lesson) async {
  //   final lessonRef = _courseRef.doc(courseId).collection('lessons');
  //   await lessonRef.add(lesson.toMap());
  // }

  // загрузка PDF/Docs
  Future<String> uploadFile(File file, String path) async {
    final ref = FirebaseStorage.instance.ref().child(path);
    final upload = await ref.putFile(file);
    return await upload.ref.getDownloadURL();
  }

  // загрузка видео
  Future<String> uploadVideoFile(File file) async {
    final ref = FirebaseStorage.instance.ref().child(
      'videos/${file.path.split('/').last}',
    );
    final uploadTask = await ref.putFile(file);
    return await uploadTask.ref.getDownloadURL();
  }

  // Future<void> enrollInCourse(String courseId, String userId) async {
  //   final doc = _courseRef.doc(courseId);
  //   await doc.update({
  //     'enrolledStudents': FieldValue.arrayUnion([userId]),
  //   });
  // }
}
