$(document).ready(function(){
  $('.details').hide();
  $('.more a').click(function(){
    that = $(this);
    that.hide();
    $('.details', that.parents('.expandable')).show('fast');
  });
});
