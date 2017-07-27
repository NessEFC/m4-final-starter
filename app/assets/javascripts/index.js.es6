$(() => {
  $('#add-link-btn').on('click', function(event) {
    event.preventDefault()
    const link = getLinkValues()
    if(link.url && link.title) {
      $('.errors').empty()
      link.createLink()
    } else if(!link.url && !link.title) {
      $('.errors').empty()
      $('.errors').append(`<p>Fields can't be blank.</p>`)
      $('input[name="link[title]"]').val("")
      $('input[name="link[url]"]').val("")
    } else if(!link.title) {
      $('.errors').empty()
      $('.errors').append(`<p>Title can't be blank.</p>`)
      $('input[name="link[title]"]').val("")
      $('input[name="link[url]"]').val("")
    } else {
      $('.errors').empty()
      $('.errors').append(`<p>URL can't be blank.</p>`)
      $('input[name="link[title]"]').val("")
      $('input[name="link[url]"]').val("")
    }
  })

  $('#links-filter').on('keyup', (event) => {
    Link.filterLink(event)
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
