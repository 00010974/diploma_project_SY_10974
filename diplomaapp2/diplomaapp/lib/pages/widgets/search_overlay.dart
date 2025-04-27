import 'package:flutter/material.dart';

class SearchOverlay extends StatelessWidget {
  final VoidCallback onClose;

  const SearchOverlay({super.key, required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withOpacity(0.5),
      child: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 100),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Search courses...",
                        prefixIcon: const Icon(Icons.search),
                        filled: true,
                        fillColor: Colors.grey[100],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.close, size: 28),
                    onPressed: onClose,
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Text("Popular Categories", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                children: [
                  _buildCategoryChip("IT & Software"),
                  _buildCategoryChip("Design"),
                  _buildCategoryChip("Digital Marketing"),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text("Recent Search", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Text("Delete All", style: TextStyle(color: Colors.grey, fontSize: 14)),
                ],
              ),
              const SizedBox(height: 12),
              _buildRecentSearch("Figma"),
              _buildRecentSearch("Design System"),
              _buildRecentSearch("Fullstack Developer"),
              _buildRecentSearch("Envato Pro"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryChip(String title) {
    return Chip(
      label: Text(title),
      backgroundColor: Colors.grey[200],
      labelStyle: const TextStyle(color: Colors.black),
    );
  }

  Widget _buildRecentSearch(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          const Icon(Icons.history, size: 20, color: Colors.grey),
          const SizedBox(width: 8),
          Expanded(child: Text(title)),
          IconButton(
            icon: const Icon(Icons.close, size: 20),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
