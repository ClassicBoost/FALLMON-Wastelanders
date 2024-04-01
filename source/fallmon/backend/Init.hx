package fallmon.backend;

import fallmon.*;
import fallmon.backend.*;
import fallmon.states.menus.*;

class Init extends FlxState
{
	// bitch
	public static var globalAnti:Bool = true;
	public static var debugMode:Bool = false;

	override public function create():Void
	{
		super.create();

		loadSettings();
		Main.switchState(this, new MainMenuState());
	}

	public static function loadSettings():Void
	{
		if (FlxG.save.data.globalAntialiasing == null) FlxG.save.data.globalAntialiasing = globalAnti;

		if (FlxG.save.data.debugMode == null) FlxG.save.data.debugMode = debugMode;

		globalAnti = FlxG.save.data.globalAntialiasing;
		debugMode = FlxG.save.data.debugMode;

		if (FlxG.save.data.volume != null) FlxG.sound.volume = FlxG.save.data.volume;
		if (FlxG.save.data.mute != null) FlxG.sound.muted = FlxG.save.data.mute;
	}

	public static function saveSettings():Void
	{
		FlxG.save.flush();
		loadSettings();
	}
}
