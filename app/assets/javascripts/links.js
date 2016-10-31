$(document).ready(function(){
  updateLink();
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
