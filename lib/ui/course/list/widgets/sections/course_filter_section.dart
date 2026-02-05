import 'package:flutter/material.dart';

import '../../../../core/widgets/deco_outlined_button.dart';

enum CourseSortFilter { latest }//, popular }

enum CoursePeriodFilter {
  all, // 전체 기간
}

enum CourseRegionFilter {
  all, // 전체 지역
}

class CourseFilterSection extends StatelessWidget {
  final CourseSortFilter sort;
  final CoursePeriodFilter period;
  final CourseRegionFilter region;

  final ValueChanged<CoursePeriodFilter> onPeriodChanged;
  final ValueChanged<CourseSortFilter> onSortChanged;
  final ValueChanged<CourseRegionFilter> onRegionChanged;

  const CourseFilterSection({
    super.key,
    required this.sort,
    required this.period,
    required this.region,
    required this.onSortChanged,
    required this.onPeriodChanged,
    required this.onRegionChanged,
  });

  String _sortLabel(CourseSortFilter v) {
    switch (v) {
      case CourseSortFilter.latest:
        return '최신순';
      // case CourseSortFilter.popular:
      //   return '인기순';
    }
  }


  String _periodLabel(CoursePeriodFilter v) {
    switch (v) {
      case CoursePeriodFilter.all:
        return '전체 기간';
    }
  }

  String _regionLabel(CourseRegionFilter v) {
    switch (v) {
      case CourseRegionFilter.all:
        return '지역';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: DecoOutlinedButton(
            label: _sortLabel(sort),
            height: 42,
            radius: 18,
            fontSize: 13,
            variant: DecoOutlinedVariant.subtle,
            suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded, size: 18),
            onPressed: () => _openSortSheet(context),
          ),
        ),
        const SizedBox(width: 4),

        Expanded(
          child: DecoOutlinedButton(
            label: _periodLabel(period),
            height: 42,
            radius: 18,
            fontSize: 13,
            variant: DecoOutlinedVariant.subtle,
            suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded, size: 18),
            onPressed: () => _openPeriodSheet(context),
          ),
        ),
        const SizedBox(width: 4),
        Expanded(
          child: DecoOutlinedButton(
            label: _regionLabel(region),
            height: 42,
            radius: 18,
            fontSize: 13,
            variant: DecoOutlinedVariant.subtle,
            suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded, size: 18),
            onPressed: () => _openRegionSheet(context),
          ),
        ),
      ],
    );
  }

  void _openPeriodSheet(BuildContext context) async {
    final result = await showModalBottomSheet<CoursePeriodFilter>(
      context: context,
      builder: (_) => _FilterBottomSheet<CoursePeriodFilter>(
        title: '기간',
        items: CoursePeriodFilter.values,
        labelBuilder: _periodLabel,
        selected: period,
      ),
    );

    if (result != null) onPeriodChanged(result);
  }

  void _openSortSheet(BuildContext context) async {
    final result = await showModalBottomSheet<CourseSortFilter>(
      context: context,
      builder: (_) => _FilterBottomSheet<CourseSortFilter>(
        title: '정렬',
        items: CourseSortFilter.values,
        labelBuilder: _sortLabel,
        selected: sort,
      ),
    );

    if (result != null) onSortChanged(result);
  }

  void _openRegionSheet(BuildContext context) async {
    final result = await showModalBottomSheet<CourseRegionFilter>(
      context: context,
      builder: (_) => _FilterBottomSheet<CourseRegionFilter>(
        title: '지역',
        items: CourseRegionFilter.values,
        labelBuilder: _regionLabel,
        selected: region,
      ),
    );

    if (result != null) onRegionChanged(result);
  }
}

class _FilterBottomSheet<T> extends StatelessWidget {
  final String title;
  final List<T> items;
  final T selected;
  final String Function(T) labelBuilder;

  const _FilterBottomSheet({
    required this.title,
    required this.items,
    required this.selected,
    required this.labelBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 12),
            ...items.map((e) {
              final isSelected = e == selected;
              return ListTile(
                title: Text(
                  labelBuilder(e),
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: isSelected
                        ? Theme.of(context).colorScheme.primary
                        : null,
                  ),
                ),
                trailing: isSelected
                    ? Icon(
                  Icons.check,
                  color: Theme.of(context).colorScheme.primary,
                )
                    : null,
                onTap: () => Navigator.pop(context, e),
              );
            }),
          ],
        ),
      ),
    );
  }
}
