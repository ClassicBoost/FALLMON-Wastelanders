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

	public static var characterName:String = 'PLAYER';

	// health
	public static var health:Float = 35;
	public static var maxHealth:Float = 35;

	// stamina
	public static var stamina:Float = 30;
	public static var maxStamina:Float = 30;

	// power points
	public static var pp:Float = 10;
	public static var maxPP:Float = 10;

	override public function create()
	{
		super.create();

		uiHUD = new ClassHUD();
		add(uiHUD);

		if (Main.devMode)
		{
			debugInfo = new DebugHUD();
			add(debugInfo);
		}
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

		if (health > maxHealth)
			health = maxHealth;
	}

	public static function resetStats(?fromLevel:Bool = false)
	{
		health = maxHealth;
		stamina = maxStamina;
		pp = maxPP;
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
