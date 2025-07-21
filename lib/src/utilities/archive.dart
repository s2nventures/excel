part of excel;

Archive _cloneArchive(
  Archive archive,
  Map<String, ArchiveFile> _archiveFiles, {
  String? excludedFile,
}) {
  var clone = Archive();

  for (final file in archive.files) {
    if (!file.isFile) {
      continue;
    }

    if (excludedFile != null &&
        file.name.toLowerCase() == excludedFile.toLowerCase()) {
      continue;
    }

    ArchiveFile copy;

    if (_archiveFiles.containsKey(file.name)) {
      copy = _archiveFiles[file.name]!;
    } else {
      // Archive 4.x: file.content is FileContent, use readBytes() to get bytes
      final bytes = file.content;

      final compress = !_noCompression.contains(file.name);

      copy = compress
          ? ArchiveFile(file.name, bytes.length, bytes)
          : ArchiveFile.noCompress(file.name, bytes.length, bytes);
    }

    clone.addFile(copy);
  }

  return clone;
}
