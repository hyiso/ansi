String stringReplaceAll(String string, String substring, String replacer) {
	int index = string.indexOf(substring);
	if (index == -1) {
		return string;
	}

	final substringLength = substring.length;
	int endIndex = 0;
	String returnValue = '';
	do {
		returnValue += string.substring(endIndex, index) + substring + replacer;
		endIndex = index + substringLength;
		index = string.indexOf(substring, endIndex);
	} while (index != -1);

	returnValue += string.substring(endIndex);
	return returnValue;
}

String stringEncaseCRLFWithFirstIndex(String string, String prefix, String suffix, int index) {
	int endIndex = 0;
	String returnValue = '';
	do {
		final gotCR = string[index - 1] == '\r';
		returnValue += string.substring(endIndex, (gotCR ? index - 1 : index)) + prefix + (gotCR ? '\r\n' : '\n') + suffix;
		endIndex = index + 1;
		index = string.indexOf('\n', endIndex);
	} while (index != -1);

	returnValue += string.substring(endIndex);
	return returnValue;
}