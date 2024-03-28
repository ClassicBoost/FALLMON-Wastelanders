package fallmon.gameObjects;

typedef LocationFile =
{
	var name:String;
	var image:String;
	var map_icon:String;
	var type:String;

	var possibleEnemies:Array<EnemyList>;

	// From 1-100 (higher number means more likely to encounter). 0 or Safe difficulty will disable
	var encounterChance:Int;
	// 0 - Safe (ignores possibleEnemies), 1 - Easy, 2 - Moderate, 3 - Difficult, 4 - Insane, 5 - Please no
	var difficulty:Int;
}

typedef EnemyList =
{
	var enemy:String;
	var min:Int;
	var max:Int;

	// Setting one or both of those to 0 will instead set them to their default level.
	// -1 will set them to the player's level
	var level_min:Int;
	var level_max:Int;
}

class Location extends FlxTypedGroup<FlxBasic>
{
	public static var background:FlxSprite;

	public static var currentBG:String = 'placeholder';

	public static var locationShit:LocationFile;

	public static var broWho:String = '';

	public function new()
	{
		super();

		locationShit = cast Json.parse(AssetPaths.getTextFromFile('data/location/placeholder.json'));

		background = new FlxSprite(20, 25);
		background.antialiasing = Init.globalAnti;
		add(background);
	}

	public static function changeLocation(file:String = null)
	{
		if (OpenFlAssets.exists('assets/data/location/$file.json'))
			locationShit = cast Json.parse(AssetPaths.getTextFromFile('data/location/$file.json'));
		else
			locationShit = cast Json.parse(AssetPaths.getTextFromFile('data/location/placeholder.json'));

		currentBG = locationShit.image;

		// Background sizes must be 760x376
		if (!OpenFlAssets.exists('assets/images/backgrounds/$currentBG.png'))
			background.loadGraphic(AssetPaths.image('backgrounds/placeholder'));
		else
			background.loadGraphic(AssetPaths.image('backgrounds/$currentBG'));

		if (locationShit.encounterChance > 0 && locationShit.difficulty > 0)
			RollTime.roll(1, 100, 'encounter', '', locationShit.encounterChance);
	}

	public static function encounterMoment()
	{
		// IM DUMB AND IDK HOW TO GET THIS TO WORK
		var whoCouldThatBe:Int = FlxG.random.int(0, locationShit.possibleEnemies.length - 1);
		//	var theirLevel:Int = FlxG.random.int(locationShit.possibleEnemies.level_min, locationShit.possibleEnemies.level_max);
		var theirLevel:Int = 1;
	}
}
