var appID = 'c367924b1fe74fdb9c3209dc74aac814';

String getToken(String channelName) {
  var token = "";
  int channel = int.tryParse(channelName[channelName.length - 1]) + 1;
  switch (channel) {
    case 1:
      token =
          '006c367924b1fe74fdb9c3209dc74aac814IABYi+AZXBh5DDt6YQRuvjUzTXY+ZNwRjFWdbrb5WT/AigrCxmsAAAAAEAAVx5nnpj5zYAEAAQCmPnNg';
      break;
    case 2:
      token =
          '006c367924b1fe74fdb9c3209dc74aac814IACgyZgEKjbRZxeQ46+oORnUGBfjxmnloJLThjFlpXaEh9JjSIgAAAAAEAAeBkCSD9xyYAEAAQAO3HJg';
      break;
    case 3:
      token =
          '006c367924b1fe74fdb9c3209dc74aac814IACgyZgEKjbRZxeQ46+oORnUGBfjxmnloJLThjFlpXaEh9JjSIgAAAAAEAAeBkCSD9xyYAEAAQAO3HJg';
      break;
    case 4:
      token =
          '006c367924b1fe74fdb9c3209dc74aac814IACgyZgEKjbRZxeQ46+oORnUGBfjxmnloJLThjFlpXaEh9JjSIgAAAAAEAAeBkCSD9xyYAEAAQAO3HJg';
      break;
    case 5:
      token =
          '006c367924b1fe74fdb9c3209dc74aac814IACgyZgEKjbRZxeQ46+oORnUGBfjxmnloJLThjFlpXaEh9JjSIgAAAAAEAAeBkCSD9xyYAEAAQAO3HJg';
      break;
    case 0:
      token =
          '006c367924b1fe74fdb9c3209dc74aac814IACgyZgEKjbRZxeQ46+oORnUGBfjxmnloJLThjFlpXaEh9JjSIgAAAAAEAAeBkCSD9xyYAEAAQAO3HJg';
      break;
  }
  return token;
}
