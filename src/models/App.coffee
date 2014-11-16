# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model

  initialize: ->
    that = @
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    playerHand = @get 'playerHand'
    #console.log(playerHand.realScore())
    @set 'dealerHand', deck.dealDealer()
    dealerHand = @get 'dealerHand'
    console.log('start')
    @listen(playerHand, dealerHand)

  listen: (pl, dl) ->
    that = @
    #playerHand = @get 'playerHand'
    #dealerHand = @get 'dealerHand'
    playerHand = pl
    dealerHand = dl
    playerHand.on 'gameOver', ->
      console.log 'you lose'
      that.gameOver()
    playerHand.on 'dealersTurn', ->
      console.log('dealer turn called')
      dealerHand.dealerPlay();
    playerHand.on 'betMade', ->
      console.log('bet has been made')
      dealerHand.at(1).flip();
      if (playerHand.realScore() == 21) then that.blackjack()
    dealerHand.on 'dealerTurnEnd', ->
      console.log("dealer", dealerHand.realScore(), "player", playerHand.realScore())
      if (dealerHand.realScore() > 21) then that.playerWins()
      else if (dealerHand.realScore() < playerHand.realScore()) then that.playerWins()
      else if (dealerHand.realScore() == playerHand.realScore()) then that.tie()
      else that.gameOver()
      console.log('in App, after dealer turn')

  reset: (player, dealer) ->
    @set('playerHand', player)
    @set('dealerHand', dealer)
    playerHand = @get 'playerHand'
    dealerHand = @get 'dealerHand'
    @listen(playerHand, dealerHand)

  gameOver: ->
    @trigger 'gameOver', @
    console.log('called gO')

  playerWins: ->
    playerHand = @get 'playerHand'
    playerHand.money += 2* playerHand.betAmount
    @trigger 'playerWon', @
    console.log('player wins')

  tie: ->
    @trigger 'tie', @
    console.log('tie')

  blackjack: ->
    playerHand = @get 'playerHand'
    playerHand.money += 2.5* playerHand.betAmount
    console.log('blackjack')
    @trigger 'blackjack', @



