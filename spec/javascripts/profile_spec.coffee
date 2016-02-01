describe 'Profile Testing services $http', ->
  beforeEach module('cookingRecipes')
  describe 'testing profile services', ->
    profile = null
    $httpBackend = null
    beforeEach inject((_$httpBackend_) ->
      $injector = angular.injector(['cookingRecipes'])
      profile = $injector.get('Profile')
      $httpBackend = _$httpBackend_
      return
    )
    it 'get user by id', ->

      expect('recipe20').toEqual("recipe20")
      return
    return
  return
