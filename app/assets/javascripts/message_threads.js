var toggleMessages = function(el) {
  $('.thread.active').removeClass('active');
  $('.active-thread-messages').html('');
  $(el).addClass('active');
  var activeThreadMessages = $(el).find('.messages').html();
  $('.active-thread-messages').html(activeThreadMessages);
}

$(document).ready(function(){
  $('.thread').click(function(event){
    event.preventDefault();
    toggleMessages(event.currentTarget);
  });
});
