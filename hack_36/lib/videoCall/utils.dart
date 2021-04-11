var appID = 'c367924b1fe74fdb9c3209dc74aac814';

String getToken(String channelName) {
  var token = "";
  int channel = int.tryParse(channelName[channelName.length - 1]);
  switch (channel) {
    case 0:
      token =
          '006c367924b1fe74fdb9c3209dc74aac814IAC+BOdsHe9lOtDDxiDhq3OKOscARoZ7ihHZH/34Bl8SK5zywRwAAAAAEAAeBkCS2ppzYAEAAQDamnNg';
      break;
    case 1:
      token =
          '006c367924b1fe74fdb9c3209dc74aac814IADGt1nhr9d+NZieqPcSvK2vQ3eeMvlVql7dfFlfc2Q3uQrCxmsAAAAAEAAeBkCSpZtzYAEAAQClm3Ng';
      break;
    case 2:
      token =
          '006c367924b1fe74fdb9c3209dc74aac814IAB179juZFerA+9PW9gmS3wSxyQy+qydkKbBTaDyWlyNvLCTz/IAAAAAEAAeBkCS4ptzYAEAAQDhm3Ng';
      break;
    case 3:
      token =
          '006c367924b1fe74fdb9c3209dc74aac814IADruht0ZuuUVNi/Lv1cifdZqZU0puqMeI3WKy/oN9lI/CajyIUAAAAAEAAeBkCSBpxzYAEAAQAFnHNg';
      break;
    case 4:
      token =
          '006c367924b1fe74fdb9c3209dc74aac814IAAajSq1bP3TJwDpkvzLB17UKRiEcTVu9oRESDD3Ui8RMYU2rBsAAAAAEAAeBkCSH5xzYAEAAQAfnHNg';
      break;
    case 5:
      token =
          '006c367924b1fe74fdb9c3209dc74aac814IABD6r3TNPjPehJzx5HtFqzGc/Gsqlqr976rR8ZQQcf+XBMGq2wAAAAAEAAeBkCSO5xzYAEAAQA7nHNg';
      break;
  }
  return token;
}
