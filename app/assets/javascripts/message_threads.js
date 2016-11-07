var incrementCount = function() {
  var counter = $('#unread-thread-count');
  $.ajax({
    type: 'GET',
    url: "account/message_threads_count",
  }).success(function(count){
    counter.text(count['message_threads_count']);
  })
}

var toggleRead = function(el, unreadStatus) {
  var threadId = $(el).data('threadId');
  $.ajax({
    type: 'PATCH',
    url: "message_threads/" + threadId,
    data: { message_thread: {unread: unreadStatus} }
  }).success(function(messageThread){
    $(el).html(messageThread);
    incrementCount();
  })
}

var toggleMessages = function(el) {
  $('.thread.active').removeClass('active');
  $('.active-thread-messages').html('');
  $(el).addClass('active');
  var activeThreadMessages = $(el).find('.messages').html();
  $('.active-thread-messages').html(activeThreadMessages);
  if($(el).hasClass('unread-true')) {
    toggleRead(el, 'false');
  }
}

$(document).ready(function(){
  $('.thread').click(function(event){
    event.preventDefault();
    toggleMessages(event.currentTarget);
  });
  $('.active-thread-messages').on('click', '.mark-unread', function(event) {
    event.preventDefault();
    var currentEl = event.currentTarget;
    var threadId = $(currentEl).data('unreadId')
    var el = $("[data-thread-id='" + threadId + "']")
    toggleRead(el, 'true');
  });
});
