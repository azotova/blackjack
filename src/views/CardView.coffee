class window.CardView extends Backbone.View
  className: 'card'

  #template: _.template '<img src="<%= rankName %> + '-' + <%= suitName %> + '.png">'

  #imageName = 'img/cards/' + @model.get('rankName') + '-' + @model.get('suitName') + '.png'

  console.log("mod", @model)

  #imageName: @model.get(rankName)

  #template: _.template '<img src=imageName>'

  initialize: -> @render()

  render: ->
    @$el.children().detach()
    imageName = 'img/cards/' + @model.get('rankName') + '-' + @model.get('suitName') + '.png'
    #console.log imageName
    imageHTML = '<img src=' + imageName + '>'
    #@$el.html @template @model.attributes
    @$el.html imageHTML
    @$el.addClass 'covered' unless @model.get 'revealed'

