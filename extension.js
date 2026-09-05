const vscode = require(`vscode`);
const { getDdsRecordFoldingRanges } = require(`./src/dspfFolding`);

function activate(context) {
  const provider = {
    provideFoldingRanges(document) {
      const lines = document.getText().split(/\r?\n/);
      return getDdsRecordFoldingRanges(lines).map(range => new vscode.FoldingRange(
        range.startLine,
        range.endLine,
        vscode.FoldingRangeKind.Region
      ));
    },
  };

  context.subscriptions.push(
    vscode.languages.registerFoldingRangeProvider({ language: `dds.dspf` }, provider)
  );
}

function deactivate() {}

module.exports = {
  activate,
  deactivate,
};
