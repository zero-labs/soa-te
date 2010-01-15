require 'rubygems'
require 'uuidtools'

module UUIDNamer
  def uuid_name
    UUIDTools::UUID.random_create.to_s
  end
end