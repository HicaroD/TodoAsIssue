import 'dart:convert';
import 'dart:io';

class Reader {
  static Future<String> getTodoFile() async {
    String todoFilePath = "${Directory.current.path}/todo.txt";
    File todoFile = File(todoFilePath);
    if (!await todoFile.exists()) {
      print("ERROR: 'todo.txt' not found");
      exit(1);
    }
    String content = await todoFile.readAsString();
    return content;
  }

  static Future<Map<String, dynamic>> getConfigFile() async {
    String path = "todo.json";
    File jsonFile = File(path);

    if (!await jsonFile.exists()) {
      print(
          "ERROR: Configuration file 'todo.json' not found on project root folder");
      exit(1);
    }
    Map<String, dynamic> jsonDecoded =
        jsonDecode(await jsonFile.readAsString());
    return jsonDecoded;
  }
}
