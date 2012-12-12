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
//= require jquery.tablednd
//= require bootstrap
//= require markdown-toolbar
//= require gritter
//= require users
//= require forums
//
// Troubles with require_tree which includes scripts twice
// require_tree .

$(document).ready(function() {

  // generic

  $(document).on('ajax:complete', 'a.ajax', function(){
    $this = $(this);
    $('a[href="'+$this.attr('href')+'"]').replaceWith('<span class="deleteMe '+$this.removeClass('ajax').attr('class')+'">✓</span>');
    setTimeout(function(){
      $('.deleteMe').fadeOut('slow');
    }, 1000);
  })

  // small messages

  $(document).on('ajax:beforeSend', 'a.ajax-delete', function(){
    $(this).css('visibility', 'hidden');
  }).on('ajax:complete', 'a.ajax-delete', function(){
    $(this).parent().hide('slow');
  });

  $('form.new_small_message').bind('ajax:beforeSend', function(e, data){
    $('#small_message_content', this).blur().attr('value', '').attr('disabled', 'disabled');
  })
});
