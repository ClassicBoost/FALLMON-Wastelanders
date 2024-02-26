package fallmon.subStates.menus;

import fallmon.*;
import fallmon.backend.*;
import fallmon.gameObjects.Player;
import fallmon.states.menus.*;

class NameCreator extends FlxSubState
{
	// Stealing this from my canceled fnf mod lol
	var codeOverlay:FlxSprite;
	var codeText:FlxText;
	var codeTypedIn:String = '';
	var keysPressed:Int = 0;

	public function new()
	{
		super();

		codeOverlay = new FlxSprite(0, 0).makeGraphic(3000, 3000, 0xFF000000);
		codeOverlay.alpha = 0;
		add(codeOverlay);

		codeText = new FlxText(0, 0, FlxG.width, '', 32);
		codeText.setFormat(32, FlxColor.WHITE, CENTER);
		codeText.screenCenter();
		codeText.alpha = 0;
		codeText.scrollFactor.set();
		add(codeText);

		codeTypedIn = Player.characterName;

		FlxTween.tween(codeOverlay, {alpha: 0.75}, 0.25, {ease: FlxEase.linear});
		FlxTween.tween(codeText, {alpha: 1}, 0.25, {ease: FlxEase.linear});
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		codeText.text = '${codeTypedIn.toUpperCase()}\n\nENTER to accept\nESC to exit without save';
		codeText.screenCenter();

		if (FlxG.keys.justPressed.ONE)
		{
			codeTypedIn += '1';
			FlxG.sound.play(AssetPaths.sound('terminal/terminal_key'), 0.4);
		}
		if (FlxG.keys.justPressed.TWO)
		{
			codeTypedIn += '2';
			FlxG.sound.play(AssetPaths.sound('terminal/terminal_key'), 0.4);
		}
		if (FlxG.keys.justPressed.THREE)
		{
			codeTypedIn += '3';
			FlxG.sound.play(AssetPaths.sound('terminal/terminal_key'), 0.4);
		}
		if (FlxG.keys.justPressed.FOUR)
		{
			codeTypedIn += '4';
			FlxG.sound.play(AssetPaths.sound('terminal/terminal_key'), 0.4);
		}
		if (FlxG.keys.justPressed.FIVE)
		{
			codeTypedIn += '5';
			FlxG.sound.play(AssetPaths.sound('terminal/terminal_key'), 0.4);
		}
		if (FlxG.keys.justPressed.SIX)
		{
			codeTypedIn += '6';
			FlxG.sound.play(AssetPaths.sound('terminal/terminal_key'), 0.4);
		}
		if (FlxG.keys.justPressed.SEVEN)
		{
			codeTypedIn += '7';
			FlxG.sound.play(AssetPaths.sound('terminal/terminal_key'), 0.4);
		}
		if (FlxG.keys.justPressed.EIGHT)
		{
			codeTypedIn += '8';
			FlxG.sound.play(AssetPaths.sound('terminal/terminal_key'), 0.4);
		}
		if (FlxG.keys.justPressed.NINE)
		{
			codeTypedIn += '9';
			FlxG.sound.play(AssetPaths.sound('terminal/terminal_key'), 0.4);
		}
		if (FlxG.keys.justPressed.ZERO)
		{
			codeTypedIn += '0';
			FlxG.sound.play(AssetPaths.sound('terminal/terminal_key'), 0.4);
		}

		if (FlxG.keys.justPressed.A)
		{
			codeTypedIn += 'a';
			FlxG.sound.play(AssetPaths.sound('terminal/terminal_key'), 0.4);
		}
		if (FlxG.keys.justPressed.B)
		{
			codeTypedIn += 'b';
			FlxG.sound.play(AssetPaths.sound('terminal/terminal_key'), 0.4);
		}
		if (FlxG.keys.justPressed.C)
		{
			codeTypedIn += 'c';
			FlxG.sound.play(AssetPaths.sound('terminal/terminal_key'), 0.4);
		}
		if (FlxG.keys.justPressed.D)
		{
			codeTypedIn += 'd';
			FlxG.sound.play(AssetPaths.sound('terminal/terminal_key'), 0.4);
		}
		if (FlxG.keys.justPressed.E)
		{
			codeTypedIn += 'e';
			FlxG.sound.play(AssetPaths.sound('terminal/terminal_key'), 0.4);
		}
		if (FlxG.keys.justPressed.F)
		{
			codeTypedIn += 'f';
			FlxG.sound.play(AssetPaths.sound('terminal/terminal_key'), 0.4);
		}
		if (FlxG.keys.justPressed.G)
		{
			codeTypedIn += 'g';
			FlxG.sound.play(AssetPaths.sound('terminal/terminal_key'), 0.4);
		}
		if (FlxG.keys.justPressed.H)
		{
			codeTypedIn += 'h';
			FlxG.sound.play(AssetPaths.sound('terminal/terminal_key'), 0.4);
		}
		if (FlxG.keys.justPressed.I)
		{
			codeTypedIn += 'i';
			FlxG.sound.play(AssetPaths.sound('terminal/terminal_key'), 0.4);
		}
		if (FlxG.keys.justPressed.J)
		{
			codeTypedIn += 'j';
			FlxG.sound.play(AssetPaths.sound('terminal/terminal_key'), 0.4);
		}
		if (FlxG.keys.justPressed.K)
		{
			codeTypedIn += 'k';
			FlxG.sound.play(AssetPaths.sound('terminal/terminal_key'), 0.4);
		}
		if (FlxG.keys.justPressed.L)
		{
			codeTypedIn += 'l';
			FlxG.sound.play(AssetPaths.sound('terminal/terminal_key'), 0.4);
		}
		if (FlxG.keys.justPressed.M)
		{
			codeTypedIn += 'm';
			FlxG.sound.play(AssetPaths.sound('terminal/terminal_key'), 0.4);
		}
		if (FlxG.keys.justPressed.N)
		{
			codeTypedIn += 'n';
			FlxG.sound.play(AssetPaths.sound('terminal/terminal_key'), 0.4);
		}
		if (FlxG.keys.justPressed.O)
		{
			codeTypedIn += 'o';
			FlxG.sound.play(AssetPaths.sound('terminal/terminal_key'), 0.4);
		}
		if (FlxG.keys.justPressed.P)
		{
			codeTypedIn += 'p';
			FlxG.sound.play(AssetPaths.sound('terminal/terminal_key'), 0.4);
		}
		if (FlxG.keys.justPressed.Q)
		{
			codeTypedIn += 'q';
			FlxG.sound.play(AssetPaths.sound('terminal/terminal_key'), 0.4);
		}
		if (FlxG.keys.justPressed.R)
		{
			codeTypedIn += 'r';
			FlxG.sound.play(AssetPaths.sound('terminal/terminal_key'), 0.4);
		}
		if (FlxG.keys.justPressed.S)
		{
			codeTypedIn += 's';
			FlxG.sound.play(AssetPaths.sound('terminal/terminal_key'), 0.4);
		}
		if (FlxG.keys.justPressed.T)
		{
			codeTypedIn += 't';
			FlxG.sound.play(AssetPaths.sound('terminal/terminal_key'), 0.4);
		}
		if (FlxG.keys.justPressed.U)
		{
			codeTypedIn += 'u';
			FlxG.sound.play(AssetPaths.sound('terminal/terminal_key'), 0.4);
		}
		if (FlxG.keys.justPressed.V)
		{
			codeTypedIn += 'v';
			FlxG.sound.play(AssetPaths.sound('terminal/terminal_key'), 0.4);
		}
		if (FlxG.keys.justPressed.W)
		{
			codeTypedIn += 'w';
			FlxG.sound.play(AssetPaths.sound('terminal/terminal_key'), 0.4);
		}
		if (FlxG.keys.justPressed.X)
		{
			codeTypedIn += 'x';
			FlxG.sound.play(AssetPaths.sound('terminal/terminal_key'), 0.4);
		}
		if (FlxG.keys.justPressed.Y)
		{
			codeTypedIn += 'y';
			FlxG.sound.play(AssetPaths.sound('terminal/terminal_key'), 0.4);
		}
		if (FlxG.keys.justPressed.Z)
		{
			codeTypedIn += 'z';
			FlxG.sound.play(AssetPaths.sound('terminal/terminal_key'), 0.4);
		}
		if (FlxG.keys.justPressed.SPACE)
		{
			codeTypedIn += ' ';
			FlxG.sound.play(AssetPaths.sound('terminal/terminal_key'), 0.4);
		}

		if (FlxG.keys.justPressed.BACKSPACE)
		{
			if (codeTypedIn == '')
				close();
			else
			{
				FlxG.sound.play(AssetPaths.sound('terminal/terminal_bkspc'), 0.4);
				codeTypedIn = codeTypedIn.substring(0, codeTypedIn.length - 1);
			}
		}

		if (FlxG.keys.justPressed.ENTER || FlxG.keys.justPressed.ESCAPE)
		{
			if (codeTypedIn != '' && FlxG.keys.justPressed.ENTER)
				Player.characterName = codeTypedIn.toUpperCase();

			close();
		}
	}
}
