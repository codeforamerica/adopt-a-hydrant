jQuery () ->
  if $("body.main").length > 0

    if $("#user_email").length > 0
      $("#user_email").focus()

    if $("#address").length > 0
      $("#address").focus()
