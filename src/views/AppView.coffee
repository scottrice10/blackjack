class window.AppView extends Backbone.View
  className: 'column-left'

  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button> <button class="new-game-button">New Game</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    'click .hit-button': -> (@model.get 'game').get('playerHand').hit()
    'click .stand-button': ->(@model.get 'game').get('dealerHand').stand()
    'click .new-game-button': -> @reRender()

  initialize: ->
    @render()
    (@model.get 'game').on('displayResult', @displayResult, @)

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: (@model.get 'game').get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: (@model.get 'game').get 'dealerHand').el

  reRender: ->
    $('body').html(new AppView(model: new App()).$el)

  displayResult: ->
    $('body').append new ScoreView({model: (@model.get 'game')}).render()

    #disable hit and stand buttons when player done playing
    $('.hit-button').prop("disabled",true);
    $('.stand-button').prop("disabled",true);


