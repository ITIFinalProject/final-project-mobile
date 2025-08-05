import 'dart:io';

import 'package:eventify_app/features/add_memory/view/video_player_view.dart';
import 'package:eventify_app/features/profile/cubit/theme_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/theme.dart';
import '../../../models.dart/event_model.dart';
import '../../events/widgets/card_no_events.dart';
import '../cubit/memory_cubit.dart';
import '../cubit/memory_state.dart';
import 'image_view.dart';

class AddMemory extends StatefulWidget {
  final EventModel event;
  const AddMemory({super.key, required this.event});

  @override
  State<AddMemory> createState() => _AddMemoryState();
}

class _AddMemoryState extends State<AddMemory> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<MemoryCubit>().fetchMemories(widget.event.id);
    print(widget.event.id);
    print(widget.event.title);
  }

  @override
  void initState() {
    super.initState();
    context.read<MemoryCubit>().fetchMemories(widget.event.id);
  }

  @override
  Widget build(BuildContext context) {
    final thememode = context
        .watch<ThemeCubit>()
        .state;
    final isDarkMode = thememode == ThemeMode.dark;
    final userId = FirebaseAuth.instance.currentUser?.uid;
    final isOwner = widget.event.hostId == userId;

    return Scaffold(
      appBar: AppBar(title: Text('${widget.event.title} Memories')),
      body: BlocBuilder<MemoryCubit, MemoryState>(
        builder: (context, state) {
          if (state is MemoryLoading) {
            return Center(child: CircularProgressIndicator(
              color: isDarkMode ? ThemeManager.lightPinkColor : ThemeManager
                  .primaryColor,
            ));
          } else if (state is MemoriesLoaded) {
            final memories = state.memories;
            if (memories.isEmpty) {
              return const CardNoEvents(
                text: 'No Memories added to this event, add one!',
                title: 'Event Memory',
              );
            } else {
              return GridView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: memories.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  final memory = memories[index];
                  final isImage = memory.type == 'image';
                   return GestureDetector(
                      onTap: () {
                    if (isImage) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => FullImageView(imageUrl: memory.url),
                        ),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => VideoPlayerView(videoUrl: memory.url),
                        ),
                      );
                    }
                      },
                       child: Stack(
                           children: [
                             isImage
                                 ? Card(
                               shape: RoundedRectangleBorder(
                                 borderRadius: BorderRadius.circular(15),
                                 side: BorderSide(
                                     color: isDarkMode ? ThemeManager
                                         .lightPinkColor : ThemeManager
                                         .primaryColor),
                               ),
                               child: ClipRRect(
                                 borderRadius: BorderRadius.circular(15),
                                 child: Image.network(
                                   memory.url,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  color: isDarkMode? ThemeManager.lightPinkColor : ThemeManager.primaryColor,
                                ),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return Container(

                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(color:isDarkMode?ThemeManager.lightPinkColor: ThemeManager.secondaryColor)
                                ),
                                child: const Icon(
                                  Icons.broken_image,
                                  color: Colors.grey,
                                  size: 48,
                                ),
                              );
                            },
                          ),
                        ),
                      )
                      : ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                               child: Container(
                                 color: isDarkMode
                                     ? ThemeManager.lightPinkColor
                                     : ThemeManager.primaryColor,
                                 // Placeholder for video
                                 child: Center(
                                   child: Icon(
                                     Icons.videocam,
                                     size: 48,
                                     color: isDarkMode ? ThemeManager
                                         .primaryColor : ThemeManager
                                         .lightPinkColor,
                                   ),
                                 ),
                               ),
                             ),
                             if(isOwner)
                               Positioned(
                                 top: 5,
                                 right: 35,
                                 child: CircleAvatar(
                                   backgroundColor: Colors.red.withOpacity(0.8),
                                   radius: 16,
                                   child: IconButton(
                                     padding: EdgeInsets.zero,
                                     icon: const Icon(Icons.delete, size: 18,
                                         color: Colors.white),
                                     onPressed: () async {
                                       await context.read<MemoryCubit>()
                                           .deleteMemory(
                                         eventId: widget.event.id,
                                         memoryId: memory.eventId,
                                         fileUrl: memory.url,
                                       );
                                     },
                                   ),
                                 ),
                               ),
                           ])
                   );
                },
              );
            }
          } else if (state is MemoryError) {
            return Center(child: Text("Error: ${state.message}"));
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _pickImage,
        backgroundColor: isDarkMode?ThemeManager.secondaryColor
        .withOpacity(0.8): ThemeManager.primaryColor ,
        child:  Icon(
          Icons.add_a_photo_outlined,
          color: ThemeManager.lightPinkColor,
          size: 30,
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    showModalBottomSheet(
      context: context,
      builder:
          (context) => SafeArea(
            child: Wrap(
              children: [
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text("Take a photo"),
                  onTap: () {
                    handlePickAndUpload(ImageSource.camera, 'image');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text("Upload Image from gallery"),
                  onTap: () {
                    handlePickAndUpload(ImageSource.gallery, 'image');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.video_camera_back_outlined),
                  title: const Text("Record a video"),
                  onTap: () {
                    handlePickAndUpload(ImageSource.camera, 'video');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.video_collection),
                  title: const Text("Upload a video"),
                  onTap: () {
                    handlePickAndUpload(ImageSource.gallery, 'video');
                  },
                ),
              ],
            ),
          ),
    );
  }

  Future<void> handlePickAndUpload(ImageSource source, String type) async {
    final picked =
        type == 'image'
            ? await ImagePicker().pickImage(source: source)
            : await ImagePicker().pickVideo(source: source);

    if (picked != null) {
      final file = File(picked.path);
      if (widget.event != null) {
        context.read<MemoryCubit>().uploadMemory(
          type: type,
          file: file,
          eventId: widget.event.id,
        );
      }
    }

    Navigator.pop(context);
  }
}
