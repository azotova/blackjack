# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model

  initialize: ->
    # debugger
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    console.log('start')
    that = @
    playerHand = @get 'playerHand'
    dealerHand = @get 'dealerHand'
    playerHand.on 'gameOver', (hand) ->
      console.log 'you lose'
      that.gameOver()
    playerHand.on 'dealersTurn' ->
      dealerHand.dealerPlay();


  gameOver: ->
    @trigger 'gameOver', @
    console.log('called gO')
