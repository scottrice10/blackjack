class window.CardView extends Backbone.View
  className: 'card'

  #template: _.template '<%= rankName %> of <%= suitName %>'

  initialize: -> @render()

  render: ->
    @$el.children().detach()
    #@$el.html @template @model.attributes
    @$el.addClass 'covered' unless @model.get 'revealed'
    @$el.css("background", "url(img/cards/" + @model.attributes.rankName.toString().toLowerCase() + "-" + @model.attributes.suitName.toString().toLowerCase() + ".png) no-repeat");

