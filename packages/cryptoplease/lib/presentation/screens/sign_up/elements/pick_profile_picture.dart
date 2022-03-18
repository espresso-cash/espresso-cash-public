import 'dart:io';

import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/presentation/screens/sign_up/elements/pick_image_container.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PickProfilePicture extends StatefulWidget {
  const PickProfilePicture({
    Key? key,
    required this.onChanged,
    required this.label,
    this.onLabelClicked,
    this.labelStyle,
    this.photo,
  }) : super(key: key);

  final TextStyle? labelStyle;
  final ValueSetter<File?> onChanged;
  final VoidCallback? onLabelClicked;
  final File? photo;
  final String label;

  @override
  State<PickProfilePicture> createState() => _PickProfilePictureState();
}

class _PickProfilePictureState extends State<PickProfilePicture> {
  final ImagePicker _picker = ImagePicker();

  Future<void> _onImageButtonPressed(
    BuildContext context,
    ImageSource source,
  ) async {
    Navigator.of(context).pop();
    try {
      final pickedFile = await _picker.pickImage(
        source: source,
        preferredCameraDevice: CameraDevice.front,
      );
      if (pickedFile != null && mounted) {
        widget.onChanged(File(pickedFile.path));
      }
    } on Exception {
      // Ignore
    }
  }

  Widget _getListItem(
    BuildContext context,
    String title,
    Icon icon,
    VoidCallback onClicked,
  ) =>
      ListTile(
        leading: icon,
        title: Text(
          title,
          textAlign: TextAlign.left,
          style: Theme.of(context)
              .textTheme
              .bodyText1
              ?.copyWith(color: Colors.black),
        ),
        onTap: onClicked,
      );

  void _showPicker(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext bc) => Container(
        color: Colors.white,
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _getListItem(
                context,
                context.l10n.photoLibrary,
                const Icon(Icons.photo_library),
                () => _onImageButtonPressed(context, ImageSource.gallery),
              ),
              _getListItem(
                context,
                context.l10n.camera,
                const Icon(Icons.photo_camera),
                () => _onImageButtonPressed(context, ImageSource.camera),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => PickImageContainer(
        image: widget.photo,
        pickImageClicked: () => _showPicker(context),
        labelStyle: widget.labelStyle,
        label: widget.label,
        onLabelClicked: widget.onLabelClicked,
      );
}
