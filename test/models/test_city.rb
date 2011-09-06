require 'helper'

class TestCity < ActiveSupport::TestCase
  
  def setup
    mty = Factory(:city)
    sgo = Factory(:city, :name => 'Santiago')
  end
  
  test 'like method should find cities by name' do
    assert_equal Metropoli::CityModel.like('Monterrey').count, 1
  end
  
  test 'like method should find cities with %' do
    assert_equal Metropoli::CityModel.like('mo').count, 1
  end
  
  test 'like method should return all cities with blank' do
    assert_equal Metropoli::CityModel.like('').count, Metropoli::CityModel.count
  end
  
  test 'like method should return all cities with nil' do
    assert_equal Metropoli::CityModel.like(nil).count, Metropoli::CityModel.count
  end
  
  test 'autocomplete method should find cities with state and country or without them' do
    assert_equal Metropoli::CityModel.autocomplete('Monterrey, NLE').count, 1
    assert_equal Metropoli::CityModel.autocomplete('Monterrey, NLE, MX').count, 1
    assert_equal Metropoli::CityModel.autocomplete('Monterrey').count, 1
  end
  
  test 'autocomplete method should find cities with state and country with full names' do
    assert_equal Metropoli::CityModel.autocomplete('Monterrey, Nuevo Leon').count, 1
    assert_equal Metropoli::CityModel.autocomplete('Monterrey, Nuevo Leon, Mexico').count, 1
    assert_equal Metropoli::CityModel.autocomplete('Monterrey').count, 1
  end
  
  test 'autocomplete method should scope city with the provided state or country' do
    assert_equal Metropoli::CityModel.autocomplete('Monterrey, NT').count, 0
    assert_equal Metropoli::CityModel.autocomplete('Monterrey, NLE, BO').count, 0
  end
  
  test 'autocomplete method should return all cities with blank' do
    assert_equal Metropoli::CityModel.like('').count, Metropoli::CityModel.count
  end
  
  test 'autocomplete method should return all cities with nil' do
    assert_equal Metropoli::CityModel.like(nil).count, Metropoli::CityModel.count
  end
  
  test 'get_by_states method should return all the cities from a specific state' do
    san_pedro = Factory(:city, :name => "San Pedro")
    torreon = Factory(:city, :name => "Torreon", :state => Factory(:state, :name => "Coahuila", :abbr => "COA"))
    assert_equal Metropoli::CityModel.by_state("Nuevo Leon").count, 3
    assert_equal Metropoli::CityModel.by_state("Coahuila").count, 1
  end

  test 'get_by_states method should return not return results if there is not a given state' do
    assert_equal Metropoli::CityModel.by_state(nil), nil
  end 

  test 'get_by_states method should return not return results if the state is invalid' do
    assert_equal Metropoli::CityModel.by_state("NL").count, 0
  end 

end
