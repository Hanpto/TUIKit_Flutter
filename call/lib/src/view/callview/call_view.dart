import 'package:atomic_x_core/atomicxcore.dart';
import 'package:flutter/material.dart';
import 'package:tencent_calls_uikit/src/view/callview/public/float/call_float_widget.dart';
import 'package:tencent_calls_uikit/src/view/callview/public/multi/call_grid_widget.dart';
import 'package:tencent_calls_uikit/src/view/callview/public/pip/call_pip_widget.dart';

class CallView extends StatefulWidget {
  final bool isPipMode;
  final bool enableAITranscriber;

  const CallView({
    super.key,
    this.enableAITranscriber = false,
    this.isPipMode = false,
  });

  @override
  State<CallView> createState() => _CallViewState();
}

class _CallViewState extends State<CallView> {
  late final CallCoreController controller;
  CallInfo _activeCall = CallStore.shared.state.activeCall.value;

  @override
  void initState() {
    controller = CallCoreController.create();
    super.initState();
    CallStore.shared.state.activeCall.addListener(_onActiveCallChanged);
  }

  @override
  void dispose() {
    CallStore.shared.state.activeCall.removeListener(_onActiveCallChanged);
    controller.dispose();
    super.dispose();
  }

  void _onActiveCallChanged() {
    final newValue = CallStore.shared.state.activeCall.value;
    if (newValue.callId.isEmpty) return;
    setState(() => _activeCall = newValue);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Builder(
          builder: (context) {
            if (widget.isPipMode) {
              controller.setLayoutTemplate(CallLayoutTemplate.pip);
              return CallPipWidget(
                controller: controller,
              );
            }

            if (_activeCall.chatGroupId.isNotEmpty || _activeCall.inviteeIds.length > 1) {
              controller.setLayoutTemplate(CallLayoutTemplate.grid);
              return CallGridWidget(
                controller: controller,
                enableAITranscriber: widget.enableAITranscriber,
              );
            }

            controller.setLayoutTemplate(CallLayoutTemplate.float);
            return CallFloatWidget(
              controller: controller,
              enableAITranscriber: widget.enableAITranscriber,
            );
          },
        ),
      ),
    );
  }
}