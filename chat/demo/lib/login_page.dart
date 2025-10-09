import 'package:flutter/material.dart';
import 'package:atomic_x/atomicx.dart';
import 'package:provider/provider.dart';
import 'package:uikit_next/pages/home_page.dart';
import 'package:uikit_next/signature/GenerateUserSig.dart';

const int SDKAPPID = 0;
const String SECRETKEY = "";
const int EXPIRE_TIME = 604800; // 7 day = 7 x 24 x 60 x 60 = 604800

class LoginInfoState extends ChangeNotifier {
  bool isLoggedIn = false;
  bool isLoggingIn = false;
  String currentUserID = "";
  String? loginError;

  static final LoginInfoState _instance = LoginInfoState._internal();

  factory LoginInfoState() => _instance;

  LoginInfoState._internal() {
    isLoggedIn = LoginStore.shared.loginState.loginStatus == LoginStatus.logined;
    if (isLoggedIn && LoginStore.shared.loginState.loginUserInfo != null) {
      currentUserID = LoginStore.shared.loginState.loginUserInfo!.userID;
    }
  }

  Future<bool> login(String userID) async {
    isLoggingIn = true;
    loginError = null;
    notifyListeners();

    final userSig = GenerateDevUsersigForTest(
      sdkappid: SDKAPPID,
      key: SECRETKEY,
    ).genSig(
      userID: userID,
      expireTime: EXPIRE_TIME,
    );

    final result = await LoginStore.shared.login(
      sdkAppID: SDKAPPID,
      userID: userID,
      userSig: userSig,
    );

    if (result.errorCode == 0) {
      isLoggedIn = true;
      currentUserID = userID;
      isLoggingIn = false;
      notifyListeners();
      return true;
    } else {
      loginError = "login failed: ${result.errorCode}, ${result.errorMessage}";
      isLoggingIn = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> logout() async {
    final result = await LoginStore.shared.logout();

    if (result.errorCode == 0) {
      isLoggedIn = false;
      currentUserID = "";
      notifyListeners();
      return true;
    } else {
      debugPrint("logout failed: ${result.errorCode}, ${result.errorMessage}");
      return false;
    }
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _userIDController = TextEditingController(text: '');

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _userIDController.dispose();

    super.dispose();
  }

  void _login(BuildContext context) {
    final loginState = Provider.of<LoginInfoState>(context, listen: false);

    if (_userIDController.text.isEmpty) {
      return;
    }

    loginState.login(_userIDController.text).then((success) {
      if (success) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    AtomicLocalizations atomicLocale = AtomicLocalizations.of(context);
    final loginState = Provider.of<LoginInfoState>(context);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.chat_bubble_outline_rounded,
                    size: 80,
                    color: Theme.of(context).primaryColor,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "UIKit Next",
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 48),
                  TextField(
                    controller: _userIDController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: "User ID",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: Colors.grey.withOpacity(0.2),
                          width: 1.0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: Colors.grey.withOpacity(0.2),
                          width: 1.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: Theme.of(context).primaryColor.withOpacity(0.5),
                          width: 1.5,
                        ),
                      ),
                    ),
                  ),
                  if (loginState.loginError != null) ...[
                    const SizedBox(height: 16),
                    Text(
                      loginState.loginError!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ],
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: loginState.isLoggingIn ? null : () => _login(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: loginState.isLoggingIn
                          ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : Text(
                              atomicLocale.login,
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      "SDKAPPID: $SDKAPPID",
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
