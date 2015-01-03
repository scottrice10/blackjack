class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

    @get('playerHand').on 'add remove change', this.checkPlayerBlackJack, @
    @get('dealerHand').on 'add remove change', this.checkDealerBlackJack, @
    @

  checkPlayerBlackJack: ->
    @set 'playerMinScore', @get('playerHand').minScore()
    if @get 'playerMinScore' > 21
      @set 'result', 'dealer'
      @displayResult
    else if @get 'playerMinScore' == 21
      @set 'result', 'blackjack'
      @get('dealerHand').stand()
    else
      @

  checkDealerBlackJack: ->
    @set 'dealerMinScore', @get('dealerHand').minScore()
    if @get 'dealerMinScore' <= 17
      @get('dealerHand').hit()
      this.checkDealerBlackJack()
    else
      if @get 'dealerMinScore' > 21
        @set 'result', 'player'

  displayResult: ->
    @$el.append '<div></div>'
