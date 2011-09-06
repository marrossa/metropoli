require 'sinatra'

module Metropoli
  class Api < Sinatra::Base
    include ConfigurationHelper
  
    get '/cities.json' do
      @cities = city_class.autocomplete(params[:q])
      @cities = @cities.merge(city_class.limit(autocomplete_limit))
      jsonify(@cities)
    end
  
    get '/states.json' do 
      @states = state_class.autocomplete(params[:q])
      @states = @states.merge(state_class.limit(autocomplete_limit))
      jsonify(@states)
    end
  
    get '/countries.json' do
      @countries = country_class.autocomplete(params[:q])
      @countries = @countries.merge(country_class.limit(autocomplete_limit))
      jsonify(@countries)
    end
  
    get '/cities_by_state.json' do
      @cities_by_state = city_class.by_state(params[:q])
      jsonify(@cities_by_state)
    end

    private
  
    def jsonify(resource_array)
      "[#{resource_array.all.map(&:metropoli_json).join(',').to_s}]"
    end
  
  end
end
