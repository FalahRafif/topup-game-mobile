import 'package:topup_mobile/constants.dart';
import 'package:topup_mobile/main.dart';
import 'package:flutter/material.dart';

void showLoading(
  BuildContext context,
  String judul,
  String deskripsi,
  String img,
  String statusCode,
) {
  Dialogloading(context, judul, deskripsi, img, statusCode);
}

void hideLoading(BuildContext context) {
  Navigator.of(context, rootNavigator: true).pop();
}

Dialogloading(
  BuildContext context,
  String judul,
  String desc,
  String img,
  String statusCode,
) {
  Dialog dialog = Dialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    elevation: 0,
    backgroundColor: Colors.transparent,
    child: loadingContent(context, judul, desc, img, statusCode),
  );

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return dialog;
    },
  );
}

loadingContent(
  BuildContext context,
  String judul,
  String desc,
  String img,
  String statusCode,
) {
  return Stack(
    children: [
      Container(
        padding: EdgeInsets.only(top: 100, bottom: 16, left: 16, right: 16),
        margin: EdgeInsets.only(top: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(17),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10.0,
              offset: Offset(0.0, 10.0),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              judul,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 14.0),
            Text(
              desc,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 24.0),
            statusCode == "200"
                ? Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kPrimaryColor,
                      ),
                      onPressed: () {
                        Navigator.of(context, rootNavigator: true).pop();
                      },
                      child: Text("Ok"),
                    ),
                  )
                : statusCode == "300"
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.bottomRight,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(21.0),
                              side: BorderSide(color: kPrimaryColor),
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context, rootNavigator: true).pop();
                          },
                          child: Text(
                            "Batal",
                            style: TextStyle(color: kPrimaryColor),
                          ),
                        ),
                      ),
                      SizedBox(width: 10), //
                      Align(
                        alignment: Alignment.bottomRight,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                          onPressed: () {
                            Navigator.of(context, rootNavigator: true).pop();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return MyApp();
                                },
                              ),
                            );
                          },
                          child: Text(
                            "Keluar",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  )
                : Align(alignment: Alignment.bottomRight, child: Text("")),
          ],
        ),
      ),
      Positioned(
        top: 0,
        left: 16,
        right: 16,
        child: CircleAvatar(
          backgroundColor: Colors.white,
          radius: 50,
          child: Image.asset(
            img,
            width: 50,
            height: 50,
            color: statusCode == "100" ? kPrimaryColor : null,
          ),
        ),
      ),
    ],
  );
}
