import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:phpc_v2/Models/event_page_model.dart';

Event EventToCalendar(EventsModel event) {
  Event calendarEvent = Event(
    title: event.name,
    startDate: event.startDateTime,
    endDate: event.startDateTime.add(const Duration(minutes: 60)),
  );
  return calendarEvent;
}
