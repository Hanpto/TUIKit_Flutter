import 'package:tencent_calls_uikit/src/view/callview/core/common/widget/controls_button.dart';
import 'package:atomic_x_core/atomicxcore.dart';
import 'package:flutter/material.dart';
import 'package:tencent_calls_uikit/src/manager/call_manager.dart';
import 'package:tuikit_atomic_x/base_component/localizations/atomic_localizations.dart';

import '../../core/common/call_colors.dart';

typedef _ViewBuilder = Widget Function();

class SingleCallControlsWidget extends StatefulWidget {
  const SingleCallControlsWidget({super.key});

  @override
  State<SingleCallControlsWidget> createState() => _SingleCallControlsWidgetState();
}

class _SingleCallControlsWidgetState extends State<SingleCallControlsWidget> {
  late final Map<String, _ViewBuilder> _viewStrategies;
  late AtomicLocalizations _l10n;

  CallInfo _activeCall = CallStore.shared.state.activeCall.value;
  CallParticipantInfo _selfInfo = CallStore.shared.state.selfInfo.value;

  @override
  void initState() {
    super.initState();
    _viewStrategies = _getViewStrategies();
    CallStore.shared.state.activeCall.addListener(_onActiveCallChanged);
    CallStore.shared.state.selfInfo.addListener(_onSelfInfoChanged);
  }

  @override
  void dispose() {
    CallStore.shared.state.activeCall.removeListener(_onActiveCallChanged);
    CallStore.shared.state.selfInfo.removeListener(_onSelfInfoChanged);
    super.dispose();
  }

  void _onActiveCallChanged() {
    final newValue = CallStore.shared.state.activeCall.value;
    if (newValue.mediaType == null) return;
    setState(() => _activeCall = newValue);
  }

  void _onSelfInfoChanged() {
    final newValue = CallStore.shared.state.selfInfo.value;
    if (newValue.status == CallParticipantStatus.none) return;
    setState(() => _selfInfo = newValue);
  }

  @override
  Widget build(BuildContext context) {
    _l10n = AtomicLocalizations.of(context);
    if (_activeCall.mediaType == null) {
      return Container();
    }
    final type = _activeCall.mediaType!;
    final role = _selfInfo.id == _activeCall.inviterId ? "caller" : "called";
    return _selectViewStrategy(type, _selfInfo.status, role);
  }

  Map<String, _ViewBuilder> _getViewStrategies() {
    return {
      'audio_waiting_caller': _buildAudioCallerWaitingView,
      'audio_waiting_called': _buildAudioAndVideoCalleeWaitingView,
      'audio_accept': _buildAudioAcceptedView,
      'video_waiting_caller': _buildVideoCallerWaitingView,
      'video_waiting_called': _buildAudioAndVideoCalleeWaitingView,
      'video_accept': _buildVideoCallerAndCalleeAcceptedView,
    };
  }

  String _generateViewKey(CallMediaType mediaType, CallParticipantStatus status, String role) {
    final mediaStr = mediaType.toString().split('.').last;
    final statusStr = status.toString().split('.').last;

    return '${mediaStr}_${statusStr}_$role'.toLowerCase();
  }

  String _generateAcceptViewKey(CallMediaType mediaType, CallParticipantStatus status) {
    if (status != CallParticipantStatus.accept) return '';

    final mediaStr = mediaType.toString().split('.').last;
    final statusStr = status.toString().split('.').last;

    return '${mediaStr}_${statusStr}'.toLowerCase();
  }

  Widget _selectViewStrategy(CallMediaType mediaType, CallParticipantStatus status, String role) {
    final preciseKey = _generateViewKey(mediaType, status, role);
    if (_viewStrategies.containsKey(preciseKey)) {
      return _viewStrategies[preciseKey]!();
    }

    if (status == CallParticipantStatus.accept) {
      final acceptKey = _generateAcceptViewKey(mediaType, status);
      if (_viewStrategies.containsKey(acceptKey)) {
        return _viewStrategies[acceptKey]!();
      }
    }

    return Container();
  }

  Widget _buildVideoCallerWaitingView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          _getSwitchCameraButton(),
          _getHangupButton(tips: _l10n.callCancel),
          _getCameraControlButton(),
        ]),
      ],
    );
  }

  Widget _buildAudioAndVideoCalleeWaitingView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          _getRejectButton(),
          _getAcceptButton(),
        ]),
      ],
    );
  }

  Widget _buildAudioCallerWaitingView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _getMicControlButton(),
        _getHangupButton(tips: _l10n.callCancel),
        _getSpeakerphoneButton(),
      ],
    );
  }

  Widget _buildAudioAcceptedView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _getMicControlButton(),
        _getHangupButton(),
        _getSpeakerphoneButton(),
      ],
    );
  }

  Widget _buildVideoCallerAndCalleeAcceptedView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _getMicControlButton(),
            _getSpeakerphoneButton(),
            _getCameraControlButton(),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          const SizedBox(
            width: 100,
          ),
          _getHangupButton(),
          ValueListenableBuilder(
              valueListenable: DeviceStore.shared.state.cameraStatus,
              builder: (context, value, child) {
                return value == DeviceStatus.on
                    ? _getSwitchCameraSmallButton()
                    : const SizedBox(
                        width: 100,
                      );
              }),
        ]),
      ],
    );
  }

  Widget _getSwitchCameraButton() {
    return ControlsButton(
      imgUrl: "call_assets/switch_camera_group.png",
      tips: _l10n.callSwitchCamera,
      textColor: _getTextColor(),
      imgHeight: 60,
      onTap: () {
        CallManager.instance.switchCamera(!DeviceStore.shared.state.isFrontCamera.value);
      },
    );
  }

  Widget _getAcceptButton() {
    return ControlsButton(
      imgUrl: "call_assets/dialing.png",
      tips: _l10n.callAcceptAction,
      textColor: CallColors.colorG7,
      imgHeight: 60,
      onTap: () {
        CallManager.instance.accept();
      },
    );
  }

  Widget _getHangupButton({String? tips}) {
    return ControlsButton(
      imgUrl: "call_assets/hangup.png",
      tips: tips ?? _l10n.callHangUp,
      textColor: CallColors.colorG7,
      imgHeight: 60,
      onTap: () {
        CallManager.instance.hangup();
      },
    );
  }

  Widget _getRejectButton() {
    return ControlsButton(
      imgUrl: "call_assets/hangup.png",
      tips: _l10n.callHangUp,
      textColor: CallColors.colorG7,
      imgHeight: 60,
      onTap: () {
        CallManager.instance.reject();
      },
    );
  }

  Widget _getMicControlButton() {
    return ValueListenableBuilder(
        valueListenable: DeviceStore.shared.state.microphoneStatus,
        builder: (context, value, child) {
          return ControlsButton(
            imgUrl: value == DeviceStatus.on ? "call_assets/mute.png" : "call_assets/mute_on.png",
            tips: value == DeviceStatus.on ? _l10n.callMicrophoneIsOn : _l10n.callMicrophoneIsOff,
            textColor: _getTextColor(),
            imgHeight: 60,
            onTap: () {
              if (value == DeviceStatus.on) {
                CallManager.instance.closeLocalMicrophone();
              } else {
                CallManager.instance.openLocalMicrophone();
              }
            },
          );
        });
  }

  Widget _getSpeakerphoneButton() {
    return ValueListenableBuilder(
        valueListenable: DeviceStore.shared.state.currentAudioRoute,
        builder: (context, value, child) {
          return ControlsButton(
            imgUrl: value == AudioRoute.speakerphone ? "call_assets/handsfree_on.png" : "call_assets/handsfree.png",
            tips: value == AudioRoute.speakerphone ? _l10n.callSpeakerIsOn : _l10n.callSpeakerIsOff,
            textColor: _getTextColor(),
            imgHeight: 60,
            onTap: () {
              if (value == AudioRoute.speakerphone) {
                CallManager.instance.setAudioRoute(AudioRoute.earpiece);
              } else {
                CallManager.instance.setAudioRoute(AudioRoute.speakerphone);
              }
            },
          );
        });
  }

  Widget _getCameraControlButton() {
    return ValueListenableBuilder(
        valueListenable: DeviceStore.shared.state.cameraStatus,
        builder: (context, value, child) {
          return ControlsButton(
            imgUrl: value == DeviceStatus.on ? "call_assets/camera_on.png" : "call_assets/camera_off.png",
            tips: value == DeviceStatus.on ? _l10n.callCameraIsOn : _l10n.callCameraIsOff,
            textColor: _getTextColor(),
            imgHeight: 60,
            onTap: () {
              if (value == DeviceStatus.on) {
                CallManager.instance.closeLocalCamera();
              } else {
                CallManager.instance.openLocalCamera(DeviceStore.shared.state.isFrontCamera.value);
              }
            },
          );
        });
  }

  Widget _getSwitchCameraSmallButton() {
    return ValueListenableBuilder(
        valueListenable: DeviceStore.shared.state.isFrontCamera,
        builder: (context, value, child) {
          return ControlsButton(
            imgUrl: "call_assets/switch_camera.png",
            tips: '',
            textColor: _getTextColor(),
            imgHeight: 28,
            imgOffsetX: -16,
            onTap: () {
              CallManager.instance.switchCamera(!DeviceStore.shared.state.isFrontCamera.value);
            },
          );
        });
  }

  Color _getTextColor() {
    return CallColors.colorG7;
  }
}
