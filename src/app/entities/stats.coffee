@App.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.Stats extends Backbone.Model

    urlRoot: ->
      "#{App.options.api}/stats"
