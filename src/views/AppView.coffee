class window.AppView extends Backbone.View
  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button><button class="reset-button">Reset</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  templateLose: _.template '
    <button class="reset-button">Reset</button><span> you lose </span>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  templateWin: _.template '
    <button class="reset-button">Reset</button><span> you win </span>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  templateTie: _.template '
    <button class="reset-button">Reset</button><span> you tied </span>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    'click .hit-button': -> @model.get('playerHand').hit()
    'click .stand-button': -> @model.get('playerHand').stand()
    'click .reset-button': ->
      @model.initialize()
      @initialize()

  initialize: ->
    @render()
    that = @
    @model.on 'gameOver', ->
      that.renderLose()
    @model.on 'playerWon', ->
      that.renderWin()
    @model.on 'tie', ->
      that.renderTie()



  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

  renderLose: ->
    console.log('gameover?')
    @$el.children().detach()
    @$el.html @templateLose()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

  renderWin: ->
    console.log('gameover?')
    @$el.children().detach()
    @$el.html @templateWin()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

  renderTie: ->
    console.log('gameover?')
    @$el.children().detach()
    @$el.html @templateTie()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el
