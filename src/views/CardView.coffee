class window.CardView extends Backbone.View
  className: 'card'

  initialize: -> @render()

  render: ->
    @$el.children().detach()
    @$el.addClass 'covered' unless @model.get 'revealed'
    @$el.css("background", "url(img/cards/" + @model.attributes.rankName.toString().toLowerCase() + "-" + @model.attributes.suitName.toString().toLowerCase() + ".png) no-repeat");

