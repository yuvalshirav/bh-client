@App.module "Survey.Views", (Views, App, Backbone, Marionette, $, _) ->

  class Views.Layout extends App.Views.Layout
    template: "survey/layout"
    className: "page-header"
    regions:
      primary: "#primary"

  class Views.MultipleChoiceQuestion extends App.Views.ItemView
    template: "survey/multiple-choice-question"
    tagName: "li"
    bindings:
      "input[name=answer]": "answer_id"

  class Views.Question extends App.Views.ItemView
    template: "survey/question"
    tagName: "li"
    bindings:
      "input[name=answer]": "answer_id"

  class Views.Survey extends App.Views.CompositeView
    template: "survey/survey"  
    childViewContainer: "ol"
    events:
      "click .js-submit": "onSubmit"
    modelEvents:
      "change:gender": "onUserUpdate"
    bindings:
      "input[name=gender]": "gender"

    getChildView: (model) ->
      if model.get('question_type') == "multiple"
        Views.MultipleChoiceQuestion
      else
        Views.Question

    onUserUpdate: ->
      @model.save() # TODO block submit until user is succussfully saved

    onSubmit: ->
      if @model.get("gender")
        response = new App.Entities.Response(user_id: @model.get("id"), response_answers: @collection)
        response.save()
        App.navigate("stats", true)
      else
        alert("Please select gender") # TODO use via requiredAttributes

  class Views.QuestionStat extends App.Views.ItemView
    template: "survey/stat"
    tagName: "li"

    topAnswerByGender: (gender_id) ->
      gender_id = "#{gender_id}"
      window.zz = @model.collection.stats.attributes
      answersCounts = _.pairs(@model.collection.stats.attributes[@model.get('id')]?[gender_id])
      sorted = answersCounts?.sort (a,b) ->
        b[1] - a[1]
      console.log sorted
      _.findWhere(@model.get('answers'), "id", parseInt(sorted[0][0],10))

    serializeData: ->
      _.extend @model.attributes,
        topFemale: @topAnswerByGender(0)
        topMale: @topAnswerByGender(1)

  class Views.Stats extends App.Views.CompositeView
    template: "survey/stats"
    childViewContainer: "ol"
    childView: Views.QuestionStat










