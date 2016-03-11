@App.module "Survey", (Survey, App, Backbone, Marionette, $, _) ->
    
  class Survey.Controller extends App.Controllers.Application

    initialize: ->
      layout = new Survey.Views.Layout()
      @show(layout)

    takeSurvey: ({model, collection}) ->
      @getMainView().showChildView("primary", new Survey.Views.Survey(model: model, collection: collection))

    showStats: ({collection}) ->
      @getMainView().showChildView("primary", new Survey.Views.Stats(collection: collection))
      
  class Survey.Router extends Marionette.AppRouter

    appRoutes:
      "survey": "survey"
      "stats": "stats"

  questionCollection = null
  getQuestions = ->
    if questionCollection
      $.Deferred().resolve(questionCollection)
    else
      questionCollection = new App.Entities.Questions()
      questionCollection.fetch().then -> questionCollection

  API =
    survey: ->
      @controller ||= new Survey.Controller()
      getQuestions().then (questions) =>
        @controller.takeSurvey(model: new App.Entities.User(), collection: questions)

    stats: ->
      @controller ||= new Survey.Controller()
      getQuestions().then (questions) =>
        questions.stats = new App.Entities.Stats()
        questions.stats.fetch().then =>
          @controller.showStats(collection: questions)      

  Survey.on "start", ->
    new Survey.Router
      controller: API
