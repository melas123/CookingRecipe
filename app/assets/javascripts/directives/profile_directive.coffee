@cooking.directive 'tagFollowingFollowers',(Profile,$log)->
  templateUrl: 'assets/templates/profile/tag_following_followers.html.haml'
  restrict: 'E'
  link: (scope, element) ->

  controller: ($scope, Auth, $element) ->

    # get current user
    Auth.currentUser().then  (user) ->
      $scope.user = user

    # create follow for follower user
    $scope.createFollowByFollowerUser = (id, index) ->
      Profile.createFollow(followed_id : id).success( (data) ->
        $scope.following.push(data)
        $('#followers button:nth('+index+')').css('display','none')
      )

    # remove a follow
    $scope.removeFollow = (id, index) ->
      Profile.removeFollow(followed_id : id)
      $scope.following.splice(index,1)
      $('#followers button:nth('+index+')').css('display','block')

    #switch class button tag
    $scope.ActiveBtnTag = (nb) ->
      switch nb
        when 1
          $('#following_btn').removeClass('btn-default').addClass('btn-primary')
          $('#followers_btn').removeClass('btn-primary').addClass('btn-default')
        when 2
          $('#following_btn').removeClass('btn-primary').addClass('btn-default')
          $('#followers_btn').removeClass('btn-default').addClass('btn-primary')
      return false

    # get following users by user id
    Profile.getNbFollowingByUserId($scope.id).success( (data) ->
      $scope.following = data
    )

    #check if user is in followed or not
    $scope.isFollowed = (id, index)->
      $scope.response = false
      Profile.isFollowed(id).success (data) ->
        $scope.response = data
        if $scope.response
          $('#followers button:nth('+index+')').css('display','none')
        else
          $('#followers button:nth('+index+')').css('display','block')

    # get followers users by user id
    Profile.getNbFollowersByUserId($scope.id).success( (data) ->
      $scope.followers = data
      for follow, index in $scope.followers
        $scope.isFollowed( follow.id, index )

    )
