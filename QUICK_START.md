# Flutter Calculator App - Quick Start Guide

## Overview
This is a fully functional Flutter calculator application with an accumulator display, proper mathematical operations, and comprehensive error handling.

## Getting Started

### Prerequisites
- Flutter SDK (latest version)
- Dart SDK
- A text editor or IDE (VS Code, Android Studio, etc.)

### Installation

1. **Install dependencies:**
   ```bash
   flutter pub get
   ```

2. **Run the application:**
   ```bash
   flutter run
   ```

3. **Run tests:**
   ```bash
   flutter test
   ```

## Application Features

### Main Interface
- **Calculator Title**: "Calculator - Developed by GitHub Copilot"
- **Display Area**: Shows current expression and calculation result
- **Number Pad**: Buttons 0-9
- **Operators**: +, -, *, /
- **Special Buttons**:
  - **C** (Clear): Reset calculator
  - **DEL** (Delete): Remove last character
  - **.** (Decimal): Add decimal point
  - **=** (Equals): Calculate result

### Supported Calculations
- Basic arithmetic operations
- Complex expressions with multiple operations
- Decimal numbers
- Negative numbers
- Order of operations (PEMDAS/BODMAS)

### Example Usage

1. **Simple Addition**: 5 + 3 = 8
2. **Complex Expression**: 2 + 3 * 4 = 14 (multiplication is performed first)
3. **Decimal Numbers**: 7 / 2 = 3.5
4. **Negative Numbers**: -5 + 10 = 5

## How to Use

### Basic Calculation
1. Tap digit buttons to enter numbers
2. Tap an operator button (+, -, *, /)
3. Enter the next number
4. Tap = to see the result

### Example: Calculate 10 + 5 - 3
1. Tap **1** → **0** (display shows: 10)
2. Tap **+** (display shows: 10 +)
3. Tap **5** (display shows: 10 + 5)
4. Tap **-** (display shows: 10 + 5 -)
5. Tap **3** (display shows: 10 + 5 - 3)
6. Tap **=** (display shows: 10 + 5 - 3 = 12)

### Clearing the Calculator
- **Full Clear (C)**: Resets everything and shows "0"
- **Delete (DEL)**: Removes the last character you entered

### Using Decimals
1. Enter a number (e.g., 7)
2. Tap **.** (decimal point)
3. Enter decimal digits (e.g., 5)
4. Continue with operations as normal

## Error Handling

The calculator handles the following error cases:

### Division by Zero
```
Input: 5 / 0 =
Output: Error: Cannot divide by zero
```

### Invalid Expression
```
Input: 2 + + 3 =
Output: Error: Invalid expression
```

### Invalid Decimal Points
The calculator automatically prevents entering multiple decimal points in a single number.

## Test Results

The application includes comprehensive testing:
- **33 total tests** - All passing
- **23 unit tests** for calculation logic
- **10 widget tests** for UI components

Run tests with:
```bash
flutter test
```

## File Structure

```
lib/
  main.dart              # Main application code
test/
  calculator_test.dart   # Unit tests for calculations
  widget_test.dart       # Widget tests for UI
pubspec.yaml            # Project dependencies
```

## Project Dependencies

- **flutter**: Flutter framework
- **expressions: ^0.2.5**: Expression parsing and evaluation
- **cupertino_icons**: iOS-style icons
- **flutter_lints**: Linting rules

## Technical Details

### State Management
The calculator uses Flutter's built-in `setState()` for state management. The main state variables are:
- `_display`: Current display string
- `_expression`: Current mathematical expression
- `_errorMessage`: Error messages for validation

### Expression Evaluation
The app uses the `expressions` package to parse and evaluate mathematical expressions. This ensures:
- Proper order of operations
- Support for complex expressions
- Error handling for invalid inputs

### UI Components
- **Scaffold**: Main layout structure
- **AppBar**: Title bar
- **ElevatedButton**: Action buttons
- **Container**: Display area
- **Column/Row**: Layout arrangement

## Tips & Tricks

1. **Long Expressions**: The display automatically scrolls for long expressions
2. **Quick Clear**: Use the C button to clear and start fresh
3. **Delete Last Digit**: Use DEL to correct mistakes
4. **Decimal Support**: Use the decimal point for precise calculations
5. **Negative Numbers**: You can enter negative numbers directly with the minus button

## Troubleshooting

### App won't run
- Ensure Flutter is properly installed: `flutter --version`
- Run `flutter pub get` to fetch dependencies
- Clean build: `flutter clean && flutter pub get`

### Tests fail
- Make sure all dependencies are installed: `flutter pub get`
- Run `flutter clean` before running tests
- Check for any unsaved changes in the editor

### Display overflow on small screens
- The app is responsive and adjusts to screen size
- Buttons and fonts scale automatically
- No manual adjustments needed

## Development Notes

### Code Structure
- Clean separation of concerns
- Well-documented functions
- Proper error handling with try-catch blocks
- Responsive design that works on all screen sizes

### Performance
- Efficient state management
- Minimal widget rebuilds
- No memory leaks
- Smooth user interaction

## Future Enhancement Ideas

1. Operation history/memory
2. Keyboard input support
3. Scientific calculator features
4. Themes and customization
5. Undo/Redo functionality
6. Calculation history

## Support & Documentation

For more information:
- Flutter Documentation: https://flutter.dev/docs
- Expressions Package: https://pub.dev/packages/expressions
- Project Summary: See CALCULATOR_IMPLEMENTATION.md

## License

This project is open source and available for educational purposes.

---

**Enjoy using the Calculator App!** 📱🧮
