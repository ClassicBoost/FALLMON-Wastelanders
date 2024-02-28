package fallmon.gameObjects.inventory;

typedef WeaponFile =
{
	var name:String;
	var image:String;
	var type:String;

	var damage:Int;
	var apCost:Int;

	var value:Int;
}

typedef AttackFile =
{
	var name:String;
	var image:String;
	var type:String;
	var physical:Bool;

	var damage:Int;
	var apCost:Int;

	// For physical moves. Otherwise, this is ignored
	var limbRisk:String;

	var value:Int;
}

class Attacks
{
	// uhh
}
