@App.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.Response extends Backbone.Model

    urlRoot: ->
      "#{App.options.api}/surveys"

