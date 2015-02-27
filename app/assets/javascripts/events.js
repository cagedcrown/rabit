(function() {
  $(document).ready(function() {
    return $("#calendar").fullCalendar({
      events: '/events.json'
    });
  });

}).call(this);
