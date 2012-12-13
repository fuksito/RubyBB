$(document).ready(function(){
  $('.details').hide();
  $('.more a').click(function(){
    $this = $(this);
    $this.hide();
    $this.parents('.expandable').find('.details').show('fast');
  });
});
