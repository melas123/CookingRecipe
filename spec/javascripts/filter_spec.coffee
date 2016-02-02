describe 'Filters', ->
  beforeEach module('cookingRecipes')
  describe 'Cuting caracters from description recipe  filter', ->
    cut = null
    beforeEach inject(($filter) ->
      cut = $filter('cut_max_caracters',{})
      return
    )

    it 'given params value null', ->
      expect(cut(null)).toEqual ''
      return

    it 'value.length <= max', ->
      expect(cut('cut8',true,10,'...')).toEqual 'cut8'
      return
    return

  return
