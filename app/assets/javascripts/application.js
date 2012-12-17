// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require jquery.caretposition
//= require jquery.sew
//= require jquery.tablednd
//= require textarea.jquery
//= require bootstrap
//= require markdown-toolbar
//= require gritter
//= require users
//= require forums
//= require messages
//
// Troubles with require_tree which includes scripts twice
// require_tree .

var values = [];
$(document).ready(function() {
  // Handle autocomplete and maxlength
  $("textarea").sew({values: values}).textarea();

  // Does not submit forms twice
  $('form:not([data-remote])').submit(function(){
    $this = $(this);
    if ($this.data('submitted')) {
      return false;
    } else {
      $this.find('input[type=submit]').addClass('disabled');
      $this.data('submitted', true);
    }
  });

  // notifications

  $('a.delete_notification').bind('ajax:beforeSend', function(){
    $(this).parents('tr').hide('slow');
  });

  // small messages

  $(document).on('ajax:beforeSend', 'a.delete_small_message', function(){
    $(this).css('visibility', 'hidden');
  }).on('ajax:complete', 'a.delete_small_message', function(){
    $(this).parent().hide('slow');
  });

  $('form.new_small_message').bind('ajax:beforeSend', function(e, data){
    $(this).find('#small_message_content').blur().attr('value', '').attr('disabled', 'disabled').css('visibility', 'hidden');
  })
});
