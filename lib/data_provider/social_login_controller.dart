import 'package:google_sign_in/google_sign_in.dart';
import '../utils/logger.dart';

class SocialLoginController {
  void Function(bool success, String id, String? name, String email, String prifileImage) callback;

  SocialLoginController.facebook(this.callback) {
    this.callback = callback;
    _loginWithFacebook();
  }

  SocialLoginController.google(this.callback) {
    this.callback = callback;
    _loginWithGoogle();
  }

  SocialLoginController.apple(this.callback) {
    this.callback = callback;
    _loginWithApple();
  }

  void _loginWithGoogle() async {
    GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
    try {
      GoogleSignInAccount? account = await _googleSignIn.signIn();

      if (account != null) {
        Logger.m(tag: 'GOOGLE AC', value: account.toString());
        String img = await uploadProfileImage(account.photoUrl);
        callback.call(true, account.id, account.displayName, account.email, img);
      } else {
        Logger.m(tag: 'GOOGLE AC', value: 'Account is null');
        callback.call(false, '', '', '', '');
      }

      _googleSignIn.signOut();
    } catch (error) {
      callback.call(false, '', '', '', '');

      Logger.e(tag: 'GOOGLE SIGN IN ERROR', value: error);

      // if (Const.isDeveloper) {
      //   MyAlertDialog()
      //       .setTitle('Google Login Error')
      //       .setMessage(error.toString())
      //       .setTextSelectable()
      //       .setPositiveButton('OK', null)
      //       .show();
      // }
    }
  }

  void _loginWithFacebook() async {
    // try {
    //   final FacebookLogin _facebook = FacebookLogin(debug: Helper.isDeveloper);
    //   var res = await _facebook.logIn(permissions: [FacebookPermission.publicProfile, FacebookPermission.email]);
    //   print(res);
    //
    //   final token = await res.accessToken;
    //   FacebookUserProfile profile;
    //   String email = '';
    //   String imageUrl = '';
    //
    //   if (token != null) {
    //     profile = await _facebook.getUserProfile();
    //     if (token.permissions.contains(FacebookPermission.email.name)) {
    //       email = await _facebook.getUserEmail();
    //     }
    //     imageUrl = await _facebook.getProfileImageUrl(width: 100);
    //     String img = await uploadProfileImage(imageUrl);
    //     callback.call(true, profile.userId, profile.name, email, img);
    //   } else {
    //     Logger.e(baseName: runtimeType, tag: 'FACEBOOK LOGIN', value: 'Null Token!!!', sendToServer: true);
    //     callback.call(false, '', '', '', '');
    //   }
    //   await _facebook.logOut();
    // } catch (e) {
    //   callback.call(false, '', '', '', '');
    //   Logger.ex(baseName: runtimeType, tag: 'FACEBOOK LOGIN', value: e, sendToServer: true);
    //   if (Helper.isDeveloper) {
    //     MyAlertDialog()
    //         .setTitle('Facebook Login Error')
    //         .setMessage(e.toString())
    //         .setTextSelectable()
    //         .setPositiveButton('OK', null)
    //         .show();
    //   }
    // }
  }

  void _loginWithApple() async {
    // SignInWithApple.getAppleIDCredential(
    //   scopes: [
    //     AppleIDAuthorizationScopes.email,
    //     AppleIDAuthorizationScopes.fullName,
    //   ],
    // ).then((AuthorizationCredentialAppleID credential) {
    //   Logger.e(tag: 'LOGIN WITH APPLE', value: credential.toString());
    //   callback.call(true, credential.userIdentifier.nullSafe, credential.givenName.nullSafe,
    //       credential.email.nullSafe, '');
    //   Logger.m(
    //       tag: 'LOGIN WITH APPLE',
    //       value: {
    //         'userIdentifier': credential.userIdentifier,
    //         'authorizationCode': credential.authorizationCode,
    //         'givenName': credential.givenName,
    //         'familyName': credential.familyName,
    //         'state': credential.state,
    //         'email': credential.email,
    //         'identityToken': credential.identityToken,
    //       },
    //       sendToServer: true);
    // }).catchError((e) {
    //   Logger.e(tag: 'LOGIN WITH APPLE ERROR', value: e, sendToServer: true);
    //   callback.call(false, '', '', '', '');
    // });

    // Now send the credential (especially `credential.authorizationCode`) to your server to create a session
    // after they have been validated with Apple (see `Integration` section for more information on how to do this)
  }
  //
  Future<String> uploadProfileImage(String? url) async {
    // Future<List<int>?> imageBytes = await Repository.instance!.getImage(url.nullSafe);
    // Result upload = await Repository.instance
    //     .uploadImageFromBytes(await imageBytes as List<int>, FileUploadType.PROFILE_IMG);
    // return upload.value.nullSafe;
    return "";
  }
}
