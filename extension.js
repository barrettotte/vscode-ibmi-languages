const vscode = require(`vscode`);
const { getDdsRecordFoldingRanges } = require(`./src/dspfFolding`);

function activate(context) {
  let foldingProvider;

  const unfoldActiveDspfEditor = async () => {
    if (vscode.window.activeTextEditor?.document.languageId !== `dds.dspf`) {
      return;
    }

    await vscode.commands.executeCommand(`editor.unfoldAll`);
  };

  const updateFoldingProvider = async (unfoldWhenDisabled = false) => {
    foldingProvider?.dispose();
    foldingProvider = undefined;

    const enabled = vscode.workspace
      .getConfiguration(`ibmi-languages.dspf`)
      .get(`recordFormatFolding`, false);

    if (!enabled) {
      if (unfoldWhenDisabled) {
        await unfoldActiveDspfEditor();
      }
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
        void updateFoldingProvider(true);
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
