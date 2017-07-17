$(() => {
  $('#add-link-btn').on('click', function(event) {
    event.preventDefault()
    const link = getLinkValues()
    link.createLink()
  })
})

function getLinkValues() {
  $('input[name="title"]').val()
  let url = $('input[name="link[url]"]').val()
  let title = $('input[name="link[title]"]').val()

  return new Link ({
    title: title,
    url: url,
  })
}
