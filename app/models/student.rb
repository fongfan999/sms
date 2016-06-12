class Student < ActiveRecord::Base
  belongs_to :klass

  def id_code
  	length = id.to_s.length
  	tail = "0"*4
  	tail.slice!("0"*length)
  	"1452#{tail}#{id}"
  end
end
