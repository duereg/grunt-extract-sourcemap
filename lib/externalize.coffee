# Gratefully stolen from https://gist.github.com/pmuellr/5143384
path = require "path"

translateSources = (sources, grunt) ->
  newSources = []

  for sourcePath in sources
    sourcePath = path.relative("", sourcePath)
    newSources.push sourcePath

  newSources

module.exports = ({filepath, source, grunt, dest}) ->
  mapFilepath = "#{filepath}.map"
  mapFilename = path.basename mapFilepath
  sourceFilename = path.basename filepath
  sourceOutput = path.join(dest, sourceFilename)
  mapOutput = path.join(dest, mapFilename)

  match = source.match /\/\/@ sourceMappingURL=data:application\/json;base64,(.*)\n/
  grunt.log.writeln "found sourcemap in #{filepath}: #{match?}" unless match?
  return false unless match?

  data64 = match[1]
  data = new Buffer(data64, "base64").toString()
  data = JSON.parse(data)
  data.file = sourceFilename
  data.sources = translateSources(data.sources, grunt)
  data = JSON.stringify data, null, 4

  source = source.replace /\/\/@ sourceMappingURL=data:application\/json;base64,(.*)\n/, "//@ sourceMappingURL=#{mapFilename}\n"

  grunt.file.write sourceOutput, source
  grunt.file.write mapOutput, data

  grunt.log.writeln "re-wrote data-url sourcemap in #{filepath} to #{sourceOutput} and #{mapOutput}"
  true