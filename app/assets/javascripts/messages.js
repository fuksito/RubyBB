$(document).ready(function(){
  $('tr.folded .message, tr.foldable .message').bind('click', function() {
    $this = $(this);
    $this.parents('tr').toggleClass('folded').toggleClass('foldable');
  });
});
