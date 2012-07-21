util = require 'util'
Wordnik = require 'wordnik'
API_KEY = require '../api_key'
wordnik = new Wordnik api_key: API_KEY

class Word
  constructor: (options) ->
    throw new Error "A word must be provided" unless options?.word
    @word = options.word

  @getWords: (callback) ->
    @_wordnik.randomWords (e, result) =>
      throw e if e
      callback(result)
 
  @_wordnik: wordnik

  @_parseResponse: (e, result) ->
    return result.map (wordnikWord) ->
      new Word word: wordnikWord.word

module.exports = Word
