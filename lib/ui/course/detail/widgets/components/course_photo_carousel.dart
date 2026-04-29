import 'package:deco/ui/core/themes/app_colors.dart';
import 'package:flutter/material.dart';

class CoursePhotoCarousel extends StatefulWidget {
  final List<String> imageUrls;

  const CoursePhotoCarousel({super.key, required this.imageUrls});

  @override
  State<CoursePhotoCarousel> createState() => _CoursePhotoCarouselState();
}

class _CoursePhotoCarouselState extends State<CoursePhotoCarousel> {
  final PageController _controller = PageController();
  int _currentIndex = 0;

  @override
  void didUpdateWidget(covariant CoursePhotoCarousel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_currentIndex >= widget.imageUrls.length) {
      _currentIndex = 0;
      if (_controller.hasClients) {
        _controller.jumpToPage(0);
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hasImages = widget.imageUrls.isNotEmpty;
    final imageCount = widget.imageUrls.length;

    return Container(
      height: 170,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 16,
            offset: Offset(0, 8),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Positioned.fill(
            child: hasImages
                ? PageView.builder(
                    controller: _controller,
                    itemCount: imageCount,
                    onPageChanged: (index) {
                      setState(() => _currentIndex = index);
                    },
                    itemBuilder: (context, index) {
                      return Image.network(
                        widget.imageUrls[index],
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => const _ImagePlaceholder(),
                      );
                    },
                  )
                : const _ImagePlaceholder(),
          ),
          if (hasImages)
            Positioned(
              top: 12,
              right: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.45),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  '${_currentIndex + 1} / $imageCount',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          if (imageCount > 1)
            Positioned(
              bottom: 10,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  imageCount,
                  (index) => _PhotoDot(selected: index == _currentIndex),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _ImagePlaceholder extends StatelessWidget {
  const _ImagePlaceholder();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFEDEDED), Color(0xFFCFCFCF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: const Center(
        child: Icon(Icons.image_outlined, size: 42, color: Colors.white),
      ),
    );
  }
}

class _PhotoDot extends StatelessWidget {
  final bool selected;

  const _PhotoDot({required this.selected});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: selected ? 24 : 7,
      height: 6,
      margin: const EdgeInsets.symmetric(horizontal: 3),
      decoration: BoxDecoration(
        color: selected ? AppColors.primary : const Color(0xFFD8D8E2),
        borderRadius: BorderRadius.circular(999),
      ),
    );
  }
}
