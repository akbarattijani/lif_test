import 'package:firebase_core/firebase_core.dart';

class FirebaseConstants {

    static const FirebaseOptions android = FirebaseOptions(
        apiKey: "AIzaSyDHuy8z1jlU7rJtUNxaoyOhH-o93XGTelU",
        appId: "1:70945761144:android:3f1b0439c64c9a8b938a8d",
        messagingSenderId: "70945761144",
        projectId: "lif-test-283d7",
        storageBucket: "nama-project-id-anda.appspot.com",
    );

    static const FirebaseOptions ios = FirebaseOptions(
        apiKey: "AIzaSyARmygAs712U4GQGHWhJURat00ULLrqy50",
        appId: "1:70945761144:ios:4c57bfd5c0392bc6938a8d",
        messagingSenderId: "70945761144",
        projectId: "lif-test-283d7",
        storageBucket: "nama-project-id-anda.appspot.com",
        iosBundleId: "com.lif.lifTest",
    );
}