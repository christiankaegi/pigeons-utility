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
import flash.display.Sprite;

public class PigeonModule extends Sprite implements IPigeonModule
{
	public function PigeonModule()
	{
	}

	/**
	 * run module
	 * @param startupData
	 */
	public function run(startupData:Object = null):void
	{
	}

	/**
	 * get Module Name
	 */
	public function get moduleName():String
	{
		return "";
	}

	/**
	 * Destroy the module
	 */
	public function destroy():void
	{
	}

	/**
	 * handle Pigeon Message
	 */
	public function handlePigeonMessage(message:PigeonMessage):void
	{
	}
}
}
