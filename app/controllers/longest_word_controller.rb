require 'open-uri'

class LongestWordController < ApplicationController

  def game
    @timestamp = Time.now
    @word_array = []
    10.times do
      @word_array.push(("A".."Z").to_a.sample)
    end
  end

  def score
    @start_time = params[:timestamp]
    @end_time = params[:endTime]
    @letters = params[:word]
    @result = params[:query].split("")
    @score = 0

    url = "https://wagon-dictionary.herokuapp.com/#{params[:query]}"
    word_check = open(url).read
    @word_json = JSON.parse(word_check)

    if  @word_json["found"]
      @result.each do |letter|
        if (@result.count(letter) == @letters.count(letter.upcase))
          @score = @result.length * (10 - (Time.parse(@end_time) - Time.parse(@start_time)))
        end
      end
    end
  end

end

