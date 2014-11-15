class window.Deck extends Backbone.Collection
  model: Card

  initialize: ->
    @add _([0...52]).shuffle().map (card) ->
      new Card
        rank: card % 13
        suit: Math.floor(card / 13)

  dealPlayer: -> new Hand [@pop().flip(), @pop().flip()], @, false, 10, 0

  dealDealer: -> new Hand [@pop().flip(), @pop().flip()], @, true

  last: -> @at(@length-1)

