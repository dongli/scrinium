$(document).on 'page:change', ->
  if $('#resource-board').length == 1
    toggleRow = (row) ->
      if row.attr('selected') == 'selected'
        row.attr('selected', false)
        row.removeClass('selected')
      else
        row.attr('selected', true)
        row.addClass('selected')

    $('#resource-board-table').unbind('click').on 'click', 'tr', (e) ->
      if e.altKey
        # 选择或不选择多行（一次一行）。
        toggleRow $(this)
      else if e.shiftKey
        # 选择或不选择多行（一次多行）。
        row = $(this)
        while row.attr('selected') != 'selected' and row.is('tr')
          toggleRow row
          row = row.prev()
      else
        # 选择或不选择单行
        selected = $(this).attr('selected') == 'selected'
        toggleRow $('#resource-board-table tr.selected')
        if not selected
          toggleRow $(this)
      if $('#resource-board-table tr.selected').length > 0
        $('#resource-board-table-head th').hide()
        $('#resource-board-file-actions').show()
      else
        $('#resource-board-table-head th').show()
        $('#resource-board-file-actions').hide()
