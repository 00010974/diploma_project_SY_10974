class Course {
  final String id;
  final String title;
  final String description;
  final String instructorId;
  final String? videoUrl;
  final String? pdfUrl;
  final List<String> enrolledStudents;

  Course({
    required this.id,
    required this.title,
    required this.description,
    required this.instructorId,
    this.videoUrl,
    this.pdfUrl,
    required this.enrolledStudents,
  });

  factory Course.fromMap(String id, Map<String, dynamic> data) {
    return Course(
      id: id,
      title: data['title'],
      description: data['description'],
      instructorId: data['instructorId'],
      videoUrl: data['videoUrl'],
      pdfUrl: data['pdfUrl'],
      enrolledStudents: List<String>.from(data['enrolledStudents'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'instructorId': instructorId,
      'videoUrl': videoUrl,
      'pdfUrl': pdfUrl,
      'enrolledStudents': enrolledStudents,
    };
  }
}
