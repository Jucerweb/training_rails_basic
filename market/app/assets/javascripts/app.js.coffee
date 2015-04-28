$(document).on "ready page:load", ->
    $("#follow_btn").on "click", ->
      friend = $(this).data("friend")
      button = $(this)
      $.ajax "/users/follow",
      type: "POST"
      datatype: "JSON"
      data: {user: { friend_id: friend}}
      success: (data)->
        console.log data
        button.slideUp()
        error: (err)->
          console.log err
          alert "Can't Create friendship"
