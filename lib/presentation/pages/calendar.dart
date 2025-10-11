import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:hijri/hijri_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime selectedDate = DateTime.now();
  int displayedYear = DateTime.now().year;
  int displayedMonth = DateTime.now().month;

  // Holidays (Friday=5, Saturday=6)
  final Set<int> holidays = {5, 6};

  @override
  Widget build(BuildContext context) {
    final isLargeScreen = MediaQuery.of(context).size.width > 800;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 158, 223, 180),
        title: const Text(
          'Multi-Language Calendar',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Year/Month Navigation
            _buildNavigationBar(),

            const SizedBox(height: 12),

            // Calendar Grid
            Expanded(
              child: isLargeScreen ? _buildDesktopView() : _buildMobileView(),
            ),
          ],
        ),
      ),
    );
  }

  // Navigation Bar for Year/Month
  Widget _buildNavigationBar() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(Icons.chevron_left, size: 28),
            onPressed: () {
              setState(() {
                if (displayedMonth == 1) {
                  displayedMonth = 12;
                  displayedYear--;
                } else {
                  displayedMonth--;
                }
              });
            },
          ),
          const SizedBox(width: 16),
          Text(
            '${DateFormat('MMMM').format(DateTime(displayedYear, displayedMonth))} $displayedYear',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 16),
          IconButton(
            icon: const Icon(Icons.chevron_right, size: 28),
            onPressed: () {
              setState(() {
                if (displayedMonth == 12) {
                  displayedMonth = 1;
                  displayedYear++;
                } else {
                  displayedMonth++;
                }
              });
            },
          ),
        ],
      ),
    );
  }

  // Desktop View - Three columns side by side
  Widget _buildDesktopView() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: _buildEnglishCalendar()),
          const SizedBox(width: 16),
          Expanded(child: _buildBanglaCalendar()),
          const SizedBox(width: 16),
          Expanded(child: _buildHijriCalendar()),
        ],
      ),
    );
  }

  // Mobile View - Tabs
  Widget _buildMobileView() {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          const TabBar(
            labelColor: Colors.green,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.green,
            tabs: [
              Tab(text: 'English'),
              Tab(text: 'বাংলা'),
              Tab(text: 'Hijri'),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                _buildEnglishCalendar(),
                _buildBanglaCalendar(),
                _buildHijriCalendar(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // English Calendar
  Widget _buildEnglishCalendar() {
    return _buildCalendarCard(
      title: 'English Calendar',
      calendarType: CalendarType.english,
      color: Colors.blue,
    );
  }

  // Bangla Calendar
  Widget _buildBanglaCalendar() {
    return _buildCalendarCard(
      title: 'বাংলা ক্যালেন্ডার',
      calendarType: CalendarType.bangla,
      color: Colors.green,
    );
  }

  // Hijri Calendar
  Widget _buildHijriCalendar() {
    return _buildCalendarCard(
      title: 'Hijri Calendar',
      calendarType: CalendarType.hijri,
      color: Colors.purple,
    );
  }

  // Generic Calendar Card
  Widget _buildCalendarCard({
    required String title,
    required CalendarType calendarType,
    required Color color,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: _buildCalendarGrid(calendarType),
            ),
          ],
        ),
      ),
    );
  }

  // Calendar Grid
  Widget _buildCalendarGrid(CalendarType type) {
    List<Widget> dayWidgets = [];

    // Get days in month
    int daysInMonth = DateTime(displayedYear, displayedMonth + 1, 0).day;
    int firstWeekday = DateTime(displayedYear, displayedMonth, 1).weekday % 7;

    // Weekday headers
    List<String> weekDays = type == CalendarType.bangla
        ? ['রবি', 'সোম', 'মঙ্গল', 'বুধ', 'বৃহ', 'শুক্র', 'শনি']
        : ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];

    // Add weekday headers
    for (var day in weekDays) {
      dayWidgets.add(
        Center(
          child: Text(
            day,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
      );
    }

    // Add empty cells before first day
    for (int i = 0; i < firstWeekday; i++) {
      dayWidgets.add(Container());
    }

    // Add day cells
    DateTime today = DateTime.now();
    for (int day = 1; day <= daysInMonth; day++) {
      DateTime date = DateTime(displayedYear, displayedMonth, day);
      bool isToday = date.year == today.year &&
          date.month == today.month &&
          date.day == today.day;
      bool isHoliday = holidays.contains(date.weekday);

      String displayDay = _getDisplayDay(day, type, date);

      dayWidgets.add(
        GestureDetector(
          onTap: () {
            setState(() => selectedDate = date);
            _showDateDetails(date, type);
          },
          child: Container(
            margin: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: isToday
                  ? Colors.green
                  : isHoliday
                      ? Colors.red.withOpacity(0.2)
                      : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: date == selectedDate ? Colors.blue : Colors.transparent,
                width: 2,
              ),
            ),
            child: Center(
              child: Text(
                displayDay,
                style: TextStyle(
                  color: isToday ? Colors.white : Colors.black87,
                  fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ),
      );
    }

    return GridView.count(
      crossAxisCount: 7,
      children: dayWidgets,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
    );
  }

  // Get display day based on calendar type
  String _getDisplayDay(int day, CalendarType type, DateTime date) {
    switch (type) {
      case CalendarType.bangla:
        // Approximate Bangla date conversion
        const banglaDigits = ['০', '১', '২', '৩', '৪', '৫', '৬', '৭', '৮', '৯'];
        return day
            .toString()
            .split('')
            .map((d) => banglaDigits[int.parse(d)])
            .join();

      case CalendarType.hijri:
        HijriCalendar hijri = HijriCalendar.fromDate(date);
        return hijri.hDay.toString();

      default:
        return day.toString();
    }
  }

  // Show date details dialog
  void _showDateDetails(DateTime date, CalendarType type) {
    HijriCalendar hijri = HijriCalendar.fromDate(date);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Date Details'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDateRow('English', DateFormat('MMMM dd, yyyy').format(date)),
            const SizedBox(height: 8),
            _buildDateRow(
                'বাংলা', DateFormat('d MMMM yyyy', 'bn').format(date)),
            const SizedBox(height: 8),
            _buildDateRow('Hijri',
                '${hijri.hDay} ${hijri.longMonthName} ${hijri.hYear} AH'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _buildDateRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 70,
          child: Text(
            '$label:',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: Text(value),
        ),
      ],
    );
  }
}

enum CalendarType { english, bangla, hijri }
