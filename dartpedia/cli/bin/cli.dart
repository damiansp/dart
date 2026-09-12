import 'dart:io';


const version = '0.0.1';


void main(List<String> args) {
  if (args.isEmpty || args.first == 'help') {
    printUsage();
  } else if (args.first == 'version') {
    print('Dartpedia CLI v$version');
  } else if (args.first == 'search') {
    final inputArgs = args.length > 1 ? args.sublist(1) : null;
    searchWikipedia(inputArgs);
  } else { printUsage(); } // catch-all for unrecognised arg
}


void printUsage() {
  print(
    'The following commands are valid: "help", "version", '
    '"search <ARTICLE-TITLE>"');
}


void searchWikipedia(List<String>? args) {
  final String articleTitle;
  // if user didn't supply args, request an article title
  if (args == null || args.isEmpty) {
    print('Please provide an article title.');
    articleTitle = stdin.readLineSync() ?? '';
  } else { articleTitle = args.join(' '); }
  print('Searching Wikipedia for $articleTitle...');
  print('Here you go:');
  print('All about $articleTitle...');
}
