import 'dart:convert';

class Base64Util {
  static String base64Encoder(String decode) {
    String encode = base64.encode(utf8.encode(decode));
    return encode;
  }

  static String base64Decoder(String value) {
    List<int> decode = base64.decode(value);
    String decodeResult = utf8.decode(decode);
    return decodeResult;
  }
}
