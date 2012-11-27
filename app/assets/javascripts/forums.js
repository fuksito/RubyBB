$(document).ready(function(){
  $("#forums").tableDnD({
    dragHandle: ".position",
    onDrop: function(table, row) {
      $.ajax({
        url: '/forums/position.json',
        type: 'put',
        data: $.tableDnD.serialize()
      })
    }
  });
});
