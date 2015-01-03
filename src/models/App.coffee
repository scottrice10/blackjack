class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

    @get('playerHand').on 'add remove change', this.checkPlayerBlackJack, @
    @get('dealerHand').on 'add remove change', this.checkDealerBlackJack, @
    @

  checkPlayerBlackJack: ->
    playerMinScore = @get('playerHand').minScore()
    if playerMinScore >= 21
      @get('dealerHand').stand()

  checkDealerBlackJack: ->
    dealerMinScore = @get('dealerHand').minScore()
    if dealerMinScore <= 17
      @get('dealerHand').hit()
      this.checkDealerBlackJack()
