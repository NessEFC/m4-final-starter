'use strict';

var _createClass = (function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ('value' in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; })();

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError('Cannot call a class as a function'); } }

var Link = (function () {
  function Link(link) {
    _classCallCheck(this, Link);

    this.id = link.id;
    this.url = link.url;
    this.title = link.title;
    this.read = false;
  }

  _createClass(Link, [{
    key: 'createLink',
    value: function createLink() {
      $.ajax({
        type: 'POST',
        url: 'https://polar-plateau-61904.herokuapp.com/api/v1/links',
        dataType: 'json',
        data: {
          link: {
            url: this.url,
            title: this.title
          }
        },
        success: function success(data) {
          var link = new Link(data.link);
          link.appendToPage();
          $('input[name="link[title]"]').val("");
          $('input[name="link[url]"]').val("");
        },
        error: function error(data) {
          $('.errors').append('<p>' + data.responseJSON.message + '</p>');
        }
      });
    }
  }, {
    key: 'appendToPage',
    value: function appendToPage() {
      $('.link-list').prepend('<div class="card" data-id="' + this.id + '">\n        <div class="card-block">\n          <h4 class="card-title">Title: ' + this.title + '</h4>\n          <p class="card-text card-url">URL: <a href="' + this.url + '">' + this.url + '</a></p>\n          <p class="card-text read-status">Read?: ' + this.read + '</p>\n          <input type="button" value="Mark as Read" class="btn btn-info mark-as-read">\n          <a href="/links/' + this.id + '/edit" class="btn btn-warning">Edit</a>\n        </div>\n      </div>');
    }
  }], [{
    key: 'filterLink',
    value: function filterLink(e) {
      var filter = e.target.value.toLowerCase();
      var list = $('.link-list');
      var links = list.find('.card');

      links = Array.from(links);

      links.map(function (link) {
        var title = link.getElementsByClassName('card-title')[0].innerText.split(' ')[1].toLowerCase();
        var url = link.getElementsByClassName('card-url')[0].innerText.split(' ')[1].toLowerCase();

        if (title.indexOf(filter) > -1 || url.indexOf(filter) > -1) {
          link.style.display = '';
        } else {
          link.style.display = 'none';
        }
      });
    }
  }, {
    key: 'filterUnread',
    value: function filterUnread(e) {
      var list = $('.link-list');
      var links = list.find('.card');

      links = Array.from(links);

      links.map(function (link) {
        var status = link.getElementsByClassName('read-status')[0].innerText.split(' ')[1];

        status == 'false' ? link.style.display = '' : link.style.display = 'none';
      });
    }
  }, {
    key: 'filterRead',
    value: function filterRead(e) {
      var list = $('.link-list');
      var links = list.find('.card');

      links = Array.from(links);

      links.map(function (link) {
        var status = link.getElementsByClassName('read-status')[0].innerText.split(' ')[1];

        status == 'true' ? link.style.display = '' : link.style.display = 'none';
      });
    }
  }]);

  return Link;
})();
