#= require active_admin/base
#= require chosen-jquery
#= require codemirror
#= require codemirror/modes/markdown
#= require_self

$ ->
  # enable chosen js
  $('.chosen-select').chosen
    allow_single_deselect: true
    no_results_text: 'No results matched'
    width: '200px'

  editor = $('.editor-md');

  if editor.length == 1
  	ed = CodeMirror.fromTextArea(editor[0], { mode: {name: 'markdown', highlightFormatting: true}, lineWrapping: true, theme: 'themanual' })
  	setTimeout (->(ed.refresh())), 100
