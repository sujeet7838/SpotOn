import 'package:contacts_service/contacts_service.dart';
import 'package:get/get.dart';

class WorkerController extends GetxController {
  Rx<Contact?> selectedContact = Rx<Contact?>(null);

  void updateContact(Contact? contact) {
    selectedContact.value = contact;
  }
}