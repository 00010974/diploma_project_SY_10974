import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../widgets/sidebar.dart';
import '../widgets/topbar.dart';
import '../basket/checkout_page.dart';

class CoursePage extends StatefulWidget {
  final String courseId;

  const CoursePage({super.key, required this.courseId});

  @override
  State<CoursePage> createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  Map<String, dynamic>? course;

  Future<void> _loadCourse() async {
    final response = await Supabase.instance.client
        .from('courses')
        .select()
        .eq('id', widget.courseId)
        .maybeSingle();

    setState(() {
      course = response;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadCourse();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: Row(
        children: [
          const Sidebar(selectedMenu: "Discover"),
          Expanded(
            child: Column(
              children: [
                const TopBar(pageTitle: 'Course Detail'),
                Expanded(
                  child: course == null
                      ? const Center(child: CircularProgressIndicator())
                      : SingleChildScrollView(
                          padding: const EdgeInsets.all(24),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Left Section
                              Expanded(
                                flex: 3,
                                child: Container(
                                  padding: const EdgeInsets.all(16),
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
                                      Text(
                                        course!['title'] ?? 'Course Title',
                                        style: const TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(16),
                                        child: Image.network(
                                          course!['thumbnail_url'] ??
                                              'https://st.depositphotos.com/2001755/4215/i/450/depositphotos_42159641-stock-photo-boat-on-water.jpg',
                                          height: 240,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      const SizedBox(height: 24),
                                      DefaultTabController(
                                        length: 4,
                                        child: Column(
                                          children: [
                                            const TabBar(
                                              labelColor: Color(0xFF6A5AE0),
                                              unselectedLabelColor: Colors.black54,
                                              indicatorColor: Color(0xFF6A5AE0),
                                              tabs: [
                                                Tab(text: 'Description'),
                                                Tab(text: 'Tools'),
                                                Tab(text: 'Reviews'),
                                                Tab(text: 'Classmates'),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 300,
                                              child: TabBarView(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.all(16),
                                                    child: Text(
                                                      course!['description'] ??
                                                          'No description available.',
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ),
                                                  const Center(child: Text('Tools Section')),
                                                  const Center(child: Text('Reviews Section')),
                                                  const Center(child: Text('Classmates Section')),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 24),
                              // Right Sidebar
                              Expanded(
                                flex: 1,
                                child: Column(
                                  children: [
                                    _buildOverviewBox(),
                                    const SizedBox(height: 24),
                                    _buildMentorBox(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewBox() {
    return Container(
      padding: const EdgeInsets.all(16),
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
          _overviewTile('Enrolled', '52'),
          _overviewTile('Modules', '16'),
          _overviewTile('Videos', '41'),
          _overviewTile('Reviews', '50'),
          const Divider(height: 32),
          Text(
            "Price",
            style: TextStyle(color: Colors.grey[600], fontSize: 14),
          ),
          const SizedBox(height: 8),
          Text(
            "\$${(course!['price'] ?? 0).toString()}",
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF6A5AE0),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CheckoutPage(course: course!),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6A5AE0),
              minimumSize: const Size(double.infinity, 48),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('Checkout', style: TextStyle(fontSize: 18)),
          ),
        ],
      ),
    );
  }

  Widget _buildMentorBox() {
    return Container(
      padding: const EdgeInsets.all(16),
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
        children: const [
          Text(
            'About Mentor',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(
              backgroundImage: NetworkImage('https://st.depositphotos.com/2001755/4215/i/450/depositphotos_42159641-stock-photo-boat-on-water.jpg'),
            ),
            title: Text('Nina Kim'),
            subtitle: Text('Web/Mobile Developer'),
          ),
          SizedBox(height: 8),
          Text(
            "With a wealth of experience, Nina guides aspiring developers through the intricacies of building dynamic and responsive applications.",
            style: TextStyle(fontSize: 14),
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.star, color: Colors.amber, size: 20),
              SizedBox(width: 4),
              Text('4.9/5 (120 Reviews)', style: TextStyle(color: Colors.black54)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _overviewTile(String title, String number) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(Icons.circle, size: 10, color: Colors.grey[600]),
          const SizedBox(width: 8),
          Text(title, style: TextStyle(color: Colors.grey[700])),
          const Spacer(),
          Text(number, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
