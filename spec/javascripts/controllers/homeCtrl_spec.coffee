describe 'cookingRecipes', ->
  scope      = undefined
  controller = undefined
 
  beforeEach ->
    module 'cookingRecipes'
    return
  
  describe 'homeCtrl', ->
    scope            = undefined
    httpBackend      = undefined
    createController = undefined
    http = undefined

    beforeEach inject(( $rootScope, $controller, $httpBackend, $http ) ->
      scope          = $rootScope.$new()
      http           = $http 
      httpBackend    = $httpBackend
      controller     = $controller('homeCtrl', '$scope': scope)
      
      afterEach ->
        httpBackend.verifyNoOutstandingExpectation()
        httpBackend.verifyNoOutstandingRequest()
        return
    )
    
    it 'gets the list of recipes', ->
      expect(scope.recipes).not.toBe null
      return
    
    

    it 'should run the Test to get the link data from the go backend', ->

      http.get( 'http://localhost:3000/recipe.json' ).success ( data, status, headers, config ) ->
        scope.recipes = data

      httpBackend.when('GET', 'http://localhost:3000/recipe.json')
                 .respond [
                            {
                              id:          1,
                              title:       "recipe 1",
                              description: "SmartOS images come with pkgsrc pre-installed. On other illumos distributions, first install pkgsrc, then you may install the binary package as normal: SmartOS images come with pkgsrc pre-installed. On other illumos distributions, first install pkgsrc, then you may install the binary package as normal:",
                              username:    "Mohamed Belaid"
                            }
                          ]

      httpBackend.flush()

      console.log( scope.recipes )
      expect( scope.parseOriginalUrlStatus ).not.toBe null
      return 
      
        

    