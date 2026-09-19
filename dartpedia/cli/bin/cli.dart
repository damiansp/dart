import 'dart:io';
import 'package:http/http.dart' as http;


const version = '0.0.1';


void main(List<String> args) {
  if (args.isEmpty || args.first == 'help') {
    printUsage();
  } else if (args.first == 'version') {
    print('Dartpedia CLI v$version');
  } else if (args.first == 'wikipedia') {
    final inputArgs = args.length > 1 ? args.sublist(1) : null;
    searchWikipedia(inputArgs);
  } else { printUsage(); } // catch-all for unrecognised arg
}


void printUsage() {
  print(
    'The following commands are valid: "help", "version", '
    '"search <ARTICLE-TITLE>"');
}


void searchWikipedia(List<String>? args) async {
  final String articleTitle;
  if (args == null || args.isEmpty) {
    print('Please provide an article title.');
    final inputFromStdin = stdin.readLineSync();
    if (inputFromStdin == null || inputFromStdin.isEmpty) {
      print('No article provided. Exiting');
      return;
    }
    articleTitle = inputFromStdin;
  } else { articleTitle = args.join(' '); }
  var articleContent = await getWikipediaArticle(articleTitle);
  print(articleContent);
}


Future<String> getWikipediaArticle(String articleTitle) async {
  final url = Uri.https(
    'en.wikipedia.org',
    '/api/rest_v1/page/summary/$articleTitle',);
  final response = await http.get(url);
  if (response.statusCode == 200) { return response.body; }
  return (
    'Error: Failed to fetch article "$articleTitle". '
    'Status code: ${response.statusCode}');
}
