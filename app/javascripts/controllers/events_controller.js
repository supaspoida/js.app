EventsController = function(app) { with(app) {

  /** Routes **/

  // GET index
  get('#/events', function(context) {
    context.events = Event.all();
    context.partial(VIEW_PATH + 'events/index.haml');
  });


}};

