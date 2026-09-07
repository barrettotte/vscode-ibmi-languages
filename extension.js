const vscode = require(`vscode`);
const { getDdsRecordFoldingRanges } = require(`./src/dspfFolding`);

function activate(context) {
  let foldingProvider;

  const updateFoldingProvider = () => {
    foldingProvider?.dispose();
    foldingProvider = undefined;

    const enabled = vscode.workspace
      .getConfiguration(`ibmi-languages.dspf`)
      .get(`recordFormatFolding`, false);

    if (!enabled) {
      return;
    }

    const provider = {
      provideFoldingRanges(document) {
        const lines = document.getText().split(/\r?\n/);
        const ranges = getDdsRecordFoldingRanges(lines);

        return ranges?.map(
          (range) =>
            new vscode.FoldingRange(
              range.startLine,
              range.endLine,
              vscode.FoldingRangeKind.Region,
            ),
        );
      },
    };

    foldingProvider = vscode.languages.registerFoldingRangeProvider(
      { language: `dds.dspf` },
      provider,
    );
  };

  updateFoldingProvider();
  context.subscriptions.push(
    vscode.workspace.onDidChangeConfiguration((event) => {
      if (
        event.affectsConfiguration(`ibmi-languages.dspf.recordFormatFolding`)
      ) {
        updateFoldingProvider();
      }
    }),
  );
  context.subscriptions.push({
    dispose: () => foldingProvider?.dispose(),
  });
}

function deactivate() {}

module.exports = {
  activate,
  deactivate,
};
