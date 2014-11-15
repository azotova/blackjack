class window.AppView extends Backbone.View
  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <button class="reset-button">Reset</button>
    <span class = "message"></span>
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

  templateBlackjack: _.template '
    <button class="reset-button">Reset</button><span> you got a blackjack! </span>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    'click .hit-button': -> @model.get('playerHand').hit()
    'click .stand-button': -> @model.get('playerHand').stand()
    'click .reset-button': ->
      @model.initialize()
      @initialize()
    # 'afterRender': ->@model.blackjack()

  initialize: ->
    @render()
    # jackState = true;
    that = @
    @model.on 'gameOver', ->
      that.renderLose()
    @model.on 'playerWon', ->
      that.renderWin()
    @model.on 'tie', ->
      that.renderTie()
    # @model.on 'blackjack', ->
    #   if (!jackState)
    #     that.renderBlackjack()
    #     jackState = true;
    #     return
    @afterRender()
    return



  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

  afterRender: ->
    playerH = @model.get 'playerHand'
    if (playerH.realScore() == 21)
      @renderBlackjack()
      console.log("triggered")
    return

  renderLose: ->
    console.log('loss?')
    @$el.children().detach()
    @$el.html @templateLose()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

  renderWin: ->
    console.log('win?')
    @$el.children().detach()
    @$el.html @templateWin()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

  renderTie: ->
    console.log('tie?')
    @$el.children().detach()
    @$el.html @templateTie()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

  renderBlackjack: ->
      console.log('blackjack!')
      this.$el.find('span.message').html("You got a blackjack!")
      this.$el.find('button.hit-button').hide()
      this.$el.find('button.stand-button').hide()
      #debugger;
      #@$el.children().detach()
      #@$el.html @templateBlackjack()
      #@$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
      #@$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el
