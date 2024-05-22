import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:service_app/assets/color/colors.dart';
import 'package:service_app/globals/source/database_helper.dart';
import 'package:service_app/modules/calendar/presentation/widgets/payment_item.dart';
import 'package:service_app/modules/home/data/model/service_model.dart';
import 'package:service_app/modules/settings/presentation/bloc/date_selection_bloc.dart';
import 'package:service_app/utils/functions.dart';
import 'package:service_app/utils/text_styles.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final CalendarFormat _calendarFormat = CalendarFormat.month;
  final DateTime _focusedDay = DateTime.now();
  late DateSelectionBloc dateSelectionBloc;

  @override
  void initState() {
    dateSelectionBloc = DateSelectionBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('rebuild');
    return BlocProvider.value(
      value: dateSelectionBloc,
      child: Scaffold(
        body: SingleChildScrollView(
          child: FutureBuilder(
              future: DatabaseHelper.getServices(),
              builder: (context, snapshot) {
                print('rebuild future');
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                } else if (snapshot.hasData) {
                  if (snapshot.data != null && snapshot.data!.isNotEmpty) {
                    List<ServiceModel> endsEqualNow =
                        snapshot.data!.where((service) {
                      return dateComparison(service.end);
                    }).toList();

                    List<ServiceModel> endsNotEqualNow =
                        snapshot.data!.where((service) {
                      return !dateComparison(service.end);
                    }).toList();
                    DateTime now = DateTime.now();
                    List<ServiceModel> lowDates =
                        snapshot.data!.where((service) {
                      DateTime endDateTime =
                          DateFormat('dd.MM.yy').parse(service.end);
                      return endDateTime.isBefore(now);
                    }).toList();

                    List<ServiceModel> highDates =
                        snapshot.data!.where((service) {
                      DateTime endDateTime =
                          DateFormat('dd.MM.yy').parse(service.end);
                      return endDateTime.isAfter(now);
                    }).toList();
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(16,
                              MediaQuery.paddingOf(context).top + 20, 16, 0),
                          child: BlocBuilder<DateSelectionBloc,
                              DateSelectionState>(
                            builder: (context, state) {
                              return TableCalendar(
                                headerStyle: const HeaderStyle(
                                  formatButtonVisible: false,
                                  titleCentered: true,
                                ),
                                eventLoader: (day) {
                                  List<ServiceModel> eventsOnDay = [];

                                  for (ServiceModel event in snapshot.data!) {
                                    DateTime eventDate =
                                        DateFormat('dd.MM.yy').parse(event.end);
                                    String formattedEventDate =
                                        DateFormat('dd.MM.yy')
                                            .format(eventDate);
                                    String formattedSelectedDate =
                                        DateFormat('dd.MM.yy').format(day);

                                    if (formattedEventDate ==
                                        formattedSelectedDate) {
                                      eventsOnDay.add(event);
                                    }
                                  }
                                  return eventsOnDay;
                                },
                                focusedDay: _focusedDay,
                                firstDay: DateTime(2024),
                                lastDay: DateTime(2030),
                                calendarFormat: _calendarFormat,
                                selectedDayPredicate: (day) {
                                  return isSameDay(state.selectedDay, day);
                                },
                                onDaySelected: (selectedDay, focusedDay) {
                                  context
                                      .read<DateSelectionBloc>()
                                      .add(SelectedDate(date: selectedDay));
                                },
                                calendarStyle: CalendarStyle(
                                  todayDecoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.blue.withOpacity(0.5),
                                  ),
                                  selectedDecoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.blue,
                                  ),
                                  markersMaxCount: 3,
                                  markerDecoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: primaryColor,
                                  ),
                                  markersAlignment: Alignment.bottomCenter,
                                ),
                                daysOfWeekStyle: const DaysOfWeekStyle(
                                  weekendStyle: TextStyle(color: Colors.red),
                                  weekdayStyle: TextStyle(color: Colors.black),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 12),
                        BlocBuilder<DateSelectionBloc, DateSelectionState>(
                          builder: (context, state) {
                            DateTime selectedDate =
                                state.selectedDay ?? DateTime.now();

                            List<ServiceModel> filteredItems = snapshot.data!
                                .where((item) =>
                                    dateComparison2(item.end, selectedDate))
                                .toList();

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                dateComparison(DateFormat("dd.MM.yy")
                                        .format(selectedDate))
                                    ? const SizedBox()
                                    : Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16),
                                        child: Text(
                                          filteredItems.isEmpty
                                              ? 'You not have payments   for  ${DateFormat("dd MMM").format(selectedDate)}  '
                                              : 'Payments for  ${DateFormat("dd MMM").format(selectedDate)}',
                                          style: darkStyle(context).copyWith(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                const SizedBox(
                                  height: 12,
                                ),
                                if (dateComparison(DateFormat("dd.MM.yy")
                                    .format(selectedDate))) ...{
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      if (endsEqualNow.isNotEmpty) ...{
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16.0),
                                          child: Text(
                                            'Today payments',
                                            style: darkStyle(context).copyWith(
                                                fontSize: 24,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                        SizedBox(
                                          height: 100,
                                          child: ListView.separated(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16.0),
                                            scrollDirection: Axis.horizontal,
                                            itemCount: endsEqualNow.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return PaymentItem(
                                                isToday: true,
                                                model: endsEqualNow[index],
                                              );
                                            },
                                            separatorBuilder:
                                                (BuildContext context,
                                                    int index) {
                                              return const SizedBox(
                                                width: 12,
                                              );
                                            },
                                          ),
                                        ),
                                      },
                                    ],
                                  )
                                } else if (filteredItems.isEmpty) ...{
                                  const SizedBox()
                                } else ...{
                                  SizedBox(
                                    height: 90,
                                    child: ListView.separated(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0),
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) =>
                                          PaymentItem(
                                        model: filteredItems[index],
                                      ),
                                      itemCount: filteredItems.length,
                                      separatorBuilder:
                                          (BuildContext context, int index) {
                                        return const SizedBox(
                                          width: 8,
                                        );
                                      },
                                    ),
                                  ),
                                }
                              ],
                            );
                          },
                        ),
                        const SizedBox(height: 48),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            'Upcoming payments',
                            style: darkStyle(context).copyWith(
                                fontSize: 24, fontWeight: FontWeight.w600),
                          ),
                        ),
                        const SizedBox(height: 16),
                        highDates.isEmpty
                            ? Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Text(
                                  'You do not have upcoming payments',
                                  style: greyStyle(context).copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                              )
                            : SizedBox(
                                height: 90,
                                child: ListView.separated(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) => PaymentItem(
                                    model: highDates[index],
                                  ),
                                  itemCount: highDates.length,
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return const SizedBox(
                                      width: 8,
                                    );
                                  },
                                ),
                              ),
                      ],
                    );
                  } else {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(16,
                              MediaQuery.paddingOf(context).top + 20, 16, 0),
                          child: BlocBuilder<DateSelectionBloc,
                              DateSelectionState>(
                            builder: (context, state) {
                              return TableCalendar(
                                headerStyle: const HeaderStyle(
                                  formatButtonVisible: false,
                                  titleCentered: true,
                                ),
                                eventLoader: (day) {
                                  List<ServiceModel> eventsOnDay = [];

                                  for (ServiceModel event in snapshot.data!) {
                                    DateTime eventDate =
                                        DateFormat('dd.MM.yy').parse(event.end);
                                    String formattedEventDate =
                                        DateFormat('dd.MM.yy')
                                            .format(eventDate);
                                    String formattedSelectedDate =
                                        DateFormat('dd.MM.yy').format(day);

                                    if (formattedEventDate ==
                                        formattedSelectedDate) {
                                      eventsOnDay.add(event);
                                    }
                                  }
                                  return eventsOnDay;
                                },
                                focusedDay: _focusedDay,
                                firstDay: DateTime(2024),
                                lastDay: DateTime(2030),
                                calendarFormat: _calendarFormat,
                                selectedDayPredicate: (day) {
                                  return isSameDay(state.selectedDay, day);
                                },
                                onDaySelected: (selectedDay, focusedDay) {
                                  context
                                      .read<DateSelectionBloc>()
                                      .add(SelectedDate(date: selectedDay));
                                },
                                calendarStyle: CalendarStyle(
                                  todayDecoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.blue.withOpacity(0.5),
                                  ),
                                  selectedDecoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.blue,
                                  ),
                                  markersMaxCount: 3,
                                  markerDecoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: primaryColor,
                                  ),
                                  markersAlignment: Alignment.bottomCenter,
                                ),
                                daysOfWeekStyle: const DaysOfWeekStyle(
                                  weekendStyle: TextStyle(color: Colors.red),
                                  weekdayStyle: TextStyle(color: Colors.black),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Subscribe for first service!',
                          style: darkStyle(context).copyWith(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        )
                      ],
                    );
                  }
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            16, MediaQuery.paddingOf(context).top + 20, 16, 0),
                        child:
                            BlocBuilder<DateSelectionBloc, DateSelectionState>(
                          builder: (context, state) {
                            return TableCalendar(
                              headerStyle: const HeaderStyle(
                                formatButtonVisible: false,
                                titleCentered: true,
                              ),
                              focusedDay: _focusedDay,
                              firstDay: DateTime(2024),
                              lastDay: DateTime(2030),
                              calendarFormat: _calendarFormat,
                              selectedDayPredicate: (day) {
                                return isSameDay(state.selectedDay, day);
                              },
                              onDaySelected: (selectedDay, focusedDay) {
                                context
                                    .read<DateSelectionBloc>()
                                    .add(SelectedDate(date: selectedDay));
                              },
                              calendarStyle: CalendarStyle(
                                todayDecoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.blue.withOpacity(0.5),
                                ),
                                selectedDecoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.blue,
                                ),
                                markersMaxCount: 3,
                                markerDecoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: primaryColor,
                                ),
                                markersAlignment: Alignment.bottomCenter,
                              ),
                              daysOfWeekStyle: const DaysOfWeekStyle(
                                weekendStyle: TextStyle(color: Colors.red),
                                weekdayStyle: TextStyle(color: Colors.black),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Center(
                        child: Text(
                          'Subscribe for first service!',
                          style: darkStyle(context).copyWith(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                      )
                    ],
                  );
                }
              }),
        ),
      ),
    );
  }
}
