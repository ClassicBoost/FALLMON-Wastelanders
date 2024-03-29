package fallmon.gameObjects;

typedef EnemyFile =
{
	var name:String;
	var image:String;
	var type:Array<TypingLol>;

	var hp:Int;
	var attacks:Array<Attacks>;
	var defense:Int;
	var ac:Int;
	var ap:Int;

	// DO NOT SET TO A NEGATIVE VALUE
	var level:Int;

	var xp:Int;
	var rewards:String;
}

typedef TypingLol =
{
	var primary:String;
	var secondary:String; // Same as primary
	var ghostType:Bool;
}

typedef Attacks =
{
	var name:String;
	var type:String;
	var damage:Int;
}

class Enemy
{
	// uhh
}
