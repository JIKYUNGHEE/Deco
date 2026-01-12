import 'package:flutter/material.dart';

import 'widgets/sections/create_course_basic_info_section.dart';
import 'widgets/sections/create_course_cover_photo_section.dart';
import 'widgets/sections/create_course_intro_section.dart';
import 'widgets/sections/create_course_notes_section.dart';
import 'widgets/sections/create_course_places_section.dart';

class CreateCourseScreen extends StatelessWidget {
  const CreateCourseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CreateCourseIntroSection(),
        const SizedBox(height: 14),

        const CreateCourseCoverPhotoSection(),
        const SizedBox(height: 14),

        const CreateCourseBasicInfoSection(),
        const SizedBox(height: 14),

        const CreateCoursePlacesSection(),
        const SizedBox(height: 14),

        const CreateCourseNotesSection(),
        const SizedBox(height: 18),
      ],
    );
  }
}
