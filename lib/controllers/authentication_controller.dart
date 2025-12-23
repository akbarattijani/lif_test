import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:lif_test/ui/dashboard_activity.dart';
import 'package:lif_test/ui/login_activity.dart';

class AuthController extends GetxController {
    static AuthController instance = Get.find();
    late Rx<User?> _user;
    FirebaseAuth auth = FirebaseAuth.instance;

    @override
    void onReady() {
        super.onReady();
        _user = Rx<User?>(auth.currentUser);
        _user.bindStream(auth.userChanges());
        ever(_user, _initialScreen);
    }

    _initialScreen(User? user) {
        if (user == null) {
            Get.offAll(() => LoginActivity());
        } else {
            Get.offAll(() => DashboardActivity());
        }
    }

    Future<void> login(String email, String password) async {
        try {
            await auth.signInWithEmailAndPassword(email: email, password: password);
        } catch (e) {
            print(e.toString());
            Get.snackbar("Login Failed", e.toString(), snackPosition: SnackPosition.BOTTOM);
        }
    }

    Future<void> logout() async => await auth.signOut();

    String get currentUserId => auth.currentUser?.uid ?? '';
}