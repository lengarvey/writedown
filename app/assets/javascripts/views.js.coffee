class WriteDownView extends Backbone.View
  initialize: ->
    @$form = @$('form')
    @$('#entry').bind('scroll', @scrollEntry)
    @hideSubmitbutton()
    @swapTextareas()
    @_throttledUpdateTextArea = _.throttle(@updateTextarea, 500)
    @$('.fake-text-area').bind('input', @_throttledUpdateTextArea)

  events:
    "submit form": "submitForm"
    # "input .fake-text-area": "updateTextarea"

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
    @replacePreview(body)

  formUrl: ->
    @$form.attr 'action'

  formMethod: ->
    @$form.attr 'method'

  replacePreview: (body) ->
    @$('#display').html(body)

  keypressDetected: (e) =>
    @doFormSubmission()

  hideSubmitbutton: ->
    @$('#actions').hide()

  getElemTopBottomPaddingPixels: ($elem) ->
    top = parseInt($elem.css('padding-top'))
    bottom = parseInt($elem.css('padding-bottom'))
    top + bottom


  scrollEntry: (e) =>
    $elem = $(e.target)
    height_of_entry = $elem.find('.fake-text-area').height()
    height_of_window = $(window).height()
    percent = $elem.scrollTop() / (height_of_entry - height_of_window)
    $targetElem = @$('#display')
    scroll_amount = ($targetElem.find('#display-container').height() - height_of_window) * percent
    $targetElem.scrollTop(scroll_amount)

  swapTextareas: ->
    @$('textarea').hide()
    @$('.fake-text-area').show()

  sanitizeEntryText: (text) ->
    text.replace(/<div>/g, ->
      ''
    ).replace(/<\/div>/g, ->
      '\r\n'
    ).replace(/&nbsp;/g, ->
      ' '
    ).replace(/<br>/g, ->
      ''
    ).replace(/&gt;/g, ->
      '>'
    ).replace(/&lt;/g, ->
      '<'
    ).replace(/&amp;/g, ->
      '&'
    )

  updateTextarea: =>
    console.log "doing it slow"
    @$('textarea').val(@sanitizeEntryText(@$('.fake-text-area').html()))
    @doFormSubmission()




$ ->
  WriteDown.Views.writeDownView = new WriteDownView({el: $(document)})
