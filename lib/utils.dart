import 'package:image_picker/image_picker.dart';

pickImage (ImageSource source) async{
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile = await _picker.pickImage(
      source: source,
    );
    if (pickedFile != null) {
      return await pickedFile.readAsBytes();
    }
    print('no image selected');
  }