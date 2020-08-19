class CommandInterface 
  # execution method
 def execute
 end

end 
 

extract requests_into_command_classes_that_implement_command_interface

# Each class must have a set of 

class CommandConstructor
  def initialize 
  end

  def fields_for(storing_request_arguments_reference_to_actual_receiver_object) 
  end

end
    

class IdentifyClass 
  
  def sender
  end

  def fields_for(storing_request_arguments_reference_to_actual_receiver_object) 
  end

end 
  
Add fields for storing commands into these classes. 


class CommandInterface
  
Senders communicating with their commands only via   
Senders usually don’t create command objects on their own, but rather get them from the client code.
end


Change senders to execute command instead of sending request to receiver directly.

 def client 
  initialize  
  Createreceivers
  Create commands 
  associate them with receivers if needed
 end 

 
Create senders
associate them with specific commands
