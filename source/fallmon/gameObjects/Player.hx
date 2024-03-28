package fallmon.gameObjects;

typedef SpeciesShit =
{
	var type:String;
	var str:Int;
	var per:Int;
	var end:Int;
	var cha:Int;
	var int:Int;
	var agl:Int;
	var luk:Int;

	var hp:Int;
	var stamina:Int;
	var pp:Int;

	var radresist:Int;
	var ac:Int;

	var protrait:String;
}

class Player
{
	public static var str:Int = 5;
	public static var per:Int = 5;
	public static var end:Int = 5;
	public static var cha:Int = 5;
	public static var int:Int = 5;
	public static var agl:Int = 5;
	public static var luk:Int = 5;

	// Think I could put all of this into one, idk rn
	public static var strR:Int = 5;
	public static var perR:Int = 5;
	public static var endR:Int = 5;
	public static var chaR:Int = 5;
	public static var intR:Int = 5;
	public static var aglR:Int = 5;
	public static var lukR:Int = 5;

	public static var characterName:String = 'PLAYER';
	public static var characterSpecies:String = null;
	public static var characterType:String = null;
	public static var characterAge:Int = 16;
	public static var characterGender:String = 'male';

	public static var characterProtrait:String = null;

	public static var maxHealth:Float = 35;
	public static var maxStamina:Float = 30;
	public static var maxPP:Float = 10;

	public static var defaultAC:Int = 0;
	public static var defaultDefense:Int = 0;

	public static var ac:Int = 0;
	public static var defense:Int = 0;

	public static var speciesInfo:SpeciesShit;

	public static var moveLimit:Int = 4;

	public static var maxAP:Int = 7;

	public static var speed:Float = 30; // Usually priority, kind of inititive
	public static var accuracyMod:Float = 1;

	public static function loadShit()
	{
		str += speciesInfo.str;
		per += speciesInfo.per;
		end += speciesInfo.end;
		cha += speciesInfo.cha;
		int += speciesInfo.int;
		agl += speciesInfo.agl;
		luk += speciesInfo.luk;
	}

	public static var maxMoves:Map<Int, Int> = [8 => 10, 7 => 9, 6 => 8, 5 => 7, 4 => 4, 3 => 3,];

	public static var hpPercent:Int = 100;

	public static function recalculateStats(?fromLevel:Bool = true)
	{
		speciesInfo = cast Json.parse(AssetPaths.getTextFromFile('data/species/pokemon/$characterSpecies.json'));

		if (!fromLevel)
		{
			loadShit();

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

		defaultAC = Std.int((perR / 2) + (aglR / 2));
		defaultDefense = Std.int(endR / 2);
		if (!fromLevel)
		{
			ac = defaultAC;
			defense = defaultDefense;
		}

		updateMoveLimit();

		hpPercent = Std.int((PlayState.health / maxHealth) * 100);

		maxAP = Std.int(5 + (aglR / 2));

		if (hpPercent <= 50)
		{
			maxAP -= 1;
			if (hpPercent <= 25)
			{
				maxAP -= 1;
				if (PlayState.health <= 4)
					maxAP -= 1;
			}
		}
	}

	public static function updateMoveLimit()
	{
		var biggest:Int = 0;
		for (moves in maxMoves.keys())
		{
			if ((maxMoves.get(moves) <= intR) && (maxMoves.get(moves) >= biggest))
			{
				biggest = maxMoves.get(moves);
				moveLimit = moves;
			}
		}
	}

	public static var radEffect:String = 'none';

	// STR, PER, END, CHA, INT, AGL, TEXT
	public static var radiationEffect:Map<String, Array<Dynamic>> = [
		"none" => [0, 0, 0, 0, 0, 0, 'You feel fine'],
		"minor" => [0, 0, 1, 0, 0, 0, 'You are slighlty fatigued'],
		"advanced" => [0, 0, 2, 0, 0, 1, 'You are ill'],
		"critical" => [2, 0, 3, 0, 0, 2, 'You are very ill'],
		"deadly" => [4, 1, 5, 1, 1, 4, 'Your skin is decaying'],
		"fatal" => [5, 3, 6, 3, 3, 5, 'You are decaying'],
	];

	public static function radiation(rad:Float)
	{
		strR = str - Std.int(radiationEffect.get(radEffect)[0]);
		perR = per - Std.int(radiationEffect.get(radEffect)[1]);
		endR = end - Std.int(radiationEffect.get(radEffect)[2]);
		chaR = cha - Std.int(radiationEffect.get(radEffect)[3]);
		intR = int - Std.int(radiationEffect.get(radEffect)[4]);
		aglR = agl - Std.int(radiationEffect.get(radEffect)[5]);

		if (rad >= 150)
		{
			radEffect = 'minor';

			if (rad >= 300)
				radEffect = 'advanced';
			if (rad >= 450)
				radEffect = 'critical';
			if (rad >= 600)
				radEffect = 'deadly';
			if (rad >= 1000)
				radEffect = 'fatal';
		}
		else
			radEffect = 'none';
	}
}

class Conditions
{
	// Accuracy
	public static var armsCondition:Map<String, Int> = [
		"none" => 0,
		"damaged" => -5,
		"sprained" => -20,
		"broken" => -40,
		"crippled" => -60,
	];

	// Speed
	public static var legsCondition:Map<String, Int> = [
		"none" => 0,
		"damaged" => -1,
		"sprained" => -5,
		"broken" => -10,
		"crippled" => -15,
	];

	function updateConditions() {}
}
