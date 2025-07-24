import 'package:eventify_app/core/theme.dart';
import 'package:flutter/material.dart';

class RealEventDetails extends StatelessWidget {
  const RealEventDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeManager.lightPinkColor,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                    child: Image.asset(
                      'assets/images/page2.jpg',
                      fit: BoxFit.cover,
                      height: 400,
                      width: double.infinity,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Anoas Wedding Ceremony",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: ThemeManager.primaryColor,
                              ),
                            ),
                            Icon(Icons.favorite_border_outlined,   color: Color.alphaBlend(Colors.black.withOpacity(0.2), ThemeManager.darkPinkColor),),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on_rounded,
                              color: Color.alphaBlend(Colors.black.withOpacity(0.2), ThemeManager.darkPinkColor),
                              
                              size: 16,
                            ),
                             Text(
                              "Penny Street, London     •    2 seats left",
                              style: TextStyle(
                              color: Color.alphaBlend(Colors.black.withOpacity(0.2), ThemeManager.darkPinkColor),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: ThemeManager.lightPinkColor,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Start Time",
                                      style: TextStyle(
                                        color: Color.alphaBlend(
                                          Colors.black.withOpacity(0.2),
                                          ThemeManager.darkPinkColor,
                                        ),
                                        fontSize: 12,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      "8:45pm",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: ThemeManager.primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: ThemeManager.lightPinkColor,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Date",
                                      style: TextStyle(
                                        color: Color.alphaBlend(
                                          Colors.black.withOpacity(0.2),
                                          ThemeManager.darkPinkColor,
                                        ),
                                        fontSize: 12,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      "Dec 28",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: ThemeManager.primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          "Description",
                          style: TextStyle(fontWeight: FontWeight.bold,
                          color: ThemeManager.primaryColor,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          "Enjoy the experienced stylings of the gifted performer Roy Coulson.",
                          style: TextStyle(color: ThemeManager.primaryColor),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            ...List.generate(
                              3,
                              (index) => Padding(
                                padding: const EdgeInsets.only(right: 4),
                                child: CircleAvatar(
                                  radius: 14,
                                  backgroundImage: AssetImage(
                                    'assets/images/page${index + 1}.jpg',
                                  ),
                                ),
                              ),
                            ),
                            const Spacer(),
                            ElevatedButton.icon(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: ThemeManager.primaryColor,
                                foregroundColor: ThemeManager.lightPinkColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              label: const Text("Remind Me"),
                                icon: const Icon(Icons.notifications,color: ThemeManager.lightPinkColor,),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
