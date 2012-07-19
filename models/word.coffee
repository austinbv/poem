util = require 'util'
EventEmitter = require('events').EventEmitter
Wordnik = require 'wordnik'
API_KEY = require '../api_key'
wordnik = new Wordnik api_key: API_KEY

class Word extends EventEmitter
  constructor: (options) ->
    throw new Error "A word must be provided" unless options?.word
    @word = options.word

  @getWords: ->
    @_wordnik.randomWords (e, result) =>
      Word.emit 'wordsFetched', result
 
  @_wordnik: wordnik

  @_parseResponse: (e, result) ->
    return result.map (wordnikWord) ->
      new Word word: wordnikWord.word

Word.__proto__ = EventEmitter.prototype
module.exports = Word
