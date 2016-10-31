$(document).ready(function(){
  fetchLinks();
  updateLink();
  markAsRead();
  markAsUnread();
  renderLinks();
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
    var $link = $(this).closest('#links');
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
    var $link = $(this).closest('#links');
    $.ajax({
      url: '/unread?link_id=' + $link.data('id'),
      type: 'get'
    })
    .then(fetchLinks)
    .fail(handleError)
  })
}

function fetchLinks(){
  $.ajax({
    url: "api/v1/users_links",
    type: "get",
    success: function(response){
      $links = response
    }
  })
  .then(collectLinks)
  .then(renderLinks)
  .fail(handleError)
}

function collectLinks( linksData ){
  return linksData.map(createLinkHtml);
}

function renderLinks( linksData ){
  $("#link").html(linksData);
}

function handleError(error){console.log(error)}

function createLinkHtml( data ){
  if (data.read){
    return $("<div id='links' data-id='"
    + data.id
    +"'>___________________<br><br>"
    + "<strike>"
    +"<strong> Title: </strong><p class='linkEdit title' contenteditable='true'>"
    +data.title
    + "</p>"
    +"<strong> Url: </strong> <p class='linkEdit url' contenteditable='true'>"
    +data.url
    +"</p>"
    +"<strong> Read: </strong> True"
    +"</br>"
    +"</strike>"
    +"</br>"
    +"<button id='markAsUnread'>Mark as Unread</button>"
    +"</br>"
    +"</div>")
  } else{
    return $("<div id='links' data-id='"
    + data.id
    +"'>___________________<br><br>"
    +"<strong> Title: </strong> <p class='linkEdit title' contenteditable='true'>"
    + data.title
    +"</p>"
    +"<strong> Url: </strong> <p class='linkEdit url' contenteditable='true'>"
    + data.url
    +"</p>"
    +"<strong> Read: </strong> False </br>"
    +"</br>"
    +"<button id='markAsRead'>Mark as Read</button>"
    +"</br>"
    +"</div>")
  }
}
