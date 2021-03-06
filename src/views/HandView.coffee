class window.HandView extends Backbone.View
  className: 'hand'

  template: _.template '<h2><% if(isDealer){ %>Dealer<% }else{ %>You<% } %> (<span class="score"></span>) <br/>
    <% if(!isDealer){ %><span>Money: <%= money %></span> <input type="text"></input><button class="submit">Bet</button></br>
      <span>Current Bet: <%= betAmount %></span><% } %></h2>'


  events:
    'click .submit': ->
      console.log('betting')
      if ($('input').val()>@collection.money) then alert "You don't have enough money"
      else
        @collection.bet($('input').val())
        @render()
        this.$el.find('.submit').hide()
        this.$el.find('input').hide()


  initialize: ->
    @collection.on 'add remove change', => @render()
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template @collection
    @$el.append @collection.map (card) ->
      new CardView(model: card).$el
    if (@collection.hasAce() && @collection.scores()[1] <= 21) then @$('.score').text (@collection.scores()[0] + '/' + @collection.scores()[1])
    else @$('.score').text @collection.scores()[0]

