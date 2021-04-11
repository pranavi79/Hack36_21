var appID = 'c367924b1fe74fdb9c3209dc74aac814';

String getToken(String channelName) {
  var token = "";
  int channel = int.tryParse(channelName[channelName.length - 1]) + 1;
  switch (channel) {
    case 1:
      token =
          '006524a6bc2ad324e88a9f130bb6ef2f71eIABXhvkt+8ICakB0Stg1UG+l37p5QYH1cWcEJYm1oFAjxpzywRwAAAAAEAC74Hh6j5RzYAEAAQCPlHNg';
      break;
    case 2:
      token =
          '006524a6bc2ad324e88a9f130bb6ef2f71eIAD1kf33/d6F6MvkCvbIG34VR5ynOGYoDMqLSt29RV7xVwrCxmsAAAAAEAC74Hh665RzYAEAAQDqlHNg';
      break;
    case 3:
      token =
          '006524a6bc2ad324e88a9f130bb6ef2f71eIAAjzhJmXOKkoimEJLuUMY55GVcISPifrFxHxSz6mLwuDrCTz/IAAAAAEAC74Hh6BZVzYAEAAQAElXNg';
      break;
    case 4:
      token =
          '006524a6bc2ad324e88a9f130bb6ef2f71eIADmZiK8+Ls6nfAIeZkOI47KfY6M2qVESeNA4KXxmmnifiajyIUAAAAAEAC74Hh6g5VzYAEAAQCClXNg';
      break;
    case 5:
      token =
          '006524a6bc2ad324e88a9f130bb6ef2f71eIADLmQzqqIp6vBA8D35/CJaitNwbKYOh8bWAH7f+npcikIU2rBsAAAAAEAC74Hh6spVzYAEAAQCxlXNg';
      break;
    case 0:
      token =
          '006524a6bc2ad324e88a9f130bb6ef2f71eIADkLsk44tkVax2LXocFHq1VfYQhib7Qv62q1WTfOHiRMxMGq2wAAAAAEAC74Hh60pVzYAEAAQDRlXNg';
      break;
  }
  return token;
}
