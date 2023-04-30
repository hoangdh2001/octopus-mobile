import 'package:dio/dio.dart';

extension MutipartFileX on MultipartFile {
  Map<String, dynamic> toJson() {
    final val = <String, dynamic>{};

    void writeNotNull(String key, dynamic value) {
      if (value != null) {
        val[key] = value;
      }
    }

    val['length'] = length;
    writeNotNull('filename', filename);
    writeNotNull('headers', headers);
    writeNotNull('contentType', contentType);

    return val;
  }
}
