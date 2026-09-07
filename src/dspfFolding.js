function isRecordFormat(line) {
  return (
    line.length > 16 &&
    line[5]?.toUpperCase() === `A` &&
    line[6] !== `*` &&
    line[16]?.toUpperCase() === `R`
  );
}

function getDdsRecordFoldingRanges(lines) {
  const recordLines = [];

  for (let line = 0; line < lines.length; line++) {
    if (isRecordFormat(lines[line])) {
      recordLines.push(line);
    }
  }

  const ranges = recordLines
    .slice(0, -1)
    .map((startLine, index) => ({
      startLine,
      endLine: recordLines[index + 1] - 1,
    }))
    .concat(
      recordLines.length > 0 &&
        recordLines[recordLines.length - 1] < lines.length - 1
        ? [
            {
              startLine: recordLines[recordLines.length - 1],
              endLine: lines.length - 1,
            },
          ]
        : [],
    )
    .filter((range) => range.endLine > range.startLine);

  return ranges.length > 0 ? ranges : undefined;
}

module.exports = {
  getDdsRecordFoldingRanges,
  isRecordFormat,
};
