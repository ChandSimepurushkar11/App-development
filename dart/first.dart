import 'dart:io';

void main() {
  stdout.write("Enter a number: ");
  String? input = stdin.readLineSync();

  int? number = int.tryParse(input ?? '');
  if (number == null) {
    print("Invalid number!");
    return;
  }

  print("Counting from 1 to $number:");
  for (int i = 1; i <= number; i++) {
    print(i);
  }
}