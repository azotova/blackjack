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
    playerHand.on 'gameOver', ->
      console.log 'you lose'
      that.gameOver()
    playerHand.on 'dealersTurn', ->
      console.log('dealer turn called')
      dealerHand.dealerPlay();
    dealerHand.on 'dealerTurnEnd', ->
      console.log("dealer", dealerHand.realScore(), "player", playerHand.realScore())
      if (dealerHand.realScore() > 21) then that.playerWins()
      else if (dealerHand.realScore() < playerHand.realScore()) then that.playerWins()
      else if (dealerHand.realScore() == playerHand.realScore()) then that.tie()
      else that.gameOver()
      console.log('in App, after dealer turn')


  gameOver: ->
    @trigger 'gameOver', @
    console.log('called gO')

  playerWins: ->
    @trigger 'playerWon', @
    console.log('player wins')

  tie: ->
    @trigger 'tie', @
    console.log('tie')
