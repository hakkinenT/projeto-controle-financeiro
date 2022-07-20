class AppCalc {
  static double sum({required double addend1, required double addend2}) {
    return addend1 + addend2;
  }

  static double sub({required double minuend, required double subtrahend}) {
    return minuend - subtrahend;
  }

  //multiplier - multiplicando. Número que será multiplicado
  //multiplicand - multiplicador. Quantidade de vezes que o número será somado
  static double multi(
      {required double multiplier, required double multiplicand}) {
    return multiplier * multiplicand;
  }

  static double div({required double dividend, required double divisor}) {
    if (divisor != 0) {
      return dividend / divisor;
    } else {
      throw Exception('Não é possivel dividir um número por 0');
    }
  }

  static double percentOfANumber(
      {required double portion, required double total}) {
    double percent = 0.0;

    if (total != 0) {
      double dividend = multi(multiplier: portion, multiplicand: 100);
      percent = div(dividend: dividend, divisor: total);
    }
    return percent;
  }
}
