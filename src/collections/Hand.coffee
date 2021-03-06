class window.Hand extends Backbone.Collection
  model: Card


  initialize: (array, @deck, @isDealer) ->

  hit: ->
    @add(@deck.pop())
    @last()

  stand: -> 
    #We want to make it the dealer's turn. We cannot hit() anymore, too. 
    @models[0].flip()
    if @scores()[0] < 17 or @scores()[1] < 17 then @hit()
    

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

