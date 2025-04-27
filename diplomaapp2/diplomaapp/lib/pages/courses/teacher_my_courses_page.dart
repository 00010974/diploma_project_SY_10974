// import 'package:flutter/material.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:diplomaapp/pages/dashboard/instructor_dashboard.dart';

// class TeacherMyCoursesPage extends StatefulWidget {
//   const TeacherMyCoursesPage({super.key});

//   @override
//   State<TeacherMyCoursesPage> createState() => _TeacherMyCoursesPageState();
// }

// class _TeacherMyCoursesPageState extends State<TeacherMyCoursesPage> {
//   String selectedCategory = 'All';
//   List<String> categories = [
//     'All',
//     'Trending',
//     'IT & Software',
//     'Design',
//     'Marketing',
//     'Science',
//     'Law',
//     'Language',
//   ];

//   Future<List<Map<String, dynamic>>> _fetchCourses() async {
//     final user = Supabase.instance.client.auth.currentUser;
//     if (user == null) return [];

//     final query = Supabase.instance.client
//         .from('courses')
//         .select()
//         .eq('teacher_id', user.id);

//     if (selectedCategory != 'All') {
//       query.eq('category', selectedCategory);
//     }

//     final response = await query;
//     return List<Map<String, dynamic>>.from(response);
//   }

//   Future<void> _deleteCourse(String courseId) async {
//     await Supabase.instance.client
//         .from('courses')
//         .delete()
//         .eq('id', courseId);
//     setState(() {}); // обновить список
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF9F9F9),
//       appBar: AppBar(
//         title: const Text('My Courses'),
//         centerTitle: true,
//         backgroundColor: Colors.white,
//         elevation: 1,
//         foregroundColor: Colors.black,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.pushAndRemoveUntil(
//               context,
//               MaterialPageRoute(builder: (_) => const InstructorDashboard()),
//               (route) => false,
//             );
//           },
//         ),
//       ),
//       body: Column(
//         children: [
//           const SizedBox(height: 16),
//           _buildCategoryFilter(),
//           const SizedBox(height: 16),
//           Expanded(
//             child: FutureBuilder<List<Map<String, dynamic>>>(
//               future: _fetchCourses(),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return const Center(child: CircularProgressIndicator());
//                 }

//                 final courses = snapshot.data ?? [];
//                 if (courses.isEmpty) {
//                   return const Center(child: Text('No courses found.'));
//                 }

//                 return GridView.builder(
//                   padding: const EdgeInsets.all(16),
//                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 4,
//                     crossAxisSpacing: 26,
//                     mainAxisSpacing: 16,
//                     childAspectRatio: 2 / 2,
//                   ),
//                   itemCount: courses.length,
//                   itemBuilder: (context, index) {
//                     final course = courses[index];
//                     return _buildCourseCard(course);
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildCategoryFilter() {
//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       child: Row(
//         children: categories.map((cat) {
//           final isSelected = selectedCategory == cat;
//           return Padding(
//             padding: const EdgeInsets.only(right: 8),
//             child: ChoiceChip(
//               label: Text(cat),
//               selected: isSelected,
//               onSelected: (_) {
//                 setState(() {
//                   selectedCategory = cat;
//                 });
//               },
//               selectedColor: const Color(0xFF6A5AE0),
//               backgroundColor: Colors.grey[200],
//               labelStyle: TextStyle(
//                 color: isSelected ? Colors.white : Colors.black,
//               ),
//             ),
//           );
//         }).toList(),
//       ),
//     );
//   }

//   Widget _buildCourseCard(Map<String, dynamic> course) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.1),
//             spreadRadius: 4,
//             blurRadius: 8,
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           ClipRRect(
//             borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
//             child: Image.network(
//               course['thumbnail_url'] ?? 'https://i.imgur.com/BoN9kdC.png',
//               height: 160,
//               width: double.infinity,
//               fit: BoxFit.cover,
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   course['title'] ?? 'No Title',
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis,
//                   style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   course['category'] ?? 'No Category',
//                   style: const TextStyle(color: Colors.grey),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   "\$${(course['price'] ?? 0).toString()}",
//                   style: const TextStyle(color: Colors.deepPurple, fontSize: 14),
//                 ),
//                 const SizedBox(height: 8),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     IconButton(
//                       icon: const Icon(Icons.edit, size: 20),
//                       onPressed: () {
//                         // TODO: Реализовать редактирование курса
//                       },
//                     ),
//                     IconButton(
//                       icon: const Icon(Icons.save, size: 20),
//                       onPressed: () {
//                         // TODO: Реализовать сохранение изменений
//                       },
//                     ),
//                     IconButton(
//                       icon: const Icon(Icons.delete, size: 20, color: Colors.redAccent),
//                       onPressed: () {
//                         _deleteCourse(course['id']); // удалить курс
//                       },
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }






























import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TeacherMyCoursesPage extends StatefulWidget {
  const TeacherMyCoursesPage({super.key});

  @override
  State<TeacherMyCoursesPage> createState() => _TeacherMyCoursesPageState();
}

class _TeacherMyCoursesPageState extends State<TeacherMyCoursesPage> {
  String selectedCategory = 'All';
  List<String> categories = [
    'All', 'Trending', 'IT & Software', 'Design', 'Marketing', 'Science', 'Law', 'Language',
  ];

  Future<List<Map<String, dynamic>>> _fetchCourses() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) return [];

    final query = Supabase.instance.client
        .from('courses')
        .select()
        .eq('teacher_id', user.id);

    if (selectedCategory != 'All') {
      query.eq('category', selectedCategory);
    }

    final response = await query;
    return List<Map<String, dynamic>>.from(response);
  }

  Future<void> _deleteCourse(String courseId) async {
    await Supabase.instance.client
        .from('courses')
        .delete()
        .eq('id', courseId);
    setState(() {}); // Refresh после удаления
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        title: const Text('My Courses'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
        foregroundColor: Colors.black,
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          _buildCategoryFilter(),
          const SizedBox(height: 16),
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: _fetchCourses(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                final courses = snapshot.data ?? [];
                if (courses.isEmpty) {
                  return const Center(child: Text('No courses found.'));
                }

                return GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 4 / 4,
                  ),
                  itemCount: courses.length,
                  itemBuilder: (context, index) {
                    final course = courses[index];
                    return _buildCourseCard(course);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryFilter() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: categories.map((cat) {
          final isSelected = selectedCategory == cat;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: Text(cat),
              selected: isSelected,
              onSelected: (_) {
                setState(() {
                  selectedCategory = cat;
                });
              },
              selectedColor: const Color(0xFF6A5AE0),
              backgroundColor: Colors.grey[200],
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildCourseCard(Map<String, dynamic> course) {
    return Container(
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.network(
              course['thumbnail_url'] ?? 'https://st.depositphotos.com/2001755/4215/i/450/depositphotos_42159641-stock-photo-boat-on-water.jpg',
              height: 210,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  course['title'] ?? 'No Title',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                const SizedBox(height: 4),
                Text(
                  course['category'] ?? 'No Category',
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
                const SizedBox(height: 4),
                Text(
                  "\$${(course['price'] ?? 0).toString()}",
                  style: const TextStyle(color: Color(0xFF6A5AE0), fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _smallButton(
                      icon: Icons.edit,
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Edit pressed')),
                        );
                      },
                    ),
                    _smallButton(
                      icon: Icons.delete,
                      onTap: () async {
                        final confirm = await showDialog<bool>(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Delete Course'),
                            content: const Text('Are you sure you want to delete this course?'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context, false),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context, true),
                                child: const Text('Delete', style: TextStyle(color: Colors.red)),
                              ),
                            ],
                          ),
                        );
                        if (confirm == true) {
                          _deleteCourse(course['id']);
                        }
                      },
                    ),
                    _smallButton(
                      icon: Icons.shopping_cart,
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Added to bucket')),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          ),
        ],
      ),
    );
  }

  Widget _smallButton({required IconData icon, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0xFF6A5AE0),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: Colors.white, size: 20),
      ),
    );
  }
}









// import 'package:flutter/material.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// class TeacherMyCoursesPage extends StatefulWidget {
//   const TeacherMyCoursesPage({super.key});

//   @override
//   State<TeacherMyCoursesPage> createState() => _TeacherMyCoursesPageState();
// }

// class _TeacherMyCoursesPageState extends State<TeacherMyCoursesPage> {
//   String selectedCategory = 'All';
//   List<String> categories = [
//     'All',
//     'Trending',
//     'IT & Software',
//     'Design',
//     'Marketing',
//     'Science',
//     'Law',
//     'Language',
//   ];
//   Map<String, bool> _isEditing = {}; // id -> isEditing
//   Map<String, TextEditingController> _titleControllers = {};
//   Map<String, TextEditingController> _priceControllers = {};

//   Future<List<Map<String, dynamic>>> _fetchCourses() async {
//     final user = Supabase.instance.client.auth.currentUser;
//     if (user == null) return [];

//     final query = Supabase.instance.client
//         .from('courses')
//         .select()
//         .eq('teacher_id', user.id);

//     if (selectedCategory != 'All') {
//       query.eq('category', selectedCategory);
//     }

//     final response = await query;
//     return List<Map<String, dynamic>>.from(response);
//   }

//   Future<void> _saveCourse(String courseId) async {
//     final title = _titleControllers[courseId]?.text.trim();
//     final price = double.tryParse(_priceControllers[courseId]?.text.trim() ?? '0') ?? 0;

//     await Supabase.instance.client.from('courses').update({
//       'title': title,
//       'price': price,
//     }).eq('id', courseId);

//     setState(() {
//       _isEditing[courseId] = false;
//     });
//   }

//   Future<void> _deleteCourse(String courseId) async {
//     await Supabase.instance.client.from('courses').delete().eq('id', courseId);
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF9F9F9),
//       appBar: AppBar(
//         title: const Text('My Courses'),
//         centerTitle: true,
//         backgroundColor: Colors.white,
//         elevation: 1,
//         foregroundColor: Colors.black,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () => Navigator.pop(context),
//         ),
//       ),
//       body: Column(
//         children: [
//           const SizedBox(height: 16),
//           _buildCategoryFilter(),
//           const SizedBox(height: 16),
//           Expanded(
//             child: FutureBuilder<List<Map<String, dynamic>>>(
//               future: _fetchCourses(),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return const Center(child: CircularProgressIndicator());
//                 }

//                 final courses = snapshot.data ?? [];
//                 if (courses.isEmpty) {
//                   return const Center(child: Text('No courses found.'));
//                 }

//                 return GridView.builder(
//                   padding: const EdgeInsets.all(16),
//                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 4,
//                     crossAxisSpacing: 16,
//                     mainAxisSpacing: 16,
//                     childAspectRatio: 4 / 4,
//                   ),
//                   itemCount: courses.length,
//                   itemBuilder: (context, index) {
//                     final course = courses[index];
//                     _titleControllers[course['id']] ??= TextEditingController(text: course['title']);
//                     _priceControllers[course['id']] ??= TextEditingController(text: course['price'].toString());
//                     return _buildCourseCard(course);
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildCategoryFilter() {
//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       child: Row(
//         children: categories.map((cat) {
//           final isSelected = selectedCategory == cat;
//           return Padding(
//             padding: const EdgeInsets.only(right: 8),
//             child: ChoiceChip(
//               label: Text(cat),
//               selected: isSelected,
//               onSelected: (_) {
//                 setState(() {
//                   selectedCategory = cat;
//                 });
//               },
//               selectedColor: const Color(0xFF6A5AE0),
//               backgroundColor: Colors.grey[200],
//               labelStyle: TextStyle(
//                 color: isSelected ? Colors.white : Colors.black,
//               ),
//             ),
//           );
//         }).toList(),
//       ),
//     );
//   }

//   Widget _buildCourseCard(Map<String, dynamic> course) {
//     final isEditing = _isEditing[course['id']] ?? false;

//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.1),
//             spreadRadius: 4,
//             blurRadius: 8,
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           ClipRRect(
//             borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
//             child: Image.network(
//               course['thumbnail_url'] ?? 'https://i.imgur.com/BoN9kdC.png',
//               height: 120,
//               width: double.infinity,
//               fit: BoxFit.cover,
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 isEditing
//                     ? TextField(controller: _titleControllers[course['id']])
//                     : Text(course['title'] ?? 'No Title', maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
//                 const SizedBox(height: 4),
//                 isEditing
//                     ? TextField(controller: _priceControllers[course['id']])
//                     : Text("\$${(course['price'] ?? 0).toString()}", style: const TextStyle(color: Colors.deepPurple, fontSize: 14)),
//                 const SizedBox(height: 8),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     IconButton(
//                       icon: Icon(isEditing ? Icons.save : Icons.edit, color: Colors.blueAccent),
//                       onPressed: () {
//                         if (isEditing) {
//                           _saveCourse(course['id']);
//                         } else {
//                           setState(() {
//                             _isEditing[course['id']] = true;
//                           });
//                         }
//                       },
//                     ),
//                     IconButton(
//                       icon: const Icon(Icons.delete, color: Colors.redAccent),
//                       onPressed: () => _deleteCourse(course['id']),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
