var Event = Model("event",
  {
    persistence: Model.RestPersistence("/events"),

    findAllRemote: function(callback) {
      $.getJSON('/events.json', function(data) {
        $.each(data, function(i, event) {
          var event_data = event;
          var event = new Event({ id: event_data.id });
          event.merge(event_data);
          Event.add(event);
        });
        callback.call(this);
      });
    }
  },
  {
    loudName: function() {
      return this.attr('name').toUpperCase() + "!!!!!"
    }
  }
);
