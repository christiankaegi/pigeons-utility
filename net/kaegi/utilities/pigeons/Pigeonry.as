/*
 Copyright (c) Christian Kaegi, www.kaegi.net

 Permission is hereby granted, free of charge, to any person
 obtaining a copy of this software and associated documentation
 files (the "Software"), to deal in the Software without
 restriction, including without limitation the rights to use,
 copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the
 Software is furnished to do so, subject to the following
 conditions:

 The above copyright notice and this permission notice shall be
 included in all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 OTHER DEALINGS IN THE SOFTWARE.
 */

package net.kaegi.utilities.pigeons
{
public class Pigeonry
{
	private static var instance:Pigeonry;
	private static var allowInstantiation:Boolean;
	private static var _shell:PigeonShell;
	private static var modules:Vector.<PigeonModule>;

	public function Pigeonry()
	{
		if (!allowInstantiation)
		{
			throw new Error("Pigeonry is a singleton. Please use 'Pigeonry.getInstance()' instead of new");
		}
	}

	public static function getInstance():Pigeonry
	{
		if (instance == null)
		{
			allowInstantiation = true;
			instance = new Pigeonry();
			allowInstantiation = false;
			modules = new Vector.<PigeonModule>();
		}
		return instance;
	}

	/**
	 * Add shell (there can only be one)
	 */
	public function addShell(shell:PigeonShell):Boolean
	{
		if (_shell == null)
		{
			_shell = shell;
			return true;
		}
		throw new Error("Pigeonry.addShell(shell). There is already a shell registered. There can only be one.");
	}

	/**
	 * Add a module
	 */
	public function addModule(module:PigeonModule):Boolean
	{
		if (getModuleByName(module.moduleName) == null)
		{
			modules.push(module);
			return true;
		}
		return false;
	}

	/**
	 * Remove a module
	 */
	public function removeModule(module:PigeonModule):Boolean
	{
		var index:int = getModuleIndexByName(module.moduleName);
		if (index != -1)
		{
			modules[index].destroy();
			modules.splice(index, 1);
			return true;
		}
		return false;
	}

	/**
	 * Get all modules
	 */
	public function getAllModules():Vector.<PigeonModule>
	{
		return modules;
	}

	/**
	 * Send message to shell and/or module(s)
	 */
	public function sendMessage(recipients:Array, messageName:String, messageBody:Object = null, messageType:String = ""):void
	{
		var finalRecipients:Array = createFinalRecipientsList(recipients);
		var message:PigeonMessage = new PigeonMessage(messageName, messageBody, messageType);
		var i:uint = finalRecipients.length;
		while (i--)
		{
			sendMessageToModule(finalRecipients[i], message);
			if (finalRecipients[i] == PigeonConstants.SHELL && _shell != null) _shell.handlePigeonMessage(message);
		}
	}

	/**
	 * Get a module by its name
	 */
	public function getModuleByName(moduleName:String):PigeonModule
	{
		var i:uint = modules.length;
		while (i--)
		{
			if (modules[i].moduleName == moduleName)
			{
				return modules[i];
			}
		}
		return null;
	}

	/**
	 * @private
	 */
	private function getModuleIndexByName(moduleName:String):int
	{
		var index:int = -1;
		var i:uint = modules.length;
		while (i--)
		{
			if (modules[i].moduleName == moduleName)
			{
				index = i;
				break;
			}
		}
		return index;
	}

	/**
	 * @private
	 */
	private function createFinalRecipientsList(recipients:Array):Array
	{
		var finalRecipients:Array = [];
		var i:uint;
		if (recipients.toString().indexOf(PigeonConstants.ALL_MODULES) > -1)
		{
			// add all modules:
			for (i = 0; i < modules.length; i++)
			{
				finalRecipients[i] = modules[i].moduleName;
			}
		} else
		{
			// add selected modules
			for (i = 0; i < recipients.length; i++)
			{
				finalRecipients[i] = recipients[i];
			}
		}
		if (recipients.toString().indexOf(PigeonConstants.SHELL) > -1 && finalRecipients.toString().indexOf(PigeonConstants.SHELL) == -1)
		{
			// eventually add the shell
			finalRecipients.push(PigeonConstants.SHELL);
		}
		return finalRecipients;
	}

	/**
	 * @private
	 */
	private function sendMessageToModule(moduleName:String, message:PigeonMessage):void
	{
		var i:uint = modules.length;
		while (i--)
		{
			if (modules[i].moduleName == moduleName)
			{
				modules[i].handlePigeonMessage(message);
			}
		}
	}
}
}
