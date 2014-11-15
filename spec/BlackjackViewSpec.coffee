assert = chai.assert

describe 'deck', ->
  deck = null
  hand = null

  beforeEach ->
    # deck = new Deck()




  describe 'tie', ->
    it 'should result in a tie game', ->
      app = new App()
      card1 = new Card
        rank: 6
        suite: 1
      card2 = new Card
        rank: 6
        suite: 1
      card3 = new Card
        rank: 6
        suite: 2
      card4 = new Card
        rank: 6
        suite: 2
      hand = new Hand [card1, card2], @
      dealer = new Hand [card3, card4], @, true
      app.set 'playerHand', hand
      app.set 'dealerHand', dealer
      dealer.trigger 'dealerTurnEnd', dealer
      # assert.strictEqual dealer.realScore(), hand.realScore()
      expect(app.trigger).to.have.been.calledWith('tie', app)
