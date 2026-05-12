import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:mobile_assistant_ia/core/constants/app_colors.dart';
import '../features/agenda/presentation/bloc/agenda_bloc.dart';
import '../features/agenda/data/models/event_model.dart';

class AgendaScreen extends StatefulWidget {
  const AgendaScreen({super.key});

  @override
  State<AgendaScreen> createState() => _AgendaScreenState();
}

class _AgendaScreenState extends State<AgendaScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    context.read<AgendaBloc>().add(const LoadEvents());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calendrier"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showCreateEventDialog(context),
          ),
        ],
      ),
      body: BlocBuilder<AgendaBloc, AgendaState>(
        builder: (context, state) {
          if (state is AgendaLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final events = state is AgendaLoaded ? state.events : <EventModel>[];

          return Column(
            children: [
              // Calendar
              TableCalendar(
                firstDay: DateTime.utc(2024, 1, 1),
                lastDay: DateTime.utc(2026, 12, 31),
                focusedDay: _focusedDay,
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                },
                calendarFormat: CalendarFormat.month,
                headerStyle: const HeaderStyle(formatButtonVisible: false),
              ),

              const Divider(),

              // Today's events
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Aujourd'hui • ${DateFormat('dd MMMM', 'fr_FR').format(DateTime.now())}",
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Text("${events.length} événements", style: const TextStyle(color: AppColors.textSecondary)),
                  ],
                ),
              ),

              Expanded(
                child: ListView.builder(
                  itemCount: events.length,
                  itemBuilder: (context, index) {
                    final event = events[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: ListTile(
                        leading: Container(
                          width: 4,
                          height: 50,
                          color: AppColors.primary,
                        ),
                        title: Text(event.title, style: const TextStyle(fontWeight: FontWeight.w600)),
                        subtitle: Text("${event.time}\n${event.participants ?? ''}"),
                        trailing: const Text("Rejoindre", style: TextStyle(color: AppColors.primary)),
                        onTap: () => _showEventDetails(context, event),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildBottomNav() {
    return BottomNavigationBar(
      currentIndex: 1,
      selectedItemColor: AppColors.primary,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Chat"),
        BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: "Agenda"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profil"),
      ],
      onTap: (index) {
        // Navigation via GoRouter
      },
    );
  }
}