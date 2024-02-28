package fallmon.backend;

import fallmon.*;
import fallmon.backend.*;
import fallmon.states.menus.*;

class Init extends FlxState
{
	// bitch
	public static var globalAnti:Bool = true;

	override public function create():Void
	{
		super.create();

		loadSettings();
		Main.switchState(this, new MainMenuState());
	}

	public static function loadSettings():Void
	{
		if (FlxG.save.data.globalAntialiasing == null)
			FlxG.save.data.globalAntialiasing = globalAnti;

		globalAnti = FlxG.save.data.globalAntialiasing;
	}

	public static function saveSettings():Void
	{
		FlxG.save.flush();
		loadSettings();
	}
}
