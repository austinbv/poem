describe 'Words', ->
  it 'should be defined', ->
    expect(Words).not.to.be.undefined

  describe '#model', ->
    it 'should be a Word', ->
      words = new Words
      expect(words.model).to.equal(Word)
  describe '#url', ->
    it 'should map the url to /words', ->
      words = new Words
      expect(words.url).to.equal('/words')

