# Decorator Design Pattern
#
# Intent: Attach new behaviors to objects by placing these objects
# Wrapper objects to attach/contain behaviors in other objects.

# The base Component interface defines operations that can be altered by
# decorators.
class Component
  # @return [String]
  def operation
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end
end

# Concrete Components provide default implementations of the operations. There
# might be several variations of these classes.
class ConcreteComponent < Component
  # @return [String]
  def operation
    'ConcreteComponent'
  end
end

# Decorator class follows same interface as other components
# Define wrapping interface for all concrete decorators
# default implementation of wrapping code might include a field for storing a wrapped component 
# and the means to initialize
class Decorator < Component
  attr_accessor :component

  # @param [Component] component
  def initialize(component)
    @component = component
  end

  # Delegates work to the wrapped component
  def operation
    @component.operation
  end
end

# Concrete Decorator calling wrapped object & altering result 
class ConcreteDecoratorA < Decorator
  # Decorators may call parent implementation of operation, instead of
  # calling wrapped object directly. Simplifies decorator class extension
  def operation
    "ConcreteDecoratorA(#{@component.operation})"
  end
end

# Execute behavior before/after wrapped object call
class ConcreteDecoratorB < Decorator
  # @return [String]
  def operation
    "ConcreteDecoratorB(#{@component.operation})"
  end
end

# Client code works with all objects using Component interface. 
# can stay independent of concrete classes of components it works with.
def client_code(component)
  # ...

  print "RESULT: #{component.operation}"

  # ...
end

# Client code can support both simple components...
simple = ConcreteComponent.new
puts 'Client: I\'ve got a simple component:'
client_code(simple)
puts "\n\n"

# ...as well as decorated ones.
#
# Note how decorators can wrap not only simple components but the other
# decorators as well.
decorator1 = ConcreteDecoratorA.new(simple)
decorator2 = ConcreteDecoratorB.new(decorator1)
puts 'Client: Now I\'ve got a decorated component:'
client_code(decorator2)
