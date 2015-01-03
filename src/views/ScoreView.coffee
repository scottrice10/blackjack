class window.ScoreView extends Backbone.View
  className: 'column-right'

  template: _.template('<div class="<%= result.class%>"><%= result.message%></div>'),

  render: ->
    if $("." + @model.attributes.result.class).length == 0
      @.$el.html(@.template(@.model.attributes))



