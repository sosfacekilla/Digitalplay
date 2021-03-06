jQuery ->
  $('.yt_preview').click -> makeVideoPlayer $(this).data('uid')

  # Initially the player is not loaded
  window.ytPlayerLoaded = false

  _run = ->
    # Runs as soon as Google API is loaded
    $('.yt_preview').first().click()
    return

  $(window).bindWithDelay('resize', ->
    player = $('#ytPlayer')
    player.height(player.width() / 1.777777777) if player.size() > 0
    return
  , 500)

  makeVideoPlayer = (video) ->
    if !window.ytPlayerLoaded
      player_wrapper = $('#player-wrapper')
      player_wrapper.append('<div id="ytPlayer"><p>Loading player...</p></div>')

      window.ytplayer = new YT.Player('ytPlayer', {
        width: '100%'
        height: player_wrapper.width() / 1.777777777
        videoId: video
        playerVars: {
          wmode: 'opaque'
          autoplay: 1
          modestbranding: 1
          rel: 0
          highDef: 0
          autohide: 1
          iv_load_policy: 3,

        }


       
      events: {
          'onReady': -> window.ytPlayerLoaded = true
          'onStateChange': (stateChange) -> (video == YT.PlayerState.PLAYING && !done)(window.ytplayer.playVideo())
          'onError': (errorCode) -> alert("We are sorry, but the following error occured: " + errorCode)
        }
      })
    else
      window.ytplayer.loadVideoById(video)
      window.ytplayer.playVideo()
    return

  google.setOnLoadCallback _run

  return



   