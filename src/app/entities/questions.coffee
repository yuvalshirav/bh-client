@App.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.Questions extends Backbone.Collection

    model: Entities.Question
    comparator: "position"

    url: ->
      "#{App.options.api}/questions"
