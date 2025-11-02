enum MessageType { text, image, pdf }

MessageType getMsgType(String msg) {
  switch (msg) {
    case "jpg":
      return MessageType.image;
    case "jpeg":
      return MessageType.image;
    case "png":
      return MessageType.image;
    case "pdf":
      return MessageType.pdf;
    default:
      return MessageType.text;
  }
}
