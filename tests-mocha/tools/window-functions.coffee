_ = require('underscore')
async = require('async')
fs = require('fs')
path = require('path')
chai = require('chai')
expect = chai.expect
chaiStats = require('chai-stats')
chai.use(chaiStats)

AudioKit = require('../../dist/audiokit')

DECIMALS = 5

testAgainstFile = (buffer, filename, done) -> 
  buffer = _.toArray(buffer)
  filepath = path.normalize(path.join(__dirname, '../dsp-test-files/test-files', filename))
  fs.readFile filepath, (err, data) ->
    throw(err) if (err)
    data = JSON.parse(data.toString())
    filepath;debugger
    expect(buffer).almost.eql(data, DECIMALS)
    done()

describe "Tools.WindowFunctions", ->

  describe ".Bartlett()", ->
    it "should return correct results", (done) ->
      buffer = new Float32Array(1024)
      AudioKit.Tools.WindowFunctions.Bartlett(buffer)
      testAgainstFile(buffer, "window-functions/bartlett-window.json", done)

  describe ".BartlettHann()", ->
    it "should return correct results", (done) ->
      buffer = new Float32Array(1024)
      AudioKit.Tools.WindowFunctions.BartlettHann(buffer)
      testAgainstFile(buffer, "window-functions/bartlett-hann-window.json", done)

  describe ".Blackman()", ->
    it "should return correct results", (done) ->
      buffer = new Float32Array(1024)
      AudioKit.Tools.WindowFunctions.Blackman(buffer)
      testAgainstFile(buffer, "window-functions/blackman-window.json", done)

  describe ".Cosine()", ->
    it "should return correct results", (done) ->
      buffer = new Float32Array(1024)
      AudioKit.Tools.WindowFunctions.Cosine(buffer)
      testAgainstFile(buffer, "window-functions/cosine-window.json", done)

  describe ".Gauss()", ->
    it "should return correct results", (done) ->
      async.series([
        (next) ->
          buffer = new Float32Array(1024)
          AudioKit.Tools.WindowFunctions.Gauss(buffer, 0.5)
          testAgainstFile(buffer, "window-functions/gaussian-window-sigma-0.5.json", next)
        (next) ->
          buffer = new Float32Array(1024)
          AudioKit.Tools.WindowFunctions.Gauss(buffer, 0.25)
          testAgainstFile(buffer, "window-functions/gaussian-window-sigma-0.25.json", next)
        (next) ->
          buffer = new Float32Array(1024)
          AudioKit.Tools.WindowFunctions.Gauss(buffer, 0.9999)
          testAgainstFile(buffer, "window-functions/gaussian-window-sigma-0.9999.json", done)
      ])


  describe ".Hamming()", ->
    it "should return correct results", (done) ->
      buffer = new Float32Array(1024)
      AudioKit.Tools.WindowFunctions.Hamming(buffer)
      testAgainstFile(buffer, "window-functions/hamming-window.json", done)

  describe ".Hann()", ->
    it "should return correct results", (done) ->
      buffer = new Float32Array(1024)
      AudioKit.Tools.WindowFunctions.Hann(buffer)
      testAgainstFile(buffer, "window-functions/hann-window.json", done)

  describe ".Lanczos()", ->
    it "should return correct results", (done) ->
      buffer = new Float32Array(1024)
      AudioKit.Tools.WindowFunctions.Lanczos(buffer)
      testAgainstFile(buffer, "window-functions/lanczos-window.json", done)

  describe ".Rectangular()", ->
    it "should return correct results", (done) ->
      buffer = new Float32Array(1024)
      AudioKit.Tools.WindowFunctions.Rectangular(buffer)
      testAgainstFile(buffer, "window-functions/rectangular-window.json", done)

  describe ".Triangular()", ->
    it "should return correct results", (done) ->
      buffer = new Float32Array(1024)
      AudioKit.Tools.WindowFunctions.Triangular(buffer)
      testAgainstFile(buffer, "window-functions/triangular-window.json", done)
