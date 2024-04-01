package fallmon.states;

import fallmon.backend.*;
import fallmon.gameObjects.*;
import fallmon.gameObjects.gameplay.*;
import fallmon.gameObjects.userInterface.*;

class PlayState extends FlxState
{
	public static var uiHUD:ExplorationHUD;
	public static var combatLogs:CombatLog;
	public static var bgUI:Location;
	public static var debugInfo:DebugHUD;

	public static var showDebug:Bool = false;

	private var allUIs:Array<FlxCamera> = [];

	public static var health:Float = 35;
	public static var stamina:Float = 30;
	public static var pp:Float = 10;

	public static var radiation:Float = 0;

	public static var notificationTxt:FlxText;

	override public function create()
	{
		FlxG.camera.fade(FlxColor.BLACK, 0.2, true);

		bgUI = new Location();
		add(bgUI);

		uiHUD = new ExplorationHUD();
		add(uiHUD);

		combatLogs = new CombatLog();
		add(combatLogs);

		if (Main.devMode)
		{
			debugInfo = new DebugHUD();
			add(debugInfo);
		}

		Location.changeLocation('small-shack');

		var cornerText:FlxText = new FlxText(0, 0, 0, '${Main.gameVersion}\nUraniumEngine');
		cornerText.setFormat(8, FlxColor.WHITE, LEFT);
		cornerText.antialiasing = Init.globalAnti;
		add(cornerText);

		notificationTxt = new FlxText(0, 200, 0, '');
		notificationTxt.setFormat(AssetPaths.font('terminal.ttf'), 24, FlxColor.WHITE, CENTER);
		notificationTxt.antialiasing = Init.globalAnti;
		notificationTxt.alpha = 0;
		add(notificationTxt);

		combatStatus(false);

		Actions.actionPoints = Player.maxAP;

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

		notificationTxt.screenCenter(X);

		Player.recalculateStats(true);
		Player.radiation(radiation);

		if (health < 0)
			exitState('dead');

		if (radiation < 0)
			radiation = 0;

		if (health > Player.maxHealth)
			health = Player.maxHealth;

		if (stamina > Player.maxStamina)
			stamina = Player.maxStamina;

		if (pp > Player.maxPP)
			pp = Player.maxPP;

		if ((Player.strR <= 0) || (Player.perR <= 0) || (Player.endR <= 0) || (Player.chaR <= 0) || (Player.intR <= 0) || (Player.aglR <= 0) || (Player.lukR <= 0))
			healthCall(-99, true);

		if (!Actions.inCombat) {
			if (stamina < Player.maxStamina) stamina += (0.1 * (Player.hpPercent / 100));
			if (pp < Player.maxPP) pp += 0.005;
		}

		notificationTxt.alpha -= 0.01;
	}

	public static function showNotification(texxt:String = null, ?soundToPlay:String = null)
	{
		notificationTxt.text = texxt;
		notificationTxt.alpha = 1;

		if (soundToPlay != null)
			FlxG.sound.play(AssetPaths.sound('ui/$soundToPlay'));
	}

	public static function resetStats(?fromLevel:Bool = false)
	{
		Player.recalculateStats(fromLevel);

		health = Player.maxHealth;
		stamina = Player.maxStamina;
		pp = Player.maxPP;
	}

	public function devModeFunctions()
	{
		if (FlxG.keys.justPressed.F4)
			showDebug = !showDebug;

		if (FlxG.keys.justPressed.R)
			healthCall(-1, true);
		if (FlxG.keys.justPressed.T)
			healthCall(1, false);

		if (FlxG.keys.justPressed.Y)
			radiation += 50;
		if (FlxG.keys.justPressed.U)
			radiation -= 50;

		if (FlxG.keys.justPressed.G)
			Actions.inCombat = !Actions.inCombat;
	}

	public static function healthCall(hpNum:Int = 0, ?damage:Bool = false) {
		health += hpNum;
		if (damage) FlxG.camera.shake(0.02, 0.1);
	}

	public static function combatStatus(enter:Bool = true)
	{
		Actions.inCombat = enter;

		combatLogs.combatStatus(enter);

		if (enter) {}
		else {}
	}

	public function exitState(swapState:String)
	{
		trace('exiting playstate');
		// Delete objects
		remove(uiHUD);
		remove(bgUI);
		remove(combatLogs);
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
