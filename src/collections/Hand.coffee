class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isDealer) ->

  stand: ->
    @trigger 'dealersTurn', @

  hit: ->
    @add(@deck.pop())
    console.log(@minScore())
    if @minScore() > 21 then @trigger 'gameOver', @

  hasAce: -> @reduce (memo, card) ->
    memo or card.get('value') is 1
  , 0

  minScore: -> @reduce (score, card) ->
    score + if card.get 'revealed' then card.get 'value' else 0
  , 0

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    [@minScore(), @minScore() + 10 * @hasAce()]

  realScore: ->
    realScore = @scores()[1]
    if @scores()[1] > 21 then realScore = @scores()[0]
    realScore

  dealerPlay: ->
    console.log("Dealer plays now")
    @at(0).flip()
    console.log(@scores()[0])
    # scores = @realScore()[1]
    while @realScore() < 17
      @hit()
      # if @scores()[1] > 21 then scores = @scores()[0]
    @trigger 'dealerTurnEnd', @


