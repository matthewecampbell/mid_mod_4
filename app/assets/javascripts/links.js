$(document).ready(function(){
  fetchLinks();
  updateLink();
  markAsRead();
  markAsUnread();
  renderLinks();
  searchLinks();
  filterRead();
  filterUnread();
  sortAlphabetically();
});

function searchLinks(){
  $("#link-search").on('keyup', function(e){
    var searchMatches = search(e.target.value)
    var linksHtml = searchMatches.map(function(e) {
      return createLinkHtml(e)
    })
    renderLinks(linksHtml)
  })
}

function search(arg){
  if (arg){
    return $links.filter(function(e){
      return e.title.toLowerCase().includes(arg.toLowerCase()) || e.url.toLowerCase().includes(arg.toLowerCase())
    })
  } else {
    return $links
  }
}


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
    var $link = $(this).closest('.links');
    $.ajax({
      url: '/read?link_id=' + $link[0].id,
      type: 'get'
    })
    .then(fetchLinks)
    .fail(handleError)
  })
}

function markAsUnread(){
  $('#link').on('click', '#markAsUnread', function(){
    var $link = $(this).closest('.links');
    $.ajax({
      url: '/unread?link_id=' + $link[0].id,
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

function filterRead(){
  $("#read_button").on('click', function(e){
    $.ajax({
      url: "api/v1/users_links",
      type: "get",
      success: function(response){
        $links = response
      }
    })
    $links = $links.map(function(e) {
      if(e.read == true){
        return e
      }
    })
    renderLinks(collectLinks($links));
  })
}

function filterUnread(){
  $("#unread_button").on('click', function(e){
    $.ajax({
      url: "api/v1/users_links",
      type: "get",
      success: function(response){
        $links = response
      }
    })
    $links = $links.map(function(e) {
      if(e.read == false){
        return e
      }
    })
    renderLinks(collectLinks($links));
  })
}

function collectLinks( linksData ){
  return linksData.map(createLinkHtml);
}

function renderLinks( linksData ){
  $("#link").html(linksData);
}

function handleError(error){console.log(error)}

function createLinkHtml( data ){
  if(data){
    if (data.read){
      return $("<div class='links' id='"
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
      +"<button id='markAsUnread' class='btn btn-success'>Mark as Unread</button>"
      +"</br>"
      +"</div>")
    } else{
      return $("<div class='links' id='"
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
      +"<button id='markAsRead' class='btn btn-danger'>Mark as Read</button>"
      +"</br>"
      +"</div>")
    }
  }
}

function compare(a, b) {
  if (a.title < b.title)
    return -1;
  if (a.title > b.title)
    return 1;
  return 0;
}

function uncompare(a, b) {
  if (a.title < b.title)
    return 1;
  if (a.title > b.title)
    return -1;
  return 0;
}


function sortAlphabetically(){
  $('#alphabetical').on('click', function(){
    if ($('#alphabetical').data('clicked')){
      $(this).data('clicked', false);
    } else {
      $(this).data('clicked', true);
    }
    if ($('#sort').data('clicked' == true)){
      var sorted = $links.sort(uncompare);
    } else{
      var sorted = $links.sort(compare);
    }
    return renderAlphabeticalLinks(collectLinks(sorted));
  })
}

function renderAlphabeticalLinks( linksData ){
  $("#link").html(linksData);
}
