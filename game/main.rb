GAME_ROOT = File.expand_path('..', File.dirname(__FILE__))

# load required gems
require "rubygems"
require "bundler/setup"
Bundler.require

# add the root directory to the load path
$:.unshift GAME_ROOT

module Game
  class << self
    def run      
      view_manager = Game::Core::ViewManager.new
      catch(:quit) do
        loop do
          view_manager.tick
        end
      end
      Rubygame.quit
    end
  end
end

Dir["#{GAME_ROOT}/game/core/*.rb"].each { |f| require f }