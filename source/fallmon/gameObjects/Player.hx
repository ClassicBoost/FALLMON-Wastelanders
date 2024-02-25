package fallmon.gameObjects;

class Player
{
	public static var str:Int = 5;
	public static var per:Int = 5;
	public static var end:Int = 5;
	public static var cha:Int = 5;
	public static var int:Int = 5;
	public static var agl:Int = 5;
	public static var luk:Int = 5;

	public static var strR:Int = 5;
	public static var perR:Int = 5;
	public static var endR:Int = 5;
	public static var chaR:Int = 5;
	public static var intR:Int = 5;
	public static var aglR:Int = 5;
	public static var lukR:Int = 5;

	public static var characterName:String = 'PLAYER';

	public static var maxHealth:Float = 35;
	public static var maxStamina:Float = 30;
	public static var maxPP:Float = 10;

	public static var moveLimit:Int = 4;

	public static var maxAP:Int = 7;

	public static function recalculateStats(?reset:Bool = false)
	{
		if (reset)
		{
			strR = str;
			perR = per;
			endR = end;
			chaR = cha;
			intR = int;
			aglR = agl;
			lukR = luk;
		}
		maxHealth = (20 + (endR * 2) + (strR));
		maxStamina = (aglR * 10);
		maxPP = (strR * 2);

		moveLimit = (intR > 4 ? 3 : intR == 7 ? 5 : intR == 8 ? 6 : intR == 9 ? 7 : intR == 10 ? 8 : 4);

		maxAP = Std.int(5 + (aglR / 2));
	}

	public static function radiation(rad:Float)
	{
		if (rad >= 150)
		{
			strR = str - 1;

			if (rad >= 300)
			{
				endR = end - 2;
				aglR = agl - 1;
			}
			if (rad >= 450)
			{
				endR = end - 3;
				aglR = agl - 2;
				strR = str - 2;
			}
			if (rad >= 600)
			{
				endR = end - 5;
				aglR = agl - 4;
				strR = str - 4;
				perR = per - 1;
				chaR = cha - 1;
				intR = int - 1;
			}
			if (rad >= 1000)
			{
				endR = end - 6;
				aglR = agl - 5;
				strR = str - 5;
				perR = per - 3;
				chaR = cha - 3;
				intR = int - 3;
			}
		}
		else
		{
			endR = end;
			aglR = agl;
			strR = str;
			perR = per;
			chaR = cha;
			intR = int;
		}
	}
}
