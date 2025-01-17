import 'package:flutter_test/flutter_test.dart';
import 'package:linkyou_task/core/utils/input_converter.dart';


void main() {
  late InputConverter inputConverter;

  setUp(() {
    inputConverter = InputConverter();
  });

  test('should return an integer when the string is a valid unsigned integer', () {
    // Arrange
    const str = '123';

    // Act
    final result = inputConverter.stringToUnsignedInteger(str);

    // Assert
    expect(result, 123);
  });

  test('should throw a FormatException when the string is not a valid integer', () {
    // Arrange
    const str = 'abc';

    // Act & Assert
    expect(() => inputConverter.stringToUnsignedInteger(str), throwsA(isA<FormatException>()));
  });

  test('should throw a FormatException when the string is a negative integer', () {
    // Arrange
    const str = '-123';

    // Act & Assert
    expect(() => inputConverter.stringToUnsignedInteger(str), throwsA(isA<FormatException>()));
  });
}