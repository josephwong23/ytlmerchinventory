//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require selectize
//= require_tree .

$(document).ready(function() {
  $('#selectize_member_division').selectize({
    create: function(input, callback) {
      $.ajax({
        url: '/member_divisions',
        method: 'post',
        data: {
          member_division: {
            name: input
          }
        },
        success: function(data) {
          toastr.success("You've added new division: " + data.response.name)
          callback({
            value: data.response.id,
            text: data.response.name
          })
        },
        error: function() {
          toastr.error("The division you're trying to add already existed. Please select from the dropdown.")
          callback({
            value: null,
            text: 'Try Again'
          })
        }
      })
    },
    sortField: 'text'
  });

  $('#selectize_category').selectize({
    create: function(input, callback) {
      $.ajax({
        url: '/categories',
        method: 'post',
        data: {
          category: {
            name: input
          }
        },
        success: function(data) {
          toastr.success("You've added new category: " + data.response.name)
          callback({
            value: data.response.id,
            text: data.response.name
          })
        },
        error: function() {
          toastr.error("The category you're trying to add already existed. Please select from the dropdown.")
          callback({
            value: null,
            text: 'Try Again'
          })
        }
      })
    },
    sortField: 'text'
  });
})
