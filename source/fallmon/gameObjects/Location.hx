package fallmon.gameObjects;

typedef LocationFile =
{
	var name:String;
	var image:String;
	var map_icon:String;
	var type:String;

	var possibleEnemies:Array<EnemyList>;

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
	var background:FlxSprite;

	var currentBG:String = 'placeholder';

	var locationShit:LocationFile;

	public function new()
	{
		super();

		locationShit = cast Json.parse(AssetPaths.getTextFromFile('data/location/placeholder.json'));

		background = new FlxSprite(20, 25);
		background.antialiasing = Init.globalAnti;
		add(background);
	}

	public function changeLocation(file:String = null)
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
	}
}
