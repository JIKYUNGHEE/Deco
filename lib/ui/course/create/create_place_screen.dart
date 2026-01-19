import 'dart:io';

import 'package:deco/ui/course/create/widgets/sections/create_course_places_section.dart';
import 'package:deco/ui/course/create/widgets/sections/create_place_actions_section.dart';
import 'package:deco/ui/course/create/widgets/sections/create_place_memo_section.dart';
import 'package:deco/ui/course/create/widgets/sections/create_place_photos_section.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/themes/deco_theme_extension.dart';
import '../../core/widgets/deco_gradient_app_bar.dart';
import 'widgets/sections/create_place_basic_info_section.dart';

class CreatePlaceScreen extends StatefulWidget {
  const CreatePlaceScreen({super.key});

  @override
  State<CreatePlaceScreen> createState() => _CreatePlaceScreenState();
}

class _CreatePlaceScreenState extends State<CreatePlaceScreen> {
  final _nameCtrl = TextEditingController();
  final _memoCtrl = TextEditingController();

  PlaceType? _selectedType;
  String? _locationLabel;

  final _picker = ImagePicker();

  final List<ImageProvider?> _photos = List.generate(3, (_) => null);

  Future<void> _pickPhotoAt(int index) async{
    try {
      final xFile = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 85, maxWidth: 1600,);

      if(xFile == null) return;

      setState(() {
        _photos[index] = FileImage(File(xFile.path));
      });
    }catch(e) {
      debugPrint('pickPhotoAt error: $e');
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('사진을 가져오지 못했어요. 권한을 확인해주세요.')),
      );
    }
  }

  void _removePhotoAt(int index) {
    setState(() => _photos[index] = null);
  }

  void _pickLocation() async {
    setState(() => _locationLabel = '지도에서 선택됨');
  }

  void _save() {
    final result = SelectedPlaceUi(
      title: _nameCtrl.text.trim(),
      tag: _selectedType!.name,
      location: _locationLabel!,
    );
    context.pop(result);
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _memoCtrl.dispose();
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CreatePlaceBasicInfoSection(
                      nameController: _nameCtrl,
                      selectedType: _selectedType,
                      onSelectType: (t) => setState(() => _selectedType = t),
                      locationLabel: _locationLabel,
                      onTapPickLocation: _pickLocation,
                    ),
                    const SizedBox(height: 16),
        
                    CreatePlacePhotosSection(
                      photos: _photos,
                      onTapPickAt: _pickPhotoAt,
                    ),
                    const SizedBox(height: 16),
        
                    CreatePlaceMemoSection(controller: _memoCtrl),
                    const SizedBox(height: 22),
        
                    CreatePlaceActionsSection(
                      onCancel: () => context.pop(),
                      onSave: _save,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
