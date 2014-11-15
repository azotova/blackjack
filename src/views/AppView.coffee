class window.AppView extends Backbone.View
  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button><button class="reset-button">Reset</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  templateEnd: _.template '
    <button class="reset-button">Reset</button><span> you lose </span>
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
      # console.log('heard')
      that.renderEnd()
      # @initialize()
    # return


  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

  renderEnd: ->
    console.log('gameover?')
    @$el.children().detach()
    # $('body').append('you lose')
    @$el.html @templateEnd()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el
