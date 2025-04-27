// import 'package:flutter/material.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
// import '../widgets/sidebar.dart';
// import '../widgets/topbar.dart';
// import '../widgets/search_overlay.dart'; // ✅ добавил сюда

// class DiscoverPage extends StatefulWidget {
//   const DiscoverPage({super.key});

//   @override
//   State<DiscoverPage> createState() => _DiscoverPageState();
// }

// class _DiscoverPageState extends State<DiscoverPage> {
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
//     var query = Supabase.instance.client.from('courses').select();
//     if (selectedCategory != 'All') {
//       query = query.eq('category', selectedCategory);
//     }
//     final response = await query;
//     return List<Map<String, dynamic>>.from(response);
//   }

//   Future<bool> _isAddedToBucket(String courseId) async {
//     final user = Supabase.instance.client.auth.currentUser;
//     if (user == null) return false;

//     final existing = await Supabase.instance.client
//         .from('bucket_courses')
//         .select()
//         .eq('student_id', user.id)
//         .eq('course_id', courseId)
//         .maybeSingle();

//     return existing != null;
//   }

//   Future<void> _addToBucket(String courseId) async {
//     final user = Supabase.instance.client.auth.currentUser;
//     if (user == null) return;

//     final alreadyAdded = await _isAddedToBucket(courseId);
//     if (alreadyAdded) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Already added to Bucket")),
//       );
//       return;
//     }

//     await Supabase.instance.client.from('bucket_courses').insert({
//       'student_id': user.id,
//       'course_id': courseId,
//     });

//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text("Added to Bucket!")),
//     );

//     setState(() {});
//   }

//   void _openSearch() {
//     showDialog(
//       context: context,
//       builder: (_) => const SearchOverlay(),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Row(
//         children: [
//           const Sidebar(selectedMenu: "Discover"),
//           Expanded(
//             child: Column(
//               children: [
//                 TopBar(
//                   pageTitle: 'Discover Courses',
//                   onSearchPressed: _openSearch,
//                 ),
//                 const SizedBox(height: 16),
//                 _buildCategoryFilter(),
//                 const SizedBox(height: 16),
//                 Expanded(
//                   child: FutureBuilder<List<Map<String, dynamic>>>(
//                     future: _fetchCourses(),
//                     builder: (context, snapshot) {
//                       if (snapshot.connectionState == ConnectionState.waiting) {
//                         return const Center(child: CircularProgressIndicator());
//                       }
//                       final courses = snapshot.data ?? [];
//                       if (courses.isEmpty) {
//                         return const Center(child: Text('No courses available.'));
//                       }
//                       return GridView.builder(
//                         padding: const EdgeInsets.all(16),
//                         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                           crossAxisCount: 4,
//                           crossAxisSpacing: 16,
//                           mainAxisSpacing: 16,
//                           childAspectRatio: 4 / 4.2,
//                         ),
//                         itemCount: courses.length,
//                         itemBuilder: (context, index) {
//                           final course = courses[index];
//                           return _buildCourseCard(course);
//                         },
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//       backgroundColor: const Color(0xFFF9F9F9),
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
//     final courseId = course['id'];
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
//               height: 150,
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
//                   course['category'] ?? 'Unknown Category',
//                   style: const TextStyle(color: Colors.grey, fontSize: 13),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   "\$${(course['price'] ?? 0).toString()}",
//                   style: const TextStyle(color: Color(0xFF6A5AE0), fontSize: 14),
//                 ),
//                 const SizedBox(height: 8),
//                 FutureBuilder<bool>(
//                   future: _isAddedToBucket(courseId),
//                   builder: (context, snapshot) {
//                     final alreadyAdded = snapshot.data ?? false;
//                     return ElevatedButton.icon(
//                       onPressed: alreadyAdded ? null : () => _addToBucket(courseId),
//                       icon: alreadyAdded ? const Icon(Icons.check) : const Icon(Icons.add_shopping_cart),
//                       label: alreadyAdded ? const Text("Added") : const Text("Add to Bucket"),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: const Color(0xFF6A5AE0),
//                         foregroundColor: Colors.white,
//                         minimumSize: const Size(double.infinity, 40),
//                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//                       ),
//                     );
//                   },
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
import '../widgets/sidebar.dart';
import '../widgets/topbar.dart';
import '../widgets/search_overlay.dart';
import '../courses/course_page.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  String selectedCategory = 'All';
  List<String> categories = [
    'All',
    'Trending',
    'IT & Software',
    'Design',
    'Marketing',
    'Science',
    'Law',
    'Language',
  ];

  Future<List<Map<String, dynamic>>> _fetchCourses() async {
    var query = Supabase.instance.client.from('courses').select();
    if (selectedCategory != 'All') {
      query = query.eq('category', selectedCategory);
    }
    final response = await query;
    return List<Map<String, dynamic>>.from(response);
  }

  Future<bool> _isAddedToBucket(String courseId) async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) return false;

    final existing = await Supabase.instance.client
        .from('bucket_courses')
        .select()
        .eq('student_id', user.id)
        .eq('course_id', courseId)
        .maybeSingle();

    return existing != null;
  }

  Future<void> _addToBucket(String courseId) async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) return;

    final alreadyAdded = await _isAddedToBucket(courseId);
    if (alreadyAdded) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Already added to Bucket")),
      );
      return;
    }

    await Supabase.instance.client.from('bucket_courses').insert({
      'student_id': user.id,
      'course_id': courseId,
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Added to Bucket!")),
    );

    setState(() {});
  }

  // void _openSearch() {
  //   showDialog(
  //     context: context,
  //     // builder: (_) => const SearchOverlay(),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const Sidebar(selectedMenu: "Discover"),
          Expanded(
            child: Column(
              children: [
                TopBar(
                  pageTitle: 'Discover Courses',
                  //  onSearchPressed: _openSearch,
                ),
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
                        return const Center(child: Text('No courses available.'));
                      }
                      return GridView.builder(
                        padding: const EdgeInsets.all(16),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 4 / 4.2,
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
          ),
        ],
      ),
      backgroundColor: const Color(0xFFF9F9F9),
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
    final courseId = course['id'];
    final title = course['title'] ?? 'No Title';
    final thumbnailUrl = course['thumbnail_url']?.isNotEmpty == true
        ? course['thumbnail_url']
        : 'https://st.depositphotos.com/2001755/4215/i/450/depositphotos_42159641-stock-photo-boat-on-water.jpg';

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => CoursePage(courseId: courseId),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 4,
              blurRadius: 8,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.network(
                thumbnailUrl,
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    course['category'] ?? 'Unknown Category',
                    style: const TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "\$${(course['price'] ?? 0).toString()}",
                    style: const TextStyle(color: Color(0xFF6A5AE0), fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  FutureBuilder<bool>(
                    future: _isAddedToBucket(courseId),
                    builder: (context, snapshot) {
                      final alreadyAdded = snapshot.data ?? false;
                      return ElevatedButton.icon(
                        onPressed: alreadyAdded ? null : () => _addToBucket(courseId),
                        icon: alreadyAdded ? const Icon(Icons.check) : const Icon(Icons.add_shopping_cart),
                        label: alreadyAdded ? const Text("Added") : const Text("Add to Bucket"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF6A5AE0),
                          foregroundColor: Colors.white,
                          minimumSize: const Size(double.infinity, 40),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
