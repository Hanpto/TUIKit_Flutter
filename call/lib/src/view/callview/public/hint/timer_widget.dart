import 'package:tuikit_atomic_x/atomicx.dart';
import 'package:flutter/material.dart';

import '../../core/common/call_colors.dart';

class TimerWidget extends StatefulWidget {
  final double? fontSize;
  final FontWeight? fontWeight;

  const TimerWidget({
    super.key,
    this.fontSize,
    this.fontWeight,
  });

  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  CallParticipantInfo _selfInfo = CallStore.shared.state.selfInfo.value;

  @override
  void initState() {
    super.initState();
    CallStore.shared.state.selfInfo.addListener(_onSelfInfoChanged);
  }

  @override
  void dispose() {
    CallStore.shared.state.selfInfo.removeListener(_onSelfInfoChanged);
    super.dispose();
  }

  void _onSelfInfoChanged() {
    final newValue = CallStore.shared.state.selfInfo.value;
    if (newValue.status == CallParticipantStatus.none) return;
    setState(() => _selfInfo = newValue);
  }

  @override
  Widget build(BuildContext context) {
    if (_selfInfo.status == CallParticipantStatus.accept) {
      return ValueListenableBuilder(
        valueListenable: CallStore.shared.state.activeCall,
        builder: (context, activeCall, child) {
          return Text(
            formatDuration(activeCall.duration.toInt()),
            style: TextStyle(
              fontSize: widget.fontSize,
              fontWeight: widget.fontWeight,
              color: CallStore.shared.state.activeCall.value.mediaType == CallMediaType.audio
                  ? CallColors.colorG7
                  : CallColors.colorWhite,
            ),
          );
        },
      );
    } else {
      return Container();
    }
  }

  String formatDuration(int timeCount) {
    int hour = timeCount ~/ 3600;
    int minute = (timeCount % 3600) ~/ 60;
    String minuteShow = minute <= 9 ? "0$minute" : "$minute";
    int second = timeCount % 60;
    String secondShow = second <= 9 ? "0$second" : "$second";

    if (hour > 0) {
      String hourShow = hour <= 9 ? "0$hour" : "$hour";
      return '$hourShow:$minuteShow:$secondShow';
    } else {
      return '$minuteShow:$secondShow';
    }
  }

}
