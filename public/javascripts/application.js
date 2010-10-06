var app = $.sammy(function() {
  this.element_selector = '#events';
  this.use(Sammy.Haml);
  this.use(Sammy.NestedParams);

  context = this;
  VIEW_PATH = '/javascripts/app/views/';

  EventsController(this, context);
});

$(function() {
  Event.findAllRemote(function() {
    // Run the app when your models are loaded
    app.run('#/events');
  });
});
