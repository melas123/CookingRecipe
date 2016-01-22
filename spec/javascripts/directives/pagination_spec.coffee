describe 'cookingRecipes Pagination', ->

  elm     = undefined
  scope   = undefined

  beforeEach module( 'cookingRecipes' )

  beforeEach inject(( $rootScope, $compile ) ->
    elm   = angular.element( document.querySelector( '#btn1' ) )

    scope = $rootScope
    $compile( elm ) scope
    scope.$digest()
    return
  )

  it 'should create clickable button', ->

    console.log elm.find( 'btn1' )
    titles    = elm.find( 'ul.nav-tabs li a' )
    return
  return
 
  it 'should have previous and next Page ', ->

    contents = elm.find( 'div.tab-content div.tab-pane' )
    expect(elm.html()).toContain("previousPage()")
    expect(elm.html()).toContain("nextPage()")
    return
  return
