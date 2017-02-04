$(document).on "dblclick", "[data-behavior~=begin_editing_on_dblclick]", ->
  $(@).addClass("editing")
  $(@).find(".edit").focus()

$(document).on "blur", ".editing [data-behavior~=submit_on_blur]", ->
  $(@).closest("form").submit()

$(document).on "keydown", "[data-behavior~=end_editing_on_esc]", (e) ->
  if e.keyCode == 27
    $(@).closest("li").removeClass("editing")
