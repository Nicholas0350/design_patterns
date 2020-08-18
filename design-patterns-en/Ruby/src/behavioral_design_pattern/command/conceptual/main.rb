# Command Design Pattern
#
# Intent: Turns request into stand-alone object that contains all
# information about request. 
# Parameterize methods with different requests, delay or queue request's execution &
# support undoable operations.

# Command interface declare & execute command
class Command
  # @abstract
  def execute
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end
end

# Simple operations command
class SimpleCommand < Command
  # @param [String] payload
  def initialize(payload)
    @payload = payload
  end

  def execute
    puts "SimpleCommand: See, I can do simple things like printing (#{@payload})"
  end
end

# Delegate receiver commands to other objects
class ComplexCommand < Command
  # Complex command constructor accept one/several receiver objects/context data
  def initialize(receiver, a, b)
    @receiver = receiver
    @a = a
    @b = b
  end

# Command delegate to receiver method
  def execute
    print 'ComplexCommand: Complex stuff done by receiver object'
    @receiver.do_something(@a)
    @receiver.do_something_else(@b)
  end
end

# Receiver class to perform/carry out collection of request operations
class Receiver
  # @param [String] a
  def do_something(a)
    print "\nReceiver: Working on (#{a}.)"
  end

  # @param [String] b
  def do_something_else(b)
    print "\nReceiver: Also working on (#{b}.)"
  end
end

# Invoker send request commands 
class Invoker
  # Initialize commands.

  # @param [Command] command
  def on_start=(command)
    @on_start = command
  end

  # @param [Command] command
  def on_finish=(command)
    @on_finish = command
  end
  
  # Invoker request command to a receiver passer
  def do_something_important
    puts 'Invoker: Does anybody want something done before I begin?'
    @on_start.execute if @on_start.is_a? Command

    puts 'Invoker: ...doing something really important...'

    puts 'Invoker: Does anybody want something done after I finish?'
    @on_finish.execute if @on_finish.is_a? Command
  end
end

# client parameterizing invoker with any commands.
invoker = Invoker.new
invoker.on_start = SimpleCommand.new('Say Hi!')
receiver = Receiver.new
invoker.on_finish = ComplexCommand.new(receiver, 'Send email', 'Save report')

invoker.do_something_important


Invoker: Does anybody want something done before I begin?
SimpleCommand: See, I can do simple things like printing (Say Hi!)

Invoker: ...doing something really important...
Invoker: Does anybody want something done after I finish?

ComplexCommand: Complex stuff done by receiver object

Receiver: Working on (Send email.)
Receiver: Also working on (Save report.)%
