// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:paramedicsuz_mobile/features/drawer/screens/settings/bloc/theme_bloc.dart';

// class NetworkHelper {
//   static void observeNetwork() {
//     Connectivity().onConnectivityChanged.listen(
//       (List<ConnectivityResult> result) {
//         if (result.contains(ConnectivityResult.none)) {
//           ThemeBloc().add(const ThemeEvent.networkNotify(isConnected: false));
//         } else {
//           ThemeBloc().add(const ThemeEvent.networkNotify(isConnected: true));
//         }
//       },
//     );
//   }
// }
