import 'package:phpc_v2/Models/sermon_model.dart';

List<SermonsModel> filterSermons(String seriesId, List<SermonsModel> sermons) {
  List<SermonsModel> filteredSermons =
      sermons.where((i) => i.sermonSeries == seriesId).toList();
  filteredSermons.sort((a, b) {
    return a.dateOfSermon.compareTo(b.dateOfSermon);
  });

  return filteredSermons;
}
