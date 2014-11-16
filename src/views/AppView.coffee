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
    'click .hit-button': ->
      @model.get('playerHand').hit()
      this.$el.find('.submit').hide()
      this.$el.find('input').hide()
    'click .stand-button': ->
      @model.get('playerHand').stand()
      this.$el.find('.submit').hide()
      this.$el.find('input').hide()
    'click .reset-button': ->
      # @model.initialize()
      # @initialize()
      @renderReset()
      this.$el.find('button.hit-button').hide()
      this.$el.find('button.stand-button').hide()
    # 'afterRender': ->@model.blackjack()

  initialize: ->
    @render()
    that = @
    that.$el.find('button.hit-button').hide()
    that.$el.find('button.stand-button').hide()
    @model.on 'gameOver', ->
      that.renderLose()
    @model.on 'playerWon', ->
      that.renderWin()
    @model.on 'tie', ->
      that.renderTie()
    @model.on 'blackjack', ->
      that.renderBlackjack()
      console.log("triggered")
    @model.on 'betMade', ->
      that.$el.find('button.hit-button').show()
      that.$el.find('button.stand-button').show()
      console.log("hit and stand revealed")
    #playerH = @model.get 'playerHand'
    #if (playerH.realScore() == 21)
      #@renderBlackjack()
      #console.log("triggered")
    return



  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

  renderReset: ->
    @$el.children().detach()
    @$el.html @template()
    money = @model.get('playerHand').money
    console.log('money')
    console.log(money)
    player = new Hand [@model.get('deck').pop().flip(), @model.get('deck').pop().flip()], @model.get('deck'), false, money, 0
    dealer = new Hand [@model.get('deck').pop().flip(), @model.get('deck').pop().flip()], @model.get('deck'), true
    #@model.set('playerHand', player)
    #@model.set('dealerHand', dealer)
    @model.reset(player, dealer)
    @$('.player-hand-container').html new HandView(collection: player).el
    @$('.dealer-hand-container').html new HandView(collection: dealer).el

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
