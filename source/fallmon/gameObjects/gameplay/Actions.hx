package fallmon.gameObjects.gameplay;

import fallmon.gameObjects.userInterface.ExplorationHUD;

class Actions
{
	public static var inCombat:Bool = false;
	public static var actionPoints:Int = 7;

	public static var playerTurn:Bool = true;

	public static var turnOrder:Int = 1;

	public static var numberOfPeople:Int = 1;

	public static function startTurn(?rested:Bool = false)
	{
		actionPoints = Player.maxAP;
		Player.ac = Player.defaultAC;

		playerTurn = true;

		if (PlayState.stamina < Player.maxStamina)
			PlayState.stamina += (rested ? 40 : 10);
		PlayState.pp += (Player.characterType == 'physic' ? 0.2 : 0.1);
	}

	public static function attackList()
	{
		if (inCombat) {}
		else
		{
			PlayState.showNotification('Not in combat...', 'nah');
		}
	}

	public static function playerInventory() {}

	public static function actionsList() {}

	public static function passTurn()
	{
		if (inCombat)
		{
			if (playerTurn)
				turnEnded(true, turnOrder);
		}
		else
		{
			PlayState.showNotification('Not in combat...', 'nah');
		}
	}

	public static function turnEnded(?playerGone:Bool = false, ?whoGoing:Int = 1)
	{
		playerTurn = false;
		FlxG.sound.play(AssetPaths.sound('ui/turnChange'));
		if (playerGone)
		{
			turnOrder = numberOfPeople;
			Player.ac += Std.int(actionPoints * (ExplorationHUD.stmPercent / 100)); // Just so you can't abuse this if you're tired
			actionPoints = 0;
		}
		else
		{
			turnOrder--;

			if (turnOrder < 1)
				startTurn();
		}

		if (turnOrder > 0)
		{
			new FlxTimer().start(0.7, function(fuckfuck:FlxTimer)
			{
				turnOrder--;
				turnEnded(false, turnOrder);
			});
		}
		else
			return;
	}
}
