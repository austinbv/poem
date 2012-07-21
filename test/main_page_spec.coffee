Browser = require 'zombie'
expect = require('chai').expect
app = require '../server'
sinon = require 'sinon'
Word = require '../models/word'

describe 'the main page', ->
  beforeEach (done) ->
    @stub = sinon.stub(Word._wordnik, 'randomWords').yields null, [ id: 1234, word: "hello" ]

    @browser = new Browser
    @browser.visit('http://localhost:3001/').then done, done

  afterEach ->
    @stub.restore()

  it 'should exist', ->
    expect(@browser.statusCode).to.equal 200

  it 'should have the words that were feteched', ->
    expect(@browser.text '.magnets' ).to.equal 'hello'
