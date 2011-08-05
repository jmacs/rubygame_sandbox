
module Game::Core

  class EntityFactory
    
    def create(name, px, py)
      Log.debug "Adding '{name}' at #{px},#{py}"
      actor = ScriptManager.actors["#{name.downcase}"]
      require "./game/entities/#{name.downcase}.rb"
      return Game::Entites.const_get(name).new px, py, actor
    end
    
  end

end