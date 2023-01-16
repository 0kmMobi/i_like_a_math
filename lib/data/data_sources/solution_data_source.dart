import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:i_like_a_math/core/error/exception.dart';
import 'package:i_like_a_math/data/models/solution_model.dart';
import 'package:flutter/services.dart' show rootBundle;

abstract class SolutionDataSource {
  Future<SolutionModel> getSolution(int digit, int number);
}

class SolutionDataSourceImpl extends SolutionDataSource {
  static const String _dataFileName = 'assets/data/100-1000.dat';
  final _allData = <int, Map<int, String>>{};
  BuildContext? context;

  SolutionDataSourceImpl();

  void setContext({required context}) {
    this.context = context;
    return;
  }

  @override
  Future<SolutionModel> getSolution(int digit, int number) async {
    if(_allData.isEmpty) {
      _allData.addAll(await _loadData());
    }

    if(!_allData.containsKey(digit)) {
      throw DataSourceException("solutionNotAvailableInDemo".tr());
    }

    final mapDigit = _allData[digit]!;
    if(!mapDigit.containsKey(number)) {
      throw DataSourceException("solutionNotAvailableInDemo".tr());
    }

    String solution = mapDigit[number]!;
    final List<ExpressionElemModel> solutionElems = _parseExpressions(solution);

    final model = SolutionModel(digit: digit, number: number, solutionElems: solutionElems);
    return model;
  }

  /// Convert math expressions from text to members list
  List<ExpressionElemModel> _parseExpressions(String solution) {
    final txt = solution.replaceAll("*", "\u00D7");

    var levels = '';
    var currentLevel = 1;

    for(int i = 0; i < txt.length; i ++) {
      var char = txt[i];
      if(char == '[') {
        levels += '0';
        currentLevel ++;
      } else if(char == ']') {
        levels += '0';
        currentLevel --;
      } else {
        levels += '$currentLevel';
      }
    }

    final lTxt = txt.split(RegExp(r'[\[\]]'));
    final lLevels = levels.split('0');
    final List<ExpressionElemModel> elems = [];

    for(int i = 0; i < lTxt.length; i ++) {
      final String elemTxt = lTxt[i];
      if(elemTxt.isEmpty) {
        continue;
      }
      final int elemLevel = int.parse(lLevels[i][0]);
      elems.add(ExpressionElemModel(elemLevel, elemTxt));
    }
    return elems;
  }

  Future<Map<int, Map<int, String>>> _loadData() async {
    final mapData = <int, Map<int, String>>{};

    final rawData = await loadAsset();
    debugPrint("file size: ${rawData.length}");

    // Prepare a Map for all digits
    for (int digit = 1; digit < 10; digit ++) {
      final mapDigit = <int, String>{};
      mapData[digit] = mapDigit;
    }
    final allLines = rawData.split('\n');
    debugPrint("Number of lines: ${allLines.length}");

    for (final oneLine in allLines) {
      final rows = oneLine.trim().split('\t');
      final digit = int.parse(rows[0]);
      final number = int.parse(rows[1]);
      final expression = rows[2];
      mapData[digit]![number] = expression;
    }
    return mapData;
  }

  Future<String> loadAsset() async {
    if(context == null) {
      return await rootBundle.loadString(_dataFileName);
    } else {
      return await DefaultAssetBundle.of(context!).loadString(_dataFileName);
    }
  }
}