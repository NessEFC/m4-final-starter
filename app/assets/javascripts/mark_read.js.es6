$(() => {
  $('body').on('click', '.mark-as-read', markAsRead)
})

function markAsRead(e) {
  e.preventDefault()

  let linkId = $(this).closest('.card').data('id')
  let readStatus = $(this).closest('.card').find('.read-status').text().split(' ')[1]

  readStatus = readStatus == "false" ? true : false

  $.ajax({
    type: 'PUT',
    url: `/api/v1/links/${linkId}`,
    dataType: 'json',
    data: {
      link: {
        read: readStatus
      }
    },
  }).then(updateLinkStatus)
    .fail(displayFailure)
}

function updateLinkStatus(link) {
  let card = $(`.card[data-id=${link.id}]`)
  let status = card.find('.read-status')
  let buttonText = card.find('.mark-as-read')

  status.text(`Read?: ${link.read}`)

  if(link.read) {
    buttonText.prop('value', 'Mark as Unread')
  } else {
    buttonText.prop('value', 'Mark as Read')
  }

  card.toggleClass('clicked')
}

function displayFailure(failureData){
  console.log(`FAILED attempt to update Link: ${failureData.responseText}`)
}
