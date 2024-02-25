package fallmon.states;

import fallmon.backend.*;
import fallmon.gameObjects.*;
import fallmon.gameObjects.userInterface.*;

class PlayState extends FlxState
{
	public static var uiHUD:ClassHUD;
	public static var debugInfo:DebugHUD;

	public static var showDebug:Bool = false;

	private var allUIs:Array<FlxCamera> = [];

	public static var health:Float = 35;
	public static var stamina:Float = 30;
	public static var pp:Float = 10;

	public static var radiation:Float = 0;

	override public function create()
	{
		FlxG.camera.fade(FlxColor.BLACK, 0.2, true);

		uiHUD = new ClassHUD();
		add(uiHUD);

		if (Main.devMode)
		{
			debugInfo = new DebugHUD();
			add(debugInfo);
		}

		super.create();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (Main.devMode)
		{
			devModeFunctions();

			if (showDebug)
				debugInfo.visible = true;
			else
				debugInfo.visible = false;
		}

		if (health < 0)
			exitState('dead');

		if (health > Player.maxHealth)
			health = Player.maxHealth;
	}

	public static function resetStats(?fromLevel:Bool = false)
	{
		Player.recalculateStats(!fromLevel);

		health = Player.maxHealth;
		stamina = Player.maxStamina;
		pp = Player.maxPP;
	}

	public function devModeFunctions()
	{
		if (FlxG.keys.justPressed.F4)
			showDebug = !showDebug;

		if (FlxG.keys.justPressed.R)
			health--;
		if (FlxG.keys.justPressed.T)
			health++;
	}

	public function exitState(swapState:String)
	{
		trace('exiting playstate');
		// Delete objects

		// Then swap state
		switch (swapState)
		{
			case 'dead':
				Main.switchState(this, new DeadState());
			default:
				Main.switchState(this, new PlayState());
		}
	}
}
