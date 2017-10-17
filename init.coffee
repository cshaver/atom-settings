# Your init script
#
# Atom will evaluate this file each time a new window is opened. It is run
# after packages are loaded/activated and after the previous editor state
# has been restored.
#
# An example hack to make opened Markdown files always be soft wrapped:
#
# path = require 'path'
#
# atom.workspaceView.eachEditorView (editorView) ->
#   editor = editorView.getEditor()
#   if path.extname(editor.getPath()) is '.md'
#     editor.setSoftWrap(true)

atom.workspace.observeTextEditors (editor) ->
  if editor.getPath()?.match(/\/dotfiles\/.+\/[^.]+$/)
    editor.setGrammar(atom.grammars.grammarForScopeName('text.sh'))

atom.commands.add 'atom-text-editor', 'custom:fix-file', ->
  editor = atom.workspace.getActiveTextEditor()
  view = atom.views.getView(editor)
  atom.commands.dispatch(view, 'EditorConfig:fix-file')
  atom.commands.dispatch(view, 'core:save')
  atom.commands.dispatch(view, 'linter-eslint:fix-file')
