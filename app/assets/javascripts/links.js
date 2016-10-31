$(document).ready(function(){
  updateLink();
  markAsRead();
  markAsUnread();
});

function updateLink(){
  $('#link').on('blur', '.linkEdit', function(){
    var $link = $(this).parent();
    var $linkParams = {
      title: $link.find(".title").html(),
      url: $link.find(".url").html()
    }
    $.ajax({
      url: "/links/" + $link.data("id"),
      data: $linkParams,
      type: "put"
    })
  })
}

function markAsRead(){
  $('#link').on('click', '#markAsRead', function(){
    var $link = $(this).closest('#link');
    $.ajax({
      url: '/read?link_id=' + $link.data('id'),
      type: 'get'
    })
    .then(fetchLinks)
    .fail(handleError)
  })
}

function markAsUnread(){
  $('#link').on('click', '#markAsUnread', function(){
    var $link = $(this).closest('#link');
    $.ajax({
      url: '/read?link_id=' + $link.data('id'),
      type: 'get'
    })
    .then(fetchLinks)
    .fail(handleError)
  })
}

function fetchLinks(){
  $.ajax({
    url: "api/v1/ideas.json",
    type: "get",
    success: function(response){
      $ideas = response
    }
  }).then(collectLinks)
  .then(renderLinks)
  .fail(handleError)
}
