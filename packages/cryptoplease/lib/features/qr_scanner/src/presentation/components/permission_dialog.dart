

// void showPermissionDialog(
//   BuildContext context,
//   VoidCallback onManualInput,
// ) =>
//     showDialog<void>(
//       context: context,
//       builder: (context) => Theme(
//         data: ThemeData.light(),
//         child: AlertDialog(
//           title: Text(context.l10n.qrPermissionDialogTitle),
//           content: Text(context.l10n.qrPermissionDialogMessage),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//                 onManualInput();
//               },
//               child: Text(context.l10n.qrInputAddressTitle),
//             ),
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: Text(context.l10n.ok),
//             ),
//           ],
//         ),
//       ),
//     );
