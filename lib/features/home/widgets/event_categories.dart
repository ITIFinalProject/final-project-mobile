import 'package:eventify_app/core/theme.dart';
import 'package:flutter/material.dart';

import '../../../core/routes.dart';

class EventCategories extends StatelessWidget {
  const EventCategories({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final categories = [
      "Entertainment",
      "Educational & Business",
      "Cultural & Arts",
      "Sports & Fitness",
      "Technology & Innovation",
      "Travel & Adventure",
    ];
    final icons = [
      Icons.movie,
      Icons.business_center,
      Icons.palette,
      Icons.sports,
      Icons.memory,
      Icons.travel_explore,
    ];
    return SizedBox(
      height: size.height * 0.1,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap:
                () => Navigator.pushNamed(
                  context,
                  AppRoutes.categoryEvents,
                  arguments: categories[index],
                ),
            child: Container(
              alignment: Alignment.center,
              height: size.height * 0.08,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: ThemeManager.secondaryColor,
                  width: 1.5,
                ),
                gradient: LinearGradient(
                  begin:
                      index % 2 == 0
                          ? Alignment.bottomRight
                          : Alignment.topRight,
                  end:
                      index % 2 != 0 ? Alignment.topLeft : Alignment.centerLeft,
                  transform: GradientRotation((index + 1) * 90),
                  colors: [Colors.white, Colors.deepOrange.shade300],
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    icons[index],
                    color: ThemeManager.primaryColor,
                    size: 20,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    categories[index],
                    style: TextStyle(
                      color: ThemeManager.primaryColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
