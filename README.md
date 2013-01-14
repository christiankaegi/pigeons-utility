Pigeons Utility
==============

A utility for intercommunication between shell and multiple modules in plain AS3. 
For PureMVC users who think that the pipes utility is a bit too complicated, this can be a nice alternative. 
The pigeons utility is not bound to a specific framework and can be used in any AS3 project.

### Dependencies:
- None

### Live Demo:
- [Pigeons Utility Demo Project](http://www.kaegi.net/pigeons-utility-demo)

### Source of the Demo Project:
- [Project Source here on GitHub](https://github.com/christiankaegi/pigeons-utility-demo-project)

### How to use (in the shell):
First, your base class (shell) must extend **PigeonShell** and implement **IPigeonShell**.  
Get an instance of the Pigeonry, then add the shell to it:
    
    var pigeonry:Pigeonry = Pigeonry.getInstance();
    pigeonry.addShell(this);

Now just wait and listen for incoming messages from the modules:

    override public function handlePigeonMessage(message:PigeonMessage):void 
    {
          // handle the message. It consists of 3 parts:
          // - message.getName()     (String)
          // - message.getBody()     (Object)
          // - message.getType()     (String)  
    }
    
### How to use (in a module):
Your module's base class must extend **PigeonModule** and implement **IPigeonModule**.  
Get an instance of the Pigeonry, then add the module to it: 

    var pigeonry:Pigeonry = Pigeonry.getInstance();
    pigeonry.addModule(this); 
    
You need to override 4 public methods of PigeonModule.

    override public function run(startupData:Object = null):void {
      // this will be called from the shell when the module is ready 
    }

    override public function handlePigeonMessage(message:PigeonMessage):void {
      // wait for incoming messages from the shell and/or other modules
    }
    
    override public function get moduleName():String {
        // return the name of your module. This is used in the Pigeonry.
    }

    override public function destroy():void {
        // clean up the module before it is removed. This is used in the Pigeonry.
    }
    
### Send messages

Like PureMVC notifications, a message consists of a name (String, required), body (Object, optional) and type (String, optional).  
The first parameter is an array of recipients. So you can send a message to more than one module at the same time.
    
Send a message to the shell:

    pigeonry.sendMessage([PigeonConstants.SHELL], PigeonConstants.MODULE_READY, "Hi shell, I'm ready!");
    
Send a message to a module:
    
    pigeonry.sendMessage(["redModule"], "dataLoaded", {data:data, message:"Hi module, your data is ready!"});
     
Send a message to multiple recipients:
    
    pigeonry.sendMessage(["videoPlayer", "controls"], YourConstants.PLAY);


    
    
    
                   
