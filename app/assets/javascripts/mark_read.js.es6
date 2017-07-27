$(() => {
  $('body').on('click', '.mark-as-read', markAsRead)
})

function markAsRead(e) {
  e.preventDefault()

  var linkId = $(this).closest('.card').data('id')
  var readStatus = $(this).closest('.card').find('.read-status').text().split(' ')[1]

  $.ajax({
    type: "PATCH",
    url: "/api/v1/links/" + linkId,
    data: { read: true },
  }).then(updateLinkStatus)
    .fail(displayFailure);
}

function updateLinkStatus(link) {
  $(`.link[data-link-id=${link.id}]`).find(".read-status").text(link.read);
}

function displayFailure(failureData){
  console.log("FAILED attempt to update Link: " + failureData.responseText);
}
