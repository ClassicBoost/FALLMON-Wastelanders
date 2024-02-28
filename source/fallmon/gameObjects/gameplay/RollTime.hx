package fallmon.gameObjects.gameplay;

class RollTime
{
	public static var addThemUp:Int = 0;
	public static var rollGot:Int = 0;
	public static var advantageRoll:Int = 0;

	public static var isCrit:Bool = false;

	public static function resetRoll()
	{
		advantageRoll = 0;
		addThemUp = 0;
	}

	public static function roll(numberOfDice:Int = 1, maxNumber:Int = 20, ?type:String = '', ?advantage:String = '', ?targetNumber:Int = 0)
	{
		rollGot = FlxG.random.int(1, maxNumber);

		if (advantage == 'a' && rollGot > advantageRoll)
			advantageRoll = rollGot;
		else if (advantage == 'd' && rollGot < advantageRoll)
			advantageRoll = rollGot;
		else
			advantageRoll = rollGot;

		addThemUp += advantageRoll;

		if ((advantageRoll == 1 || advantageRoll == 20) && maxNumber == 20 && type == '')
			isCrit = true;
		else
			isCrit = false;

		if (addThemUp >= targetNumber || targetNumber == 0)
			succeed(isCrit);
		else
			fail(isCrit);
	}

	public static function succeed(crit:Bool = false) {}

	public static function fail(crit:Bool = false) {}
}
