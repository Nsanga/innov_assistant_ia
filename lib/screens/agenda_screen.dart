import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:mobile_assistant_ia/core/constants/app_colors.dart';
import '../features/agenda/presentation/bloc/agenda_bloc.dart';
import '../features/agenda/data/models/event_model.dart';
import '../widgets/agenda/calendar_header.dart';
import '../widgets/agenda/event_card.dart';
import '../widgets/agenda/upcoming_event_row.dart';
import '../widgets/app_bars/agenda_app_bar.dart';

class AgendaScreen extends StatefulWidget {
  const AgendaScreen({super.key});

  @override
  State<AgendaScreen> createState() => _AgendaScreenState();
}

class _AgendaScreenState extends State<AgendaScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;

  @override
  void initState() {
    super.initState();
    context.read<AgendaBloc>().add(const LoadEvents());
  }

  void _previousMonth() {
    setState(() {
      _focusedDay = DateTime(
        _focusedDay.year,
        _focusedDay.month - 1,
        1,
      );
    });
  }

  void _nextMonth() {
    setState(() {
      _focusedDay = DateTime(
        _focusedDay.year,
        _focusedDay.month + 1,
        1,
      );
    });
  }

  void _onCreateEvent() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Création d\'événement en cours de développement'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AgendaAppBar(onCreateEvent: _onCreateEvent),
      body: BlocBuilder<AgendaBloc, AgendaState>(
        builder: (context, state) {
          if (state is AgendaLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          }

          final allEvents = state is AgendaLoaded ? state.events : <EventModel>[];

          final todayEvents = allEvents
              .where((e) => isSameDay(e.date, _selectedDay))
              .toList();

          final upcomingEvents = allEvents
              .where((e) =>
                  e.date.isAfter(_selectedDay) &&
                  e.date.isBefore(
                      _selectedDay.add(const Duration(days: 7))))
              .toList();

          return CustomScrollView(
            slivers: [
              // ── Calendrier ─────────────────────────────────────────────
              SliverToBoxAdapter(
                child: _buildCalendar(allEvents),
              ),

              // ── Section aujourd'hui ────────────────────────────────────
              if (todayEvents.isNotEmpty) ...[
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Aujourd'hui · ${DateFormat('dd MMMM', 'fr_FR').format(_selectedDay)}",
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                            letterSpacing: -0.3,
                          ),
                        ),
                        Text(
                          '${todayEvents.length} événements',
                          style: const TextStyle(
                            fontSize: 13,
                            color: AppColors.textSecondary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => EventCard(
                        event: todayEvents[index],
                        onJoin: () {
                          // TODO: Rejoindre l'événement
                        },
                      ),
                      childCount: todayEvents.length,
                    ),
                  ),
                ),
              ] else ...[
                // Message quand il n'y a pas d'événements
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    child: Center(
                      child: Column(
                        children: [
                          Icon(
                            Icons.event_busy_rounded,
                            size: 48,
                            color: AppColors.textHint.withOpacity(0.5),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Aucun événement aujourd\'hui',
                            style: TextStyle(
                              fontSize: 15,
                              color: AppColors.textHint.withOpacity(0.7),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],

              // ── Section "À venir" ──────────────────────────────────────
              if (upcomingEvents.isNotEmpty) ...[
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 16, 20, 4),
                    child: Text(
                      'À venir cette semaine',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                        letterSpacing: -0.3,
                      ),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => UpcomingEventRow(
                        event: upcomingEvents[index],
                        onTap: () {
                          setState(() {
                            _selectedDay = upcomingEvents[index].date;
                            _focusedDay = upcomingEvents[index].date;
                          });
                        },
                      ),
                      childCount: upcomingEvents.length,
                    ),
                  ),
                ),
              ],

              const SliverToBoxAdapter(child: SizedBox(height: 24)),
            ],
          );
        },
      ),
    );
  }

  Widget _buildCalendar(List<EventModel> allEvents) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        children: [
          CalendarHeader(
            focusedDay: _focusedDay,
            onPreviousMonth: _previousMonth,
            onNextMonth: _nextMonth,
          ),
          TableCalendar<EventModel>(
            firstDay: DateTime.utc(2024, 1, 1),
            lastDay: DateTime.utc(2027, 12, 31),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            calendarFormat: _calendarFormat,
            eventLoader: (day) =>
                allEvents.where((e) => isSameDay(e.date, day)).toList(),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            onPageChanged: (focusedDay) {
              setState(() => _focusedDay = focusedDay);
            },
            headerVisible: false,
            daysOfWeekHeight: 32,
            rowHeight: 44,
            calendarStyle: CalendarStyle(
              selectedDecoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(12),
              ),
              selectedTextStyle: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
              todayDecoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              todayTextStyle: const TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
              defaultTextStyle: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 14,
              ),
              weekendTextStyle: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 14,
              ),
              outsideTextStyle: const TextStyle(
                color: AppColors.textHint,
                fontSize: 14,
              ),
              markerDecoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              markerSize: 5,
              markersMaxCount: 1,
              cellMargin: const EdgeInsets.all(4),
            ),
            daysOfWeekStyle: const DaysOfWeekStyle(
              weekdayStyle: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.textSecondary,
              ),
              weekendStyle: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}