import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:stream_feed/stream_feed.dart';
import 'package:pxp_flutter/pages/feed/activity_item.dart';
import 'package:pxp_flutter/pages/feed/extension.dart';

class TimelineScreen extends StatefulWidget {
  const TimelineScreen({
    required this.currentUser,
    Key? key,
  }) : super(key: key);

  final StreamUser currentUser;

  @override
  _TimelineScreenState createState() => _TimelineScreenState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<StreamUser>('currentUser', currentUser));
  }
}

class _TimelineScreenState extends State<TimelineScreen> {
  late StreamFeedClient _client;
  bool _isLoading = true;
  List<Activity> activities = <Activity>[];

  late final Subscription _feedSubscription;

  Future<void> _listenToFeed() async {
    _feedSubscription = await _client
        .flatFeed('timeline', widget.currentUser.id)
        // ignore: avoid_print
        .subscribe(print);
  }

  Future<void> _loadActivities({bool pullToRefresh = false}) async {
    if (!pullToRefresh) setState(() => _isLoading = true);
    final userFeed = _client.flatFeed('timeline', widget.currentUser.id);
    final data = await userFeed.getActivities();
    if (!pullToRefresh) _isLoading = false;
    setState(() => activities = data);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _client = context.client;
    _listenToFeed();
    _loadActivities();
  }

  @override
  void dispose() {
    super.dispose();
    _feedSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () => _loadActivities(pullToRefresh: true),
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : activities.isEmpty
                ? Column(
                    children: [
                      const Text('No activities yet!'),
                      ElevatedButton(
                        onPressed: _loadActivities,
                        child: const Text('Reload'),
                      )
                    ],
                  )
                : ListView.separated(
                    itemCount: activities.length,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    separatorBuilder: (_, __) => const Divider(),
                    itemBuilder: (_, index) {
                      final activity = activities[index];
                      return ActivityCard(activity: activity);
                    },
                  ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty<Activity>('activities', activities));
  }
}
