class window.App extends Backbone.Model
  initialize: ->
    @set 'game', game = new Game()