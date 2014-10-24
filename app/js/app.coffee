document.addEventListener 'DOMContentLoaded', ->
  requiredFields = document.querySelectorAll('[required]')
  button = document.querySelector('.button')

  button.addEventListener 'click', (ev) ->
    for field in requiredFields
      if field.value is ''
        ev.preventDefault()
        field.style.backgroundColor = 'rgb(255, 155, 155)'
