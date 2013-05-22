# -*- encoding : utf-8 -*-

require_relative '../lib/module/cluster.rb'

describe ::Module::Cluster do

  class ::Class
    extend ::Module::Cluster
    cluster( :class_instance_spec ).subclass { |subclass| puts 'here' }
  end
  
  it 'should work' do
    class OtherClass
    end
    ::Class.new
  end
  
end
