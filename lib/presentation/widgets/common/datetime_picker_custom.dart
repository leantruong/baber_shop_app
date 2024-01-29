import 'package:baber_shop_app/presentation/themes/app_color.dart';
import 'package:flutter/material.dart';

import '../../../extensions/extension.dart';

class DateTimePickerCustom extends StatefulWidget {
  const DateTimePickerCustom(
      {super.key, required this.height, required this.onSelectedDate});
  final double height;
  final Function(DateTime? date) onSelectedDate;

  @override
  State<DateTimePickerCustom> createState() => _DateTimePickerCustomState();
}

class _DateTimePickerCustomState extends State<DateTimePickerCustom> {
  int totalDateInMonth = 0;
  int getFirstDayInMonth = 0;
  DateTime? _selectedDate;
  late DateTime _changedDate;
  int _currentIndex = 0;
  DateTime now = DateTime.now();

  @override
  void initState() {
    super.initState();

    totalDateInMonth = DateExtension.getDayInMonth(DateTime.now());

    _changedDate = now;

    getFirstDayInMonth = DateExtension.getFirstDayInMonth(_changedDate);
  }

  void _onNextMonth() {
    setState(() {
      _changedDate =
          DateTime(_changedDate.year, _changedDate.month + 1, _changedDate.day);
      totalDateInMonth = DateExtension.getDayInMonth(_changedDate);

      _getFirstDayInMonth();
    });
  }

  void _onPreviousMonth() {
    setState(() {
      totalDateInMonth = DateExtension.getDayInMonth(DateTime(
          _changedDate.year, _changedDate.month - 1, _changedDate.day));
      _changedDate = _changedDate.subtract(Duration(days: totalDateInMonth));

      _getFirstDayInMonth();
    });
  }

  void _getFirstDayInMonth() {
    getFirstDayInMonth = DateExtension.getFirstDayInMonth(_changedDate);
  }

  void _onSelecDate(int index) {
    if (_currentIndex == index) return;
    setState(() {
      _currentIndex = index;
      _selectedDate = DateTime(_changedDate.year, _changedDate.month,
          index - getFirstDayInMonth + 2);
    });
  }

  Color getColorItem(DateTime genDate) {
    final now = DateTime.now();
    if (genDate.isAtSameMomentAs(DateTime(now.year, now.month, now.day)) &&
        _currentIndex + 1 != now.weekday) {
      return AppColors.redAcent;
    } else if (_selectedDate != null &&
        genDate.isAtSameMomentAs(_selectedDate!)) {
      return AppColors.redAcent.withOpacity(0.4);
    }
    return Colors.transparent;
  }

  Color? getColorDay(
    DateTime genDate,
  ) {
    if (genDate.isAtSameMomentAs(DateTime(now.year, now.month, now.day)) &&
        _currentIndex + 1 != now.weekday) {
      return AppColors.white;
    } else if (_selectedDate != null &&
        genDate.isAtSameMomentAs(_selectedDate!)) {
      return AppColors.black;
    }
    return null;
  }

  Color getBorderColor(
    DateTime genDate,
  ) {
    if (_selectedDate != null && genDate.isAtSameMomentAs(_selectedDate!)) {
      return AppColors.redAcent;
    }
    return Colors.transparent;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SizedBox(
          height: 500,
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  _changedDate.getNameMonth(),
                  style: const TextStyle(
                      fontSize: 18.0, fontWeight: FontWeight.w600),
                ),
                const Spacer(),
                IconButton(
                    onPressed: () {
                      _onPreviousMonth();
                    },
                    icon: const Icon(Icons.arrow_back)),
                IconButton(
                    onPressed: () {
                      _onNextMonth();
                    },
                    icon: const Icon(Icons.arrow_forward)),
              ],
            ),
            const SizedBox(
              height: 12.0,
            ),
            Row(
              children: List.generate(
                  7,
                  (index) => Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(index == 6 ? 'CN' : 'T${index + 2}'),
                        ),
                      )).toList(),
            ),
            const SizedBox(
              height: 18.0,
            ),
            Expanded(
              child: GridView(
                padding: EdgeInsets.zero,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 4,
                  crossAxisCount: 7,
                ),
                children: List.generate(
                    totalDateInMonth + getFirstDayInMonth - 1, (index) {
                  final dayRender = index - getFirstDayInMonth + 2;
                  if (index < getFirstDayInMonth - 1) {
                    return const Text('');
                  }
                  final genDate = DateTime(
                      _changedDate.year, _changedDate.month, dayRender);
                  return Column(
                    children: [
                      InkWell(
                        onTap: () {
                          _onSelecDate(index);
                        },
                        child: Container(
                          width: 35,
                          height: 35,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: _selectedDate == null
                                  ? null
                                  : Border.all(
                                      width: 1, color: getBorderColor(genDate)),
                              color: getColorItem(genDate)),
                          child: Text(
                            dayRender.toString(),
                            style: TextStyle(
                                fontSize: 14.0, color: getColorDay(genDate)),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
