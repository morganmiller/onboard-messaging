var markRead = function(el) {
  var threadId = $(el).data('threadId')
  $.ajax({
    type: 'PATCH',
    url: "message_threads/" + threadId,
    data: { message_thread: {unread: "false"} }
  }).success(function(messageThread){
    $(el).html(messageThread)
  })
}

var toggleMessages = function(el) {
  $('.thread.active').removeClass('active');
  $('.active-thread-messages').html('');
  $(el).addClass('active');
  var activeThreadMessages = $(el).find('.messages').html();
  $('.active-thread-messages').html(activeThreadMessages);
  if($(el).hasClass('unread-true')) {
    markRead(el)
  }
}

$(document).ready(function(){
  $('.thread').click(function(event){
    event.preventDefault();
    toggleMessages(event.currentTarget);
  });
});
