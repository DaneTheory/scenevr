HTMLElement = require("../lib/dom-lite").HTMLElement

class Script extends HTMLElement
  constructor: ->
    super "script"

# Script = ->
#   return new HTMLElement "script"
#
#   stuff: ->
#     "things"

module.exports = Script