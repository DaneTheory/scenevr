Element = require('../element')
Vector = require('../vector')
Euler = require('../euler')

xml = (e) ->
  s = new Element 'scene'
  s.appendChild(e)
  s.innerXML

describe 'constructor', ->
  it 'should create', ->
    e = new Element "box"
    expect(e instanceof Element).toBeTruthy()
    expect(e.nodeName).toEqual "box"

describe 'uuid', ->
  it 'should have uuid', ->
    e = new Element 'box'
    e.uuid = '1234-1234-1234-1234'
    expect(e.uuid).toMatch /^1234.+/
    expect(xml(e)).toMatch /<box uuid="1234.+/

describe 'position', ->
  it 'should get position', ->
    e = new Element "box"
    expect(e.position instanceof Vector).toBeTruthy()
    expect(e.position.z).toEqual(0)

  it 'should set position', ->
    e = new Element "box"
    e.position = new Vector(1,2,3)
    expect(e.position.z).toEqual(3)

  it 'should set by attribute', ->
    e = new Element "box"
    e.setAttribute 'position', '3 4 5'
    expect(e.position.toArray()).toEqual [3,4,5]

  it 'should try and parse', ->
    e = new Element "box"
    e.position = '3 4 5'
    expect(e.position.toArray()).toEqual [3,4,5]    

  it 'throw', ->
    e = new Element "box"
    expect(-> e.position = 'one two three').toThrow "Invalid argument"

  it 'should get xml', ->
    e = new Element 'box'
    e.position.y += 10
    expect(xml(e)).toMatch /<box position="0 10 0".+/ 

describe 'scale', ->
  it 'should get scale', ->
    e = new Element "box"
    expect(e.scale instanceof Vector).toBeTruthy()
    expect(e.scale.z).toEqual(1)

  it 'should set position', ->
    e = new Element "box"
    e.scale = new Vector(1,2,3)
    expect(e.scale.z).toEqual(3)

  it 'should set by attribute', ->
    e = new Element "box"
    e.setAttribute 'scale', '3 4 5'
    expect(e.scale.toArray()).toEqual [3,4,5]

  it 'should get xml', ->
    e = new Element 'box'
    e.scale.x += 10
    expect(xml(e)).toMatch /<box scale="11 1 1".+/ 

describe 'rotation', ->
  it 'should get rotation', ->
    e = new Element "box"
    expect(e.rotation instanceof Euler).toBeTruthy()
    expect(e.rotation.x).toEqual(0)

  it 'should set rotation', ->
    e = new Element "box"
    e.rotation = new Euler(0,Math.PI,0)
    expect(e.rotation.y).toEqual(Math.PI)

  it 'should set by attribute', ->
    e = new Element "box"
    e.setAttribute 'rotation', '0 1.001 2'
    expect(e.rotation.toArray()).toEqual [0,1.001,2]

  it 'should get xml', ->
    e = new Element 'box'
    e.rotation.y += 0.1
    expect(xml(e)).toMatch /<box rotation="0 0.1 0".+/ 

describe "attributes", ->
  it "should support string attributes", ->
    e = new Element "model"
    e.src = "//something"
    expect(e.src).toMatch /..something/
    expect(e.getAttribute("src")).toMatch /..something/
    expect(xml(e)).toMatch /src="..something"/
