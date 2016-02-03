@cooking.filter 'fromNow', ->
  (date) ->
    date = moment(date)
    moment.locale('fr')
    return date.fromNow()
