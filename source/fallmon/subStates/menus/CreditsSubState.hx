package fallmon.subStates.menus;

import fallmon.*;
import fallmon.backend.*;
import fallmon.states.menus.*;

class CreditsSubState extends FlxSubState
{
	private var menuTxt:FlxText;
	private var descriptionTxt:FlxText;
	private var currentOption:Int = 0;

	var overlayBG:FlxSprite;

	var credits:Array<String> = ['Classic1926', 'Nintendo', 'Bethesda'];

	public function new()
	{
		super();

		overlayBG = new FlxSprite(0, 0).makeGraphic(3000, 3000, 0xFF000000);
		overlayBG.alpha = 0;
		add(overlayBG);

		menuTxt = new FlxText(20, 300, FlxG.width, "", 20);
		menuTxt.setFormat(26, FlxColor.WHITE, LEFT);
		add(menuTxt);

		descriptionTxt = new FlxText(20, 500, FlxG.width, "", 20);
		descriptionTxt.setFormat(20, FlxColor.WHITE, CENTER);
		add(descriptionTxt);

		FlxTween.tween(overlayBG, {alpha: 0.75}, 0.25, {ease: FlxEase.linear});
		FlxTween.tween(menuTxt, {alpha: 1}, 0.25, {ease: FlxEase.linear});
		FlxTween.tween(descriptionTxt, {alpha: 1}, 0.25, {ease: FlxEase.linear});
	}

	var seperator:String = '\n';

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		descriptionTxt.screenCenter(X);

		menuTxt.text = (currentOption == 0 ? '> ' : '') + 'Classic1926' + seperator + seperator + (currentOption == 1 ? '> ' : '') + 'Nintendo' + seperator
			+ (currentOption == 2 ? '> ' : '') + 'Bethesda' + seperator;

		switch (credits[currentOption])
		{
			case 'Classic1926':
				descriptionTxt.text = 'Made everything';
			case 'Nintendo':
				descriptionTxt.text = 'Made Pokemon'; // I'm fucked
			case 'Bethesda':
				descriptionTxt.text = 'Made Fallout';
		}

		if (currentOption >= credits.length)
			currentOption = 0;
		if (currentOption < 0)
			currentOption = credits.length - 1;

		if (FlxG.keys.justPressed.DOWN)
			changeOptions(1);

		if (FlxG.keys.justPressed.UP)
			changeOptions(-1);

		if (FlxG.keys.justPressed.ESCAPE || FlxG.keys.justPressed.BACKSPACE)
			close();
	}

	function changeOptions(?value:Int = 0)
	{
		FlxG.sound.play(AssetPaths.sound('menus/select'));
		currentOption += value;
	}
}
