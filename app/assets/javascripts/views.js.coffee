class WriteDownView extends Backbone.View
  initialize: ->
    @$form = @$('form')
    @$('textarea').bind('input propertychange', @keypressDetected)
    @hideSubmitbutton()

  events:
    "submit form": "submitForm"

  submitForm: (e) ->
    e.preventDefault()
    @doFormSubmission()

  doFormSubmission: ->
    $.ajax(
      url: @formUrl()
      type: @formMethod()
      success: @markdownSubmitted
      data: @$form.serialize()
    )

  markdownSubmitted: (body) =>
    console.log body
    @replacePreview(body)

  formUrl: ->
    @$form.attr 'action'

  formMethod: ->
    @$form.attr 'method'

  replacePreview: (body) ->
    @$('#display').html(body)

  keypressDetected: (e) =>
    console.log e
    @doFormSubmission()

  hideSubmitbutton: ->
    @$('#actions input').hide()



$ ->
  view = new WriteDownView({el: $(document)})
