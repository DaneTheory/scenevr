dom = require("./vendor/dom-lite")
UUID = require("uuid")

Script = require("./elements/script")
Box = require("./elements/box")

document = dom.document
HTMLElement = dom.HTMLElement

document.markAsDead = (uuid) ->
  @deadNodes[uuid] = (new Date).valueOf()

document.createElement = (tag) ->
  if tag == "script"
    node = new Script
  else if tag == "box"
    node = new Box
  else
    node = new HTMLElement(tag)
  
  # Fixme - use less bits

  if node.reflect
    node.uuid = UUID.v4()
    @nodeMap[node.uuid] = node

  node.ownerDocument = this
  node.eventTargets = {}

  node

document.deadNodes = {}
document.nodeMap = {}

module.exports = document