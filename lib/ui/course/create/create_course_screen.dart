import 'dart:io';

import 'package:deco/data/services/course_service.dart';
import 'package:deco/domain/models/course.dart';
import 'package:deco/domain/models/place.dart';
import 'package:deco/viewmodels/couple_summary_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'widgets/sections/create_course_actions_section.dart';
import 'widgets/sections/create_course_basic_info_section.dart';
import 'widgets/sections/create_course_cover_photo_section.dart';
import 'widgets/sections/create_course_notes_section.dart';
import 'widgets/sections/create_course_places_section.dart';

class CreateCourseScreen extends StatefulWidget {
  const CreateCourseScreen({super.key});

  @override
  State<CreateCourseScreen> createState() => _CreateCourseScreenState();
}

class _CreateCourseScreenState extends State<CreateCourseScreen> {
  final _courseService = CourseService();

  final List<Place> _places = [];
  File? _coverFile;
  String? _filePath;
  bool _isPublic = false;

  final _titleController = TextEditingController();
  final _dateController = TextEditingController();
  final _oneLineController = TextEditingController();
  final _memoController = TextEditingController();

  Future<void> _openCreatePlace() async {
    final result = await context.push<Place>('/create-place');

    if(result == null) return;

    setState(() {
      _places.add(result);
    });
  }

  void _removePlace(int index) {
    setState(() {
      _places.removeAt(index);
    });
  }

  void _save() {
    List<int> date = _dateController.text.trim().split(".").map(int.parse).toList();
    Course course = Course(
      title: _titleController.text.trim(),
      date: DateTime(date[0], date[1], date[2]),
      places: _places,
      daySentence: _oneLineController.text.trim(),
      memo: _memoController.text.trim(),
      picture: _filePath,
      writer: FirebaseAuth.instance.currentUser?.uid,
      isPublic: _isPublic,
    );

    _courseService.createCourse(course);

    context.read<CoupleSummaryState>().load();
    context.go('/course');  //TODO. 수정 -> 홈에서도 create 갈 수 있음.
  }

  Future<void> pickCover() async {
    try {
      final picker = ImagePicker();

      final XFile? picked = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
        maxWidth: 1440,
      );

      if (picked == null) return;

      setState(() {
        _coverFile = File(picked.path);
        _filePath = picked.path;
      });
    } catch (e) {
      debugPrint('pickCover error: $e');
    }
  }

  void deleteCover() {
    setState(() => _coverFile = null);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _dateController.dispose();
    _oneLineController.dispose();
    _memoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
                child: Column(
                  children: [
                    //const CreateCourseIntroSection(),
                    //const SizedBox(height: 14),

                    CreateCourseCoverPhotoSection(
                      image: _coverFile == null ? null : FileImage(_coverFile!),
                      onPickPhoto: pickCover,
                      onDeletePhoto: deleteCover,
                    ),
                    const SizedBox(height: 14),

                    CreateCourseBasicInfoSection(
                      titleController: _titleController,
                      dateController: _dateController,
                    ),
                    const SizedBox(height: 14),

                    CreateCoursePlacesSection(
                      places: _places,
                      onTapAddPlace: _openCreatePlace,
                      onRemovePlace: _removePlace,
                    ),
                    const SizedBox(height: 14),

                    CreateCourseNotesSection(
                      oneLineController: _oneLineController,
                      memoController: _memoController,
                      isPublic: _isPublic,
                      onChangedPublic: (v) => setState(() => _isPublic = v),
                    ),
                    const SizedBox(height: 18),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(16, 6, 16, 16),
              child: CreateCourseActionsSection(
                onCancel: () => context.pop(),
                onSave: _save,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
