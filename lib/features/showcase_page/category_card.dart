import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    this.ontap,
  });
  final Function()? ontap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Material(
        elevation: 8,
        borderRadius: BorderRadius.circular(10),
        clipBehavior: Clip.none,
        child: Container(
          width: 100,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.grey[500],
                child: const Icon(Icons.fastfood, color: Colors.black),
              ),
              const SizedBox(height: 5),
              const Text("Category"),
            ],
          ),
        ),
      ),
    );
  }
}
