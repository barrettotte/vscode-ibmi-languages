const assert = require(`node:assert/strict`);
const test = require(`node:test`);
const { getDdsRecordFoldingRanges, isRecordFormat } = require(`../src/dspfFolding`);

test(`detects DDS record format declarations`, () => {
  assert.equal(isRecordFormat(`00010A          R SCREEN`), true);
  assert.equal(isRecordFormat(`00020A            FIELD CHAR(10)`), false);
  assert.equal(isRecordFormat(`     A* comment`), false);
});

test(`creates one range per non-empty DSPF record format`, () => {
  const lines = [
    `     A* Header`,
    `00010A          R FIRST`,
    `00020A            FIELD1`,
    `     A* Between records`,
    `00030A          R SECOND`,
    `00040A            FIELD2`,
  ];

  assert.deepEqual(getDdsRecordFoldingRanges(lines), [
    { startLine: 1, endLine: 3 },
    { startLine: 4, endLine: 5 },
  ]);
});

test(`does not create a range for an empty record format`, () => {
  const lines = [
    `00010A          R FIRST`,
    `00020A          R SECOND`,
    `00030A            FIELD2`,
  ];

  assert.deepEqual(getDdsRecordFoldingRanges(lines), [
    { startLine: 1, endLine: 2 },
  ]);
});
