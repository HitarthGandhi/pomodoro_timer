import 'package:gsheets/gsheets.dart';

// Enter your google service acount credentials here
const _credentials = r'''
  {
  }
  ''';

// Enter the ID of your google sheets
const _sheetID = "";

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
