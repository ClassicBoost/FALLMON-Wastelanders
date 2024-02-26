package fallmon.gameObjects;

import fallmon.backend.AssetPaths;

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

	public static var maxHealth:Float = 35;
	public static var maxStamina:Float = 30;
	public static var maxPP:Float = 10;

	public static var speciesInfo:SpeciesShit;

	public static var moveLimit:Int = 4;

	public static var maxAP:Int = 7;

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

	public static function recalculateStats(?fromLevel:Bool = true)
	{
		speciesInfo = cast Json.parse(AssetPaths.getTextFromFile('data/species/pokemon/$characterSpecies.json'));

		if (!fromLevel)
		{
			Player.loadShit();

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

	public static var radEffect:String = 'fine';

	// STR, PER, END, CHA, INT, AGL
	public static var radiationEffect:Map<String, Array<Int>> = [
		"fine" => [0, 0, 0, 0, 0, 0],
		"fatigued" => [0, 0, 1, 0, 0, 0],
		"ill" => [0, 0, 2, 0, 0, 1],
		"very ill" => [2, 0, 3, 0, 0, 2],
		"skin decay" => [4, 1, 5, 1, 1, 4],
		"decay" => [5, 3, 6, 3, 3, 5],
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
			radEffect = 'fatigued';

			if (rad >= 300)
				radEffect = 'ill';
			if (rad >= 450)
				radEffect = 'very ill';
			if (rad >= 600)
				radEffect = 'skin decay';
			if (rad >= 1000)
				radEffect = 'decay';
		}
		else
			radEffect = 'fine';
	}
}
