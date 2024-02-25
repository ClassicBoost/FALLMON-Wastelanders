package fallmon.gameObjects;

typedef StupidFile =
{
	var name:String;
	var image:String;
	var type:Array<TypingLol>;

	var xp:Int;
	var rewards:String;
}

typedef TypingLol =
{
	var primary:String;
	var secondary:String; // Same as primary
	var ghostType:Bool;
}

class Enemy extends FlxSprite
{
	public function new()
	{
		super();
	}

	override public function update(elapsed:Float) {}
}
