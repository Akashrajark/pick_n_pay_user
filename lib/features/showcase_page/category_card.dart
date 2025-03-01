import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final Function()? onTap;

  const CategoryCard({
    super.key,
    required this.title,
    required this.imageUrl,
    this.onTap,
    required Null Function() ontap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 120,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                imageUrl,
                height: 60,
                width: 60,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

// Example Usage in a List
class CategoryList extends StatelessWidget {
  final List<Map<String, String>> categories = [
    {
      'title': 'Groceries',
      'imageUrl':
          'https://img.freepik.com/free-photo/basket-full-vegetables_1112-316.jpg?t=st=1740820780~exp=1740824380~hmac=d9b119925543738e8e562ec347a94283f15ee0867b515bc8dd62f0ca9ec6fb35&w=1380'
    },
    {
      'title': 'Electronics',
      'imageUrl':
          'https://img.freepik.com/premium-photo/high-angle-view-computer-keyboard-table_1048944-18670532.jpg?w=1380'
    },
    {
      'title': 'Clothing',
      'imageUrl':
          'https://img.freepik.com/free-photo/clothes-hanging_1339-3159.jpg?t=st=1740820911~exp=1740824511~hmac=71d74548f0f37f2e5fe285138b72321794dfec3d32ab73e9621c843c6a4abbc0&w=1380'
    },
    {
      'title': 'Home & Kitchen',
      'imageUrl':
          'https://img.freepik.com/premium-photo/household-kitchen-appliances-table-kitchen_392895-235826.jpg?w=1380'
    },
    {
      'title': 'Beauty & Personal Care',
      'imageUrl':
          'https://img.freepik.com/free-photo/spa-assortment-with-face-cremes_23-2148549091.jpg?t=st=1740821034~exp=1740824634~hmac=6a8cb18c540ea8408324d177113db8348173f9902a5d30ab7bbdc36339209627&w=900'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (context, index) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          return CategoryCard(
            title: categories[index]['title']!,
            imageUrl: categories[index]['imageUrl']!,
            onTap: () {
              // Navigate to category-specific products
            },
            ontap: () {},
          );
        },
      ),
    );
  }
}
