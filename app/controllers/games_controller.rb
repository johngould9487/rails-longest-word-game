require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = []
    9.times do
      @letters << ('a'..'z').to_a.sample
    end
  end

  def populate

  end

  def score
    @found = valid_english_word?(params[:guess])
    grid = params[:letters].split(' ')
    @in_grid = word_in_grid?(params[:guess], grid)
    @score = params[:guess].length
  end

  def valid_english_word?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    word_serialized = open(url).read
    word = JSON.parse(word_serialized)
    word['found']
  end

  def word_in_grid?(word, grid)
    word.chars.all? do |letter|
      if grid.index(letter)
        grid.delete_at(grid.index(letter))
        true
      else
        false
      end
    end
  end
end
