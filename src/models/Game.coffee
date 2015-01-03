class window.Game extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

    @set 'dealerResult',
      class: 'dealer'
      message: 'You lose!'

    @set 'playerResult',
      class: 'player'
      message: 'You win!'

    @set 'blackjackResult',
      class: 'blackjack'
      message: 'Blackjack! You get paid 3 to 2!'

    @set 'pushResult',
      class: 'push'
      message: 'Push. No money changes hands. Play again!'

    @get('playerHand').on 'add remove change', this.checkPlayerBlackJack, @
    @get('dealerHand').on 'add remove change', this.checkDealerBlackJack, @

  checkPlayerBlackJack: ->
    @set 'playerMinScore', @get('playerHand').currentScore()
    playerMin = @get 'playerMinScore'

    if playerMin > 21
      @set 'result', @get('dealerResult')
      @displayResult()
    else if playerMin == 21
      @set 'result', @get('blackjackResult')
      @get('dealerHand').stand()

  checkDealerBlackJack: ->
    @set 'dealerMinScore', @get('dealerHand').currentScore()
    dealerMin =  @get 'dealerMinScore'
    playerMin = @get 'playerMinScore'

    if dealerMin < 17
      @get('dealerHand').hit()
      this.checkDealerBlackJack()
    else if dealerMin > 21 || playerMin > dealerMin
      @set 'result', @get('playerResult')
    else if playerMin < dealerMin
      @set 'result', @get('dealerResult')
    else
      @set 'result', @get('pushResult')

    @displayResult()

  displayResult: ->
    @trigger 'displayResult'
