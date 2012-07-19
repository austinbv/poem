Word = require '../../models/word'

routes = (app) ->
  app.get '/', (req, res) ->
    Word.once 'wordsFetched', (params) ->
      res.render "#{__dirname}/views/index",
        words: params.map (word) -> word.word

    Word.getWords()


module.exports = routes
