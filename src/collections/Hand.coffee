class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isDealer) ->

  stand: ->
    @each (card) ->
      if !card.get 'revealed'
        card.flip()

        #disable hit and stand buttons when player done playing
        $('.hit-button').prop("disabled",true);
        $('.stand-button').prop("disabled",true);
      @

  hit: ->
    @add(@deck.pop())

  hasAce: -> @reduce (memo, card) ->
    memo or card.get('value') is 1
  , 0

  minScore: ->
    score = @reduce (score, card) ->
      score + if card.get 'revealed' then card.get 'value' else 0
    , 0

    score

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    [@minScore(), @minScore() + 10 * @hasAce()]


