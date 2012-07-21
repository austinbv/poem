chai = require('chai')
Word = require '../models/word'
sinon = require 'sinon'
chai.use require 'sinon-chai'
expect = chai.expect
EventEmitter = require('events').EventEmitter

events = new EventEmitter
describe 'Wordlist', ->
  afterEach ->
    sinon.mock.restore()

  it 'should exist', ->
    expect(Word).to.be.a 'function'

  describe '#constructor', ->
    it 'should throw if no word is provided in the hash', ->
      expect(-> new Word).to.throw(Error, /A word must be provided/)

  describe '.getWords', ->
    it 'should emit a "wordsFetched" fetched with words instances', (done) ->
      sinon.stub(Word._wordnik, 'randomWords').yields(null, [
                              {id: 1234, word: "hello"},
                              {id: 2345, word: "foo"},
                              {id: 3456, word: "goodbye"}
                            ]
                          )

      spy = sinon.spy()

      Word.getWords (result) -> spy(result); done()
  
      expect(spy).have.been.calledWith [
        {id: 1234, word: "hello"},
        {id: 2345, word: "foo"},
        {id: 3456, word: "goodbye"}
      ]
