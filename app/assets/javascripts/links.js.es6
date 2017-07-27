class Link {
  constructor(link) {
    this.id = link.id
    this.url = link.url
    this.title = link.title
    this.read = false
  }

  createLink() {
    $.ajax({
      type: 'POST',
      url: '/api/v1/links',
      dataType: 'json',
      data: {
        link:
          {
            url: this.url,
            title: this.title,
          }
      },
      success: function(data) {
        const link = new Link(data.link)
        link.appendToPage()
        $('input[name="link[title]"]').val("")
        $('input[name="link[url]"]').val("")
      },
      error: function(data) {
        $('.errors').append(`<p>${data.responseJSON.message}</p>`)
      }
    })
  }

  appendToPage() {
    $('.link-list').prepend(
     `<div class="card" data-id="${this.id}">
        <div class="card-block">
          <h4 class="card-title">Title: ${this.title}</h4>
          <p class="card-text">URL: <a href="${this.url}">${this.url}</a></p>
          <p class="card-text read-status">Read?: ${this.read}</p>
          <input type="button" value="Mark as Read" class="btn btn-info mark-as-read">
          <a href="/links/${this.id}/edit" class="btn btn-warning">Edit</a>
        </div>
      </div>`
    )
  }
}
