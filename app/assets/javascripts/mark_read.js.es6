$(() => {
  $('body').on('click', '.mark-as-read', markAsRead)
  updateHotReads()
})

function updateHotReads() {
  $.ajax({
    type: 'GET',
    url: 'http://localhost:3001/api/v1/reads',
    dataType: 'json'
  }).then((reads) => {
    let urls = reads.map((read) => {
      return read.link_url
    })

    $('.card').each((i, card) => {
      let url = $(card).find('a')[0].text.toLowerCase()

      if(urls.includes(url)) {
        $(card).find('.hot').remove()
        $(card).find('.card-title').prepend('<p class="hot">Hot!</p>')
      } else {
        $(card).find('.hot').remove()
      }

      if(urls[0] === url) {
        $(card).find('.hot').remove()
        $(card).find('.top-link').remove()
        $(card).find('.card-title').prepend('<p class="top-link">¡Top Link!</p>')
      } else {
        $(card).find('.top-link').remove()
      }
    })
  }).fail(displayFailure)
}

function markAsRead(e) {
  e.preventDefault()

  let linkId = $(this).closest('.card').data('id')
  let readStatus = $(this).closest('.card').find('.read-status').text().split(' ')[1]

  readStatus = readStatus == "false" ? true : false

  $.ajax({
    type: 'PUT',
    url: `https://polar-plateau-61904.herokuapp.com/api/v1/links/${linkId}`,
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
    createRead(link)
  } else {
    buttonText.prop('value', 'Mark as Read')
  }

  card.toggleClass('clicked')
}

function createRead(link) {
  $.ajax({
    type: 'POST',
    url: 'http://localhost:3001/api/v1/reads',
    dataType: 'json',
    data: {
      read: {
        link_url: link.url
      }
    }
  }).then(updateHotReads)
    .fail(displayFailure)
}

function displayFailure(failureData){
  console.log(`FAILED attempt to update Link: ${failureData.responseText}`)
}
