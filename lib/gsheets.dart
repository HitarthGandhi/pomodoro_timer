import 'package:gsheets/gsheets.dart';

const _credentials = r'''
  {
    "type": "service_account",
    "project_id": "issuing-items-304422",
    "private_key_id": "8f200bf7f2d7ecc8ae4090a71e91f91b71419228",
    "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDKtD/vOESRZW5F\no+rbPVeJuIzqlFXDJ9SPXZWYXkaOILYmqJUWjXq7G0cI6R3wD4IE9Hu/og4dXg10\ngKwr+qVR4CEf41sjCQhz1T6fcTRbZFJ/Qg/YXAzTDLiqZtqyXvc7BquGoZ883fwP\nVJfEkzA/SfCEfpccE95RKAi2JmiHREAoYC5Ab0XRNZlfSyFvu1YsKk0h1wwfKclq\nnPWc5onhu7sqLQe8L2qoBElFUy+lSdPbHlw+wXSQARAiqi+RLa93y+aiQlLclBEw\ncUOKM7Bm14N25OIgXlaU5Yzm/KP2eF2/mvIy+0o0XzjBKGsFJAwmnnNQS0Wv712Q\njmMFUt7pAgMBAAECggEACiDAcwjqMCOTw2oBwYuKlKiCbfQUZuhWEAW6hD7tootS\n3pKcxGA0SiX+Qh03sDduJSY8CqKjtubsoC4PrDDdUr5ymT/IXXNFl1gHxXqoBYr5\nLj+UQBi1UVQ449a4xaHGE45tQpBPvwBOaEuvO5SpG/hrSotyrGX3vTFVYhiAL4Xs\nMuarzbu+QCZ6XrsOIBgkfmd6lW9Sqfl0JhQ9HOlZruW1ewDVSUEYS7CvPnAKbA5Z\njxX7BS1fW5zw7rHxnaOI3SaUqJCuRMSwe/dnQlAhuBIRkFj3ooZwRiGIMjT5+6Zp\nEgTIPY/97fkFTrXVtqYVj5m8UnA0maCdXGbK4zgzSQKBgQDqPTwoW9NNLFlczB/W\n0W4TRGqKO87eWKqZKe9vqxVPVEth0chi0CYkDZ22mmBYnX+S6qQh7FtisGLwx4jR\nf+KEuv7XlhZpOLUtbCvNIeBBF1hWhlR4PIgimMQxN3E01VM/924xAImuwFfBi5IM\nNpB0aZNHTFzERJCeiCAx+mjyJQKBgQDdiQj+8UVPZJQdNVvuPLZeB7AMUPNCCjD/\nvU4q+HcoeTzginFda3CMKTKgpwRw/4VUQTvzAm3YkZwgFomEkI8G4Kab9JLjd8fO\nkViPVHoNm+Umkxj+yL3doTjnX92qGzYucJX26zQokhfcjS1Dcf0AfCuVY2Mbmmrn\nc15WaWMkdQKBgA+P1elQgG9GHQG/RfY9n7SD/RgF9S5scZkPYirnENleXku3Zjq6\nXW5TwUCabQA2Jn2aPSFL1J5v3YLlnr9cYa4zxi6IeCCxdcf4wcg1EfMBHAtTjVUX\noGu7/nzOlCTQb2F2jMmQoZUMjkf7f85z6ZDyWqiH+DnJ3FnL7WeknUhJAoGBAMZb\nRKrA7QZBUD024bFWuxNGXuMoOCcRaP4TSkI/ZrHenBuQ2iCDaqqU2Lfv05I5t+/Q\n2RSlQCWBewFgLJF9vhKyY3uQaVUykrzqdxke0ooM5Ai9/MtkglxHVuQUei0tYD4E\noMINpw4MgUEBR130Wkxs4blI3ByDDuVd70H/6r1hAoGAL4tDgucCKz+m5dcQxOzy\nGsKhNELnytmQvTuVSCvHSxWfc2DWBMezEn7EBvF5lN0w/TTCRjsrJqog8mdPu7ac\nRtNkDLCy002mWS9mwa78EgPE5XhdjAj+uovXGJKjSsrUczx/52JlGbFApwPupLIc\nLMAe1GPANasYG4ZAd515jQ4=\n-----END PRIVATE KEY-----\n",
    "client_email": "hitarth-gandhi@issuing-items-304422.iam.gserviceaccount.com",
    "client_id": "111280514848776643962",
    "auth_uri": "https://accounts.google.com/o/oauth2/auth",
    "token_uri": "https://oauth2.googleapis.com/token",
    "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
    "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/hitarth-gandhi%40issuing-items-304422.iam.gserviceaccount.com"
  }
  ''';

const _sheetID = "1U9jsam2tMqzlx6H445po6YkgO99uAxB760OeRtB41XQ";

Future<List<Map<String, String>>> getNames() async {
  final gsheets = GSheets(_credentials);
  // fetch spreadsheet by its id
  final ss = await gsheets.spreadsheet(_sheetID);
  // get worksheet by its title
  var sheet = ss.worksheetByTitle('Sheet1');
  // create worksheet if it does not exist yet
  sheet ??= await ss.addWorksheet('Sheet1');
  final data = await sheet.values.map.allRows();
  print(data);
  return data;
}

Future insertNew(String name) async {
  final gsheets = GSheets(_credentials);
  // fetch spreadsheet by its id
  final ss = await gsheets.spreadsheet(_sheetID);
  // get worksheet by its title
  var sheet = ss.worksheetByTitle('Sheet1');
  // create worksheet if it does not exist yet
  sheet ??= await ss.addWorksheet('Sheet1');
  final data = {"Name": name};
  await sheet.values.map.appendRow(data);
}
