module KlassesHelper
  def max_students?(klass)
    max_students = Rule.find(1).max_quantity
    klass.students.count == max_students
  end
end
