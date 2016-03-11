@App.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.User extends Backbone.Model

    url: ->
      "#{App.options.api}/users"
