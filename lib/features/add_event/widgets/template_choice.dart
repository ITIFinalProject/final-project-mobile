import 'package:flutter/material.dart';

class TemplateChoice extends StatelessWidget {
  int? currentIndex;
  Function(int) selectTemplate;

  TemplateChoice({
    super.key,
    required this.currentIndex,
    required this.selectTemplate,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            selectTemplate(index + 1);
          },
          child: Column(
            children: [
              Image.asset(
                'assets/images/template${index + 1}.jpg',
                width: size.width * 0.4,
                height: size.height * 0.2,
              ),
              Text('Template ${index + 1}'),
            ],
          ),
        );
      },
      itemCount: 5,
    );
  }
}
