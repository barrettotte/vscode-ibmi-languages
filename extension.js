const vscode = require(`vscode`);
const { getDdsRecordFoldingRanges } = require(`./src/dspfFolding`);

function activate(context) {
  let foldingProvider;

  const isFoldingEnabled = () =>
    vscode.workspace
      .getConfiguration(`ibmi-languages.dspf`)
      .get(`recordFormatFolding`, false);

  const unfoldIfDisabled = async (editor) => {
    if (!editor || editor.document.languageId !== `dds.dspf`) {
      return;
    }

    if (isFoldingEnabled()) {
      return;
    }

    if (vscode.window.activeTextEditor !== editor) {
      return;
    }

    await vscode.commands.executeCommand(`editor.unfoldAll`);
  };

  // Registered once and kept alive: removing the provider entirely makes
  // VS Code fall back to indentation-based folding, which recreates the
  // same chevrons at record boundaries even while the flag is disabled.
  const foldingRangesChanged = new vscode.EventEmitter();
  const provider = {
    onDidChangeFoldingRanges: foldingRangesChanged.event,
    provideFoldingRanges(document) {
      if (!isFoldingEnabled()) {
        return [];
      }

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

  const updateFoldingProvider = async (unfoldWhenDisabled = false) => {
    if (unfoldWhenDisabled) {
      await unfoldIfDisabled(vscode.window.activeTextEditor);
    }

    foldingRangesChanged.fire();
  };

  foldingProvider = vscode.languages.registerFoldingRangeProvider(
    { language: `dds.dspf` },
    provider,
  );
  context.subscriptions.push(
    vscode.workspace.onDidChangeConfiguration((event) => {
      if (
        event.affectsConfiguration(`ibmi-languages.dspf.recordFormatFolding`)
      ) {
        void updateFoldingProvider(true);
      }
    }),
  );
  // Catches dds.dspf tabs that were already collapsed and hidden at the
  // time the flag was disabled: they get cleaned up the moment the user
  // actually switches to them, instead of forcing focus through every tab.
  context.subscriptions.push(
    vscode.window.onDidChangeActiveTextEditor((editor) => {
      void unfoldIfDisabled(editor);
    }),
  );
  context.subscriptions.push(foldingRangesChanged);
  context.subscriptions.push({
    dispose: () => foldingProvider?.dispose(),
  });
}

function deactivate() {}

module.exports = {
  activate,
  deactivate,
};
