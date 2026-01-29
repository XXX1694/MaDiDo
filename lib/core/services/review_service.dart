import 'package:in_app_review/in_app_review.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReviewService {
  ReviewService(this._prefs);
  final SharedPreferences _prefs;
  final InAppReview _inAppReview = InAppReview.instance;

  static const _kCompletedTasksCount = 'completed_tasks_count';
  static const _kLastRequestDate = 'last_request_date';
  static const _kIsRated = 'is_rated';

  int get completedTasksCount => _prefs.getInt(_kCompletedTasksCount) ?? 0;
  bool get isRated => _prefs.getBool(_kIsRated) ?? false;

  Future<void> incrementCompletedTasks() async {
    final current = completedTasksCount;
    await _prefs.setInt(_kCompletedTasksCount, current + 1);
  }

  Future<bool> shouldShowReview() async {
    // If user already rated, don't show
    if (isRated) return false;

    // Show after at least 1 tasks completed (changed from 5 for testing)
    final completedCount = completedTasksCount;
    if (completedCount < 1) return false;

    // Show only once every 30 days if they didn't rate it yet
    final lastRequestStr = _prefs.getString(_kLastRequestDate);
    if (lastRequestStr != null) {
      final lastRequest = DateTime.parse(lastRequestStr);
      final now = DateTime.now();
      if (now.difference(lastRequest).inDays < 14) {
        return false;
      }
    }

    return _inAppReview.isAvailable();
  }

  Future<void> requestReview() async {
    await _prefs.setString(_kLastRequestDate, DateTime.now().toIso8601String());
    if (await _inAppReview.isAvailable()) {
      await _inAppReview.requestReview();
      await _prefs.setBool(_kIsRated, true);
    }
  }

  Future<void> openStore() async {
    await _inAppReview.openStoreListing();
    await _prefs.setBool(_kIsRated, true);
  }

  Future<void> markAsRated() async {
    await _prefs.setBool(_kIsRated, true);
  }

  Future<void> postponeReview() async {
    await _prefs.setString(_kLastRequestDate, DateTime.now().toIso8601String());
  }
}
