Word = require '../../models/word'

routes = (app) ->
  app.get '/', (req, res) ->
    Word.getWords (result) ->
      res.render "#{__dirname}/views/index",
        layout: "#{__dirname}/views/layout"
        words: result.map (word) -> word.word


module.exports = routes
