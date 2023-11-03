String limitCharacters(String text, int limit) {
  if (text.length > limit) {
    return text.substring(0, limit) + '...';
  } else {
    return text;
  }
}
