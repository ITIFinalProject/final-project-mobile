import 'package:eventify_app/core/routes.dart';
import 'package:eventify_app/core/theme.dart';
import 'package:eventify_app/features/add_event/widgets/custom_text.dart';
import 'package:eventify_app/features/add_event/widgets/custom_text_form_field.dart';
import 'package:eventify_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class AddGuests extends StatefulWidget {
  const AddGuests({super.key});

  @override
  State<AddGuests> createState() => _AddGuestsState();
}

class _AddGuestsState extends State<AddGuests> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getContacts();
  }

  List<Contact> selectedContacts = [];
  List<Contact> filteredContacts = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).addguests),
        actions: [
          IconButton(
            onPressed: () {
              // Navigator.pushNamed(context, );
            },
            icon: Icon(Icons.person_add_alt, color: ThemeManager.primaryColor),
          ),
        ],
      ),
      body: Column(
        children: [
          CustomTextFormField(
            validator: (val) {
              return null;
            },
            hint: S.of(context).search_contacts,
            controller: searchController,
            prefixIcon: Icons.search,
            onChange: filterContacts,
          ),
          Expanded(
            child:
                contacts == null
                    ? Center(
                      child: CircularProgressIndicator(
                        color: ThemeManager.secondaryColor,
                      ),
                    )
                    : ListView.separated(
                      itemCount: filteredContacts.length,
                      itemBuilder: (context, index) {
                        final contact = filteredContacts[index];
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: ThemeManager.lightPinkColor,
                            child: Text(
                              getInitials(contact.displayName),
                              style: TextStyle(
                                color: ThemeManager.primaryColor,
                              ),
                            ),
                          ),
                          title: Text(contact.displayName),
                          subtitle:
                              contact.phones.isNotEmpty
                                  ? Text(contact.phones.first.number)
                                  : Text(S.of(context).no_number),
                          trailing: Checkbox(
                            value: selectedContacts.any(
                              (c) => c.id == contact.id,
                            ),
                            onChanged: (isChecked) {
                              setState(() {
                                if (isChecked == true) {
                                  selectedContacts.add(contact);
                                } else {
                                  selectedContacts.removeWhere(
                                    (c) => c.id == contact.id,
                                  );
                                }
                              });
                            },
                            activeColor: ThemeManager.primaryColor,
                          ),
                        );
                      },
                      separatorBuilder:
                          (context, index) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Divider(color: ThemeManager.darkPinkColor),
                          ),
                    ),
          ),
          if (selectedContacts.isNotEmpty && !isShowingSelected)
            showSelectedContainer(),

          if (isShowingSelected)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(color: ThemeManager.lightPinkColor),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${selectedContacts.length} Selected',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 18,
                      color: ThemeManager.primaryColor,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        isShowingSelected = false;
                        filteredContacts = contacts!;
                      });
                    },
                    child: Text(
                      S.of(context).done,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: ThemeManager.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  List<Contact>? contacts;

  getContacts() async {
    if (await FlutterContacts.requestPermission()) {
      final fetchedContacts = await FlutterContacts.getContacts(
        withProperties: true,
      );
      setState(() {
        contacts = fetchedContacts;
        filteredContacts = fetchedContacts;
      });
    }
  }

  void filterContacts(String val) {
    final query = searchController.text.toLowerCase();
    if (query.isEmpty) {
      setState(() {
        filteredContacts = contacts ?? [];
      });
    } else {
      setState(() {
        filteredContacts =
            contacts!
                .where((c) => c.displayName.toLowerCase().contains(query))
                .toList();
      });
    }
  }

  String getInitials(String name) {
    final parts = name.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}';
    } else if (parts.isNotEmpty && parts[0].isNotEmpty) {
      return parts[0][0];
    } else {
      return '?';
    }
  }

  bool isShowingSelected = false;

  showSelectedContainer() {
    return Container(
      decoration: BoxDecoration(
        color: ThemeManager.lightPinkColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.15,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: selectedContacts.length,
              itemBuilder: (context, index) {
                if (selectedContacts.length > 5 && index == 0) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        filteredContacts = selectedContacts;
                        isShowingSelected = true;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundColor: ThemeManager.darkPinkColor,
                            child: Text(
                              '${selectedContacts.length} ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: ThemeManager.primaryColor,
                              ),
                            ),
                          ),
                          Text(S.of(context).see_all),
                        ],
                      ),
                    ),
                  );
                }
                final actualIndex =
                    selectedContacts.length > 5 ? index - 1 : index;
                final contact = selectedContacts[actualIndex];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundColor: ThemeManager.darkPinkColor,
                        child: Text(
                          getInitials(contact.displayName),
                          style: TextStyle(color: ThemeManager.primaryColor),
                        ),
                      ),
                      Text(
                        contact.displayName.length > 4
                            ? contact.displayName.substring(0, 4)
                            : contact.displayName,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          CustomElevatedButton(title:S.of(context).next_review_send, onPressed: () {}),
        ],
      ),
    );
  }
}
//