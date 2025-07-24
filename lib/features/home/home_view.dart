import 'package:eventify_app/core/routes.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Hello Dylan!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1B3C53),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),

                decoration: BoxDecoration(
                  color: Color(0xFFF9F3EF),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Now that you are all set.\nLet's make your events extraordinary,\nstarting right here!",
                      style: TextStyle(fontSize: 14, color: Color(0xFF456882)),
                    ),
                    const SizedBox(height: 25),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.realEventDetails);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF1B3C53),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 54,
                          vertical: 15,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Plan an Event',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 60),
              const Text(
                'Invitations',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1B3C53),),
              ),
              const SizedBox(height: 35),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: Color(0xFFF9F3EF),
                      child: const Icon(
                        Icons.mail_outline,
                        color: Color(0xFF1B3C53),
                        size: 30,
                      ),
                    ),
                    const SizedBox(width: 50),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'No Invitations',
                            style: TextStyle(fontWeight: FontWeight.bold,color: Color(0xFF1B3C53)),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "No invitations received? Take charge and plan your own event with EventJoy. It's easy and fun!",
                            style: TextStyle(
                              fontSize: 13,
                              color: Color(0xFF456882),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 60),
              const Text(
                'Upcoming Events',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1B3C53),),
              ),
              const SizedBox(height: 35),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: Color(0xFFF9F3EF),
                      child: const Icon(
                        Icons.calendar_today,
                        color: Color(0xFF1B3C53),
                        size: 30,
                      ),
                    ),
                    const SizedBox(width: 50),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'No Events',
                            style: TextStyle(fontWeight: FontWeight.bold,color: Color(0xFF1B3C53)),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "Your event calendar is a blank canvas. Use EventJoy to paint it with memorable moments.",
                            style: TextStyle(
                              fontSize: 13,
                              color: Color(0xFF456882),
                            ),
                          ),
                          SizedBox(height: 16),
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
    );
  }
}

