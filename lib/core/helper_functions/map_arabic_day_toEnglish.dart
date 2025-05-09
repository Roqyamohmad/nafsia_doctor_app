String mapArabicDayToEnglish(String arabicDay) {
  switch (arabicDay) {
    case 'السبت':
      return 'sat';
    case 'الأحد':
      return 'sun';
    case 'الاثنين':
      return 'mon';
    case 'الثلاثاء':
      return 'tue';
    case 'الأربعاء':
      return 'wed';
    case 'الخميس':
      return 'thu';
    case 'الجمعة':
      return 'fri';
    default:
      return 'Friday';
  }
}

String mapEnglishDayToArabic(String day) {
  switch (day.toLowerCase()) {
    case 'sat':
      return 'السبت';
    case 'sun':
      return 'الأحد';
    case 'mon':
      return 'الاثنين';
    case 'tue':
      return 'الثلاثاء';
    case 'wed':
      return 'الأربعاء';
    case 'thu':
      return 'الخميس';
    case 'fri':
      return 'الجمعة';
    default:
      return 'الأحد'; // قيمة افتراضية
  }
}
