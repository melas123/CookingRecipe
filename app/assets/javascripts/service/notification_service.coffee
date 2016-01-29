@cooking.service 'Notification', (toaster) ->

  @error = ( msg ) ->
    toaster.pop 'error', 'Error', msg

  @success = ( msg ) ->
    toaster.pop 'success', 'success', msg

  @info = ( msg ) ->
    toaster.pop 'info', 'Validation', msg

  @warning = ( msg ) ->
    toaster.pop 'warning', 'Validation', msg
  return
