package fallmon.gameObjects.userInterface.icons;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.FlxGraphic;
import sys.FileSystem;

using StringTools;

class ProtraitsIcon extends FlxSprite
{
	// eep
	public function new(char:String = 'unown', ?isPlayer:Bool = false)
	{
		super();
		updateProtrait(char, isPlayer);
	}

	public function updateProtrait(char:String = 'bf', ?isPlayer:Bool = false)
	{
		var iconPath = char;
		if (!FileSystem.exists(AssetPaths.getPath('images/icons/protraits/' + iconPath + '.png', IMAGE)))
		{
			iconPath = 'unown';
			trace('$char icon trying $iconPath instead you fuck');
		}

		var iconGraphic:FlxGraphic = AssetPaths.image('icons/protraits/' + iconPath);
		loadGraphic(iconGraphic, true, 40, 40);

		animation.add('icon', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19], 0, false, !isPlayer);
		animation.play('icon');
		scrollFactor.set();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
