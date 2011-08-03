require "./game/bootstrap"
require "./game/core/scene_manager_factory.rb"

include Game::Core

module Game

  class Main
   
    def initialize
      require "./game/core/log.rb"
      Game::Core::Log.configure
      @scene_manager = SceneManagerFactory.create
    end
  
    def run
        catch(:quit) do
          loop do
            @scene_manager.tick
          end
        end
        Rubygame.quit()
    end
      
  end

end