import 'package:hive/hive.dart';
import '../models/course.dart';

class HiveCourseService {
  final String _boxName = 'courses';

  // Добавление нового курса
  Future<void> addCourse(Course course) async {
    final box = await Hive.openBox<Course>(_boxName);
    await box.put(course.id, course);
  }

  // Получение всех курсов
  Future<List<Course>> getAllCourses() async {
    final box = await Hive.openBox<Course>(_boxName);
    return box.values.toList();
  }

  // Получение курса по ID
  Future<Course?> getCourseById(String id) async {
    final box = await Hive.openBox<Course>(_boxName);
    return box.get(id);
  }

  // Удаление курса
  Future<void> deleteCourse(String id) async {
    final box = await Hive.openBox<Course>(_boxName);
    await box.delete(id);
  }

  // Очистка всей базы (осторожно)
  Future<void> clearAllCourses() async {
    final box = await Hive.openBox<Course>(_boxName);
    await box.clear();
  }

  Future<void> enrollStudent(String courseId, String studentId) async {
    final box = await Hive.openBox<Course>('courses');
    final course = box.get(courseId);
    if (course != null && !course.enrolledStudentIds.contains(studentId)) {
      course.enrolledStudentIds.add(studentId);
      await course.save();
    }
  }
}
