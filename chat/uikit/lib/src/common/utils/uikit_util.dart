import 'package:atomic_x_core/atomicxcore.dart';
import 'package:tencent_cloud_chat_sdk/tencent_im_sdk_plugin.dart';
import 'package:tuikit_atomic_x/base_component/utils/tui_event_bus.dart';

class UIKitUtil {
  static RegExp urlReg = RegExp(
      r"([hH][tT]{2}[pP]:\/\/|[hH][tT]{2}[pP][sS]:\/\/|[wW]{3}.|[wW][aA][pP].|[fF][tT][pP].|[fF][iI][lL][eE].)[-A-Za-z0-9+&@#/%?=~_|!:,.;]+[-A-Za-z0-9+&@#/%=~_|]");

  /// Group member display name priority: nameCard > friendRemark > nickname > userID
  static String memberDisplayName(GroupMember member) {
    if (member.nameCard != null && member.nameCard!.isNotEmpty) return member.nameCard!;
    if (member.friendRemark != null && member.friendRemark!.isNotEmpty) return member.friendRemark!;
    if (member.nickname != null && member.nickname!.isNotEmpty) return member.nickname!;
    return member.userID;
  }

  /// Reports the "chat invoke call" interaction metric, but only when the call
  /// module is actually integrated. Integration is inferred from the runtime
  /// event-bus subscription registered by the call package (obfuscation-safe,
  /// unlike class-name / reflection checks).
  ///
  /// TODO: This is a temporary implementation. Once the new AtomicX APIs are
  /// published, replace the body with:
  ///   if (TUIEventBus.shared.hasSubscriber("call.startCall", null)) {
  ///     DataReport.reportInteractionMetrics(InteractionMetrics.chatInvokeCall);
  ///   }
  static void reportChatInvokeCall() {
    final callObservers = TUIEventBus.shared.observerMap["call.startCall"];
    if (callObservers == null || callObservers.isEmpty) {
      return;
    }

    TencentImSDKPlugin.v2TIMManager.callExperimentalAPI(
      api: 'report_tuifeature_usage',
      param: {
        'report_tuifeature_usage_uicomponent_type': 1020,
      },
    );
  }
}
