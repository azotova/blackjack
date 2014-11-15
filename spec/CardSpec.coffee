assert = chai.assert

describe "deck constructor", ->

  it "should create a card collection", ->
    collection = new Deck()
    assert.strictEqual collection.length, 52

  it "should flip on flip()", ->
    card = new Card
      rank: 4
      suit: 1
    console.log(card)
    card.flip()
    assert.strictEqual card.get('revealed'), false
