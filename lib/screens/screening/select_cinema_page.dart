import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie_ticker_app_flutter/models/movie.dart';
import 'package:movie_ticker_app_flutter/models/screening.dart';
import 'package:movie_ticker_app_flutter/provider/app_provider.dart';
import 'package:movie_ticker_app_flutter/provider/cinema_provider.dart';
import 'package:movie_ticker_app_flutter/screens/seat/select_seat_page.dart';
import 'package:movie_ticker_app_flutter/themes/app_colors.dart';
import 'package:movie_ticker_app_flutter/themes/app_styles.dart';
import 'package:movie_ticker_app_flutter/utils/constants.dart';
import 'package:provider/provider.dart';

class SelectCinemaPage extends StatefulWidget {
  static const String routeName = '/select_cinema_page';

  const SelectCinemaPage({super.key});

  @override
  State<SelectCinemaPage> createState() => _SelectCinemaPageState();
}

class _SelectCinemaPageState extends State<SelectCinemaPage> {
  Screening? selectedScreening;
  String? _selectedCity;
  late List<bool> _isSelected;
  late List<DateTime> days;
  DateTime? _selectedDate;
  bool _citySelected = false;

  get provider => null; // Biến kiểm tra tỉnh thành đã được chọn hay chưa

  @override
  void initState() {
    super.initState();
    final appProvider = Provider.of<AppProvider>(context, listen: false);
    final cinemaProvider = Provider.of<CinemaProvider>(context, listen: false);

    Future.microtask(() {
      appProvider.reset();
      appProvider.clearSelection();
      cinemaProvider.getCityToAddress();
    });
    days = _generateDays();
    _isSelected = List<bool>.generate(days.length, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;
    final size = MediaQuery.of(context).size;
    final provider = Provider.of<AppProvider>(context);
    final provider2 = Provider.of<CinemaProvider>(context);
    final screeningsByCinema = provider.screeningsByCinema;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(movie.title),
        backgroundColor: AppColors.darkerBackground,
        foregroundColor: AppColors.white,
      ),
      body: SafeArea(
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Row(
                  children: provider2.citys.map((city) {
                    final bool isSelected = city == _selectedCity;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: GestureDetector(
                        onTap: () async {
                          setState(() {
                            _selectedCity = city;
                            _citySelected = true;
                            _selectedDate = null;
                            _isSelected = List<bool>.generate(
                                days.length, (index) => false);
                            provider.reset();
                            provider.clearSelection();
                            selectedScreening = null;
                          });
                          provider2.fetchCinemasByCity(city);
                          await provider.getScreeningsByMovieAndCity(
                              movie, _selectedCity!, _selectedDate!);
                        },
                        child: Chip(
                          label: Text(
                            city,
                            style: const TextStyle(fontSize: 16),
                          ),
                          backgroundColor: isSelected
                              ? AppColors.blueMain
                              : AppColors.darkerBackground,
                          labelPadding:
                              const EdgeInsets.symmetric(horizontal: 8.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            side: isSelected
                                ? const BorderSide(color: AppColors.blueMain)
                                : BorderSide.none,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            if (_citySelected) // Hiển thị danh sách ngày nếu đã chọn tỉnh thành
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Row(
                    children: List.generate(days.length, (index) {
                      return GestureDetector(
                        onTap: () async {
                          _updateSelected(index);
                          _selectedDate = days[index];
                          await provider.getScreeningsByMovieAndCity(
                              movie, _selectedCity!, _selectedDate!);
                        },
                        child: Container(
                          height: size.height / 10,
                          width: size.width / 6,
                          margin: const EdgeInsets.only(right: kDefaultPadding),
                          decoration: BoxDecoration(
                              borderRadius: kDefaultBorderRadius,
                              color: _isSelected[index]
                                  ? AppColors.blueMain
                                  : AppColors.darkerBackground,
                              border: _isSelected[index]
                                  ? null
                                  : Border.all(color: AppColors.grey)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                _formatDay(days[index]),
                                style: AppStyles.h4.copyWith(
                                  color: AppColors.white,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: kMinPadding),
                                child: Text(
                                  days[index].day.toString(),
                                  style: AppStyles.h5.copyWith(
                                    color: AppColors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
            const SizedBox(
              height: 20,
            ),
            if (_citySelected)
              Expanded(
                child: provider.screenings.isEmpty
                    ? const Center(child: Text('Không có suất chiếu'))
                    : ListView.builder(
                        itemCount: screeningsByCinema.length,
                        itemBuilder: (context, index) {
                          final cinemaName =
                              screeningsByCinema.keys.elementAt(index);
                          final screenings = screeningsByCinema[cinemaName]!;
                          return SizedBox(
                            height: 130, // Điều chỉnh chiều cao ở đây
                            child: ListTile(
                              title: Text(cinemaName, style: AppStyles.h2),
                              subtitle: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: screenings.map((screening) {
                                    final format =
                                        DateFormat("yyyy-MM-dd HH:mm");
                                    final screeningDateTime = format.parse(
                                        '${screening.date} ${screening.start}');
                                    final isPast = screeningDateTime
                                        .isBefore(DateTime.now());
                                    final isSelected =
                                        provider.selectedScreening == screening;

                                    return GestureDetector(
                                      onTap: isPast
                                          ? null
                                          : () {
                                              provider
                                                  .selectScreening(screening);
                                              setState(() {
                                                selectedScreening = screening;
                                              });
                                            },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 4.0, vertical: 12),
                                        child: SizedBox(
                                          width: 80,
                                          height: 40,
                                          child: Container(
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color: isSelected
                                                  ? AppColors.blueMain
                                                  : (isPast
                                                      ? AppColors.grey
                                                      : AppColors
                                                          .darkerBackground),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              border: Border.all(
                                                color: isSelected
                                                    ? AppColors.blueMain
                                                    : AppColors.grey,
                                              ),
                                            ),
                                            child: Text(
                                              screening.start,
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  color: AppColors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            if (_citySelected)
              Padding(
                padding: const EdgeInsets.only(
                    bottom: kMediumPadding, top: kMediumPadding),
                child: GestureDetector(
                  onTap: selectedScreening != null
                      ? () {
                          Navigator.of(context).pushNamed(
                            SelectSeatPage.routeName,
                            arguments: {
                              'movie': movie,
                              'screening': selectedScreening,
                            },
                          );
                        }
                      : null,
                  child: Container(
                    height: size.height / 15,
                    width: size.height / 9,
                    decoration: BoxDecoration(
                      color: selectedScreening == null
                          ? AppColors.darkerBackground
                          : AppColors.blueMain,
                      borderRadius: kDefaultBorderRadius,
                      border: selectedScreening == null
                          ? Border.all(color: AppColors.grey)
                          : null,
                    ),
                    child: Center(
                      child: Icon(
                        Icons.arrow_forward,
                        color: selectedScreening != null
                            ? AppColors.white
                            : AppColors.grey,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  List<DateTime> _generateDays() {
    List<DateTime> days = [];
    DateTime today = DateTime.now();
    for (int i = 0; i < 7; i++) {
      days.add(today.add(Duration(days: i)));
    }
    return days;
  }

  String _formatDay(DateTime date) {
    List<String> weekdays = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    return weekdays[date.weekday % 7];
  }

  void _updateSelected(int selectedIndex) {
    setState(() {
      _isSelected = List<bool>.generate(
        days.length,
        (index) => index == selectedIndex ? true : false,
      );
    });
  }
}
