import 'package:flutter/material.dart';
import '../widgets/sidebar.dart';
import '../widgets/topbar.dart';
import 'course_detail_page.dart';

class MyCoursesPage extends StatelessWidget {
  const MyCoursesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: Row(
        children: [
          const Sidebar(selectedMenu: "My Courses"),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  const TopBar(pageTitle: "My Courses"),
                  const SizedBox(height: 24),
                  Expanded(
                    child: ListView(
                      children: [
                        continueWatchingSection(context),
                        const SizedBox(height: 32),
                        enrolledCoursesSection(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget continueWatchingSection(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 8,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: const [
            Icon(Icons.play_circle_outline, color: Colors.deepPurple),
            SizedBox(width: 8),
            Text(
              "Continue Watching",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // SizedBox(
        //   height: 220,
        //   child: ListView(
        //     scrollDirection: Axis.horizontal,
        //     children: [
        //       continueWatchingCard(
        //         imageUrl: "https://placehold.co/600x400?text=Envato",
        //         title: "Envato Mastery: Build a Passive Income",
        //         chapter: "CHAPTER 3  •  PART 2",
        //         timeWatched: "07:23",
        //         totalTime: "11:00",
        //       ),
        //       continueWatchingCard(
        //         imageUrl: "https://placehold.co/600x400?text=Git+Vercel",
        //         title: "Mastering Git & Vercel App",
        //         chapter: "CHAPTER 2  •  PART 1",
        //         timeWatched: "02:21",
        //         totalTime: "08:00",
        //       ),
        //       continueWatchingCard(
        //         imageUrl: "https://placehold.co/600x400?text=Web+Dev",
        //         title: "Creative Web Development",
        //         chapter: "CHAPTER 5  •  PART 4",
        //         timeWatched: "09:13",
        //         totalTime: "10:00",
        //       ),
        //       continueWatchingCard(
        //         imageUrl: "https://placehold.co/600x400?text=Intro",
        //         title: "Introduction to Software",
        //         chapter: "CHAPTER 2  •  PART 6",
        //         timeWatched: "00:43",
        //         totalTime: "10:00",
        //       ),
        //     ],
        //   ),
        // ),


        SizedBox(
          height: 260,
          child: ListView(
            scrollDirection: Axis.horizontal,
              children: [
              continueWatchingCard(
                imageUrl: "https://placehold.co/600x400?text=Envato",
                title: "Envato Mastery: Build a Passive Income",
                chapter: "CHAPTER 3  •  PART 2",
                timeWatched: "07:23",
                totalTime: "11:00",
                progressPercent: 0.7,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const CourseDetailPage(title: "Envato Mastery: Build a Passive Income")),
                  );
                },
              ),
              continueWatchingCard(
                imageUrl: "https://placehold.co/600x400?text=Git+Vercel",
                title: "Mastering Git & Vercel App",
                chapter: "CHAPTER 2  •  PART 1",
                timeWatched: "02:21",
                totalTime: "08:00",
                progressPercent: 0.3,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const CourseDetailPage(title: "Mastering Git & Vercel App")),
                  );
                },
              ),
              continueWatchingCard(
                imageUrl: "https://placehold.co/600x400?text=Intro",
                title: "Introduction to Software",
                chapter: "CHAPTER 2  •  PART 6",
                timeWatched: "00:43",
                totalTime: "10:00",
                progressPercent: 0.1,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const CourseDetailPage(title: "Introduction to Software")),
                  );
                },
              ),
              continueWatchingCard(
                imageUrl: "https://placehold.co/600x400?text=Web+Dev",
                title: "Creative Web Development",
                chapter: "CHAPTER 5  •  PART 4",
                timeWatched: "09:13",
                totalTime: "10:00",
                progressPercent: 0.9,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const CourseDetailPage(title: "Creative Web Development")),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

 Widget continueWatchingCard({
  required String imageUrl,
  required String title,
  required String chapter,
  required String timeWatched,
  required String totalTime,
  required double progressPercent, // 👈 добавляем сюда прогресс (например 0.7 для 70%)
  required VoidCallback onTap, // 👈 добавляем действие при клике
}) {
  return Padding(
    padding: const EdgeInsets.only(right: 16.0),
    child: GestureDetector(
      onTap: onTap,
      child: Container(
        width: 220,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  child: Image.network(
                    imageUrl,
                    height: 120,
                    width: 220,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 40,
                  left: 90,
                  child: Icon(Icons.play_circle_fill,
                      size: 40, color: Colors.white.withOpacity(0.8)),
                ),
                Positioned(
                  bottom: 6,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      "$timeWatched / $totalTime",
                      style: const TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  ),
                ),
              ],
            ),
            // 👇 новый прогресс-бар
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
              child: LinearProgressIndicator(
                value: progressPercent,
                backgroundColor: Colors.grey[300],
                color: Colors.deepPurple,
                minHeight: 5,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                chapter,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    ),
  );
}


  Widget enrolledCoursesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Enrolled Courses",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text(
          "Dive in, learn, and let your potential unfold!",
          style: TextStyle(color: Colors.grey),
        ),
        const SizedBox(height: 24),
        ...List.generate(4, (index) => enrolledCourseItem()),
      ],
    );
  }

  Widget enrolledCourseItem() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.purple[100],
              child: const Icon(Icons.school_outlined, color: Colors.deepPurple),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Envato Mastery",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "Mentor: Ms. Nina",
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: 0.79,
                    minHeight: 6,
                    backgroundColor: Colors.grey[300],
                    color: Colors.deepPurple,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: const [
                Text(
                  "Duration",
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                SizedBox(height: 4),
                Text(
                  "4h 23m",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}