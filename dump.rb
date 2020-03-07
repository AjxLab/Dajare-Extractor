Bundler.require
require './model'
require 'json'


$model = Model.new(YAML.load_file('config/db.yml')['file'])

data = []
$model.jokes.all.each do |joke|
  data << {}
  data[-1] = {
    'joke' => joke.joke,
    'score' => joke.score,
    'author' => joke.author,
    'is_joke' => true
  }
end

open('jokes.json', 'w') do |io|
  JSON.dump(data, io)
end
