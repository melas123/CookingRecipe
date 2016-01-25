#Group services/factories into a services directory
@cooking.factory 'restService', ['$resource', ($resource,page) ->
  perpage: $resource('/recipe.json',{},
    {
      query: {method: 'GET', isArray: false, params: page: '@page'}
      search: {method: 'GET', isArray: false, params: page: '@page' , search: '@search' }
    })
  ]
