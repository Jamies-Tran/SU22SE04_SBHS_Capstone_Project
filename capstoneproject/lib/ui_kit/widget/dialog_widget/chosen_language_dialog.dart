import 'package:flutter/material.dart';

class ChosenLanguageDialog extends StatelessWidget {
  const ChosenLanguageDialog();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: _dialogContent(context),
    );
  }

  Widget _dialogContent(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(5),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // To make the card compact
        children: <Widget>[
          const Text(
            'chosenLanguage',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          Column(
            children: [
              GestureDetector(
                onTap: () {
                  // Change Language
                  // EasyLocalization.of(context)!.setLocale(EasyLocalization.of(context)!.supportedLocales[0]); // 0: Vietnamese

                  // // Save Language
                  // SPref.instance.set(SPrefCache.LANGUAGE_APP, VIETNAMESE_LANGUAGE);

                  Navigator.of(context).pop(); // To close the dialog
                },
                child: Card(
                  color: Colors.white,
                  elevation: 2,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    width: MediaQuery.of(context).size.width,
                    height: 35,
                    child: Row(
                      children: [
                        const Spacer(),
                        Text(
                          'VietNamese',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        const Spacer(),
                        Icon(
                          Icons.navigate_next,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () {
                  // Change Language
                  // EasyLocalization.of(context)!.setLocale(EasyLocalization.of(context)!.supportedLocales[1]); // 1: English

                  // // Save Language
                  // SPref.instance.set(SPrefCache.LANGUAGE_APP, ENGLISH_LANGUAGE);

                  Navigator.of(context).pop(); // To close the dialog
                },
                child: Card(
                  color: Colors.white,
                  elevation: 2,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    width: MediaQuery.of(context).size.width,
                    height: 35,
                    child: Row(
                      children: const [
                        Spacer(),
                        Text(
                          'English',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        Spacer(),
                        Icon(Icons.navigate_next, color: Colors.white),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
