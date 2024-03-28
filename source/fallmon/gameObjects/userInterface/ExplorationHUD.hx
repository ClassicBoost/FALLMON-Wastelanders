package fallmon.gameObjects.userInterface;

import fallmon.gameObjects.gameplay.*;
import fallmon.gameObjects.userInterface.icons.ProtraitsIcon;

class ExplorationHUD extends FlxTypedGroup<FlxBasic>
{
	var healthTxt:FlxText;
	var staminaTxt:FlxText;
	var ppTxt:FlxText;
	var defensesTxt:FlxText;
	var apTxt:FlxText;

	public var playerProtrait:ProtraitsIcon;

	public var lerpAC:Float = 0;

	var ogAP:Int = 7;

	// eep
	public function new()
	{
		super();

		var hud = new FlxSprite().loadGraphic(AssetPaths.image('UI/exploration/ui'));
		add(hud);

		var playerName = new FlxText(35, 450, 0, '${Player.characterName} - ${Player.characterSpecies.toUpperCase()}');
		playerName.setFormat(AssetPaths.font('terminal.ttf'), 24, FlxColor.WHITE, LEFT);
		playerName.antialiasing = Init.globalAnti;
		playerName.color = MainMenuState.bgcolorshit;
		add(playerName);

		healthTxt = new FlxText(35, 480, 0, '');
		healthTxt.setFormat(AssetPaths.font('terminal.ttf'), 20, FlxColor.WHITE, LEFT);
		healthTxt.antialiasing = Init.globalAnti;
		add(healthTxt);

		staminaTxt = new FlxText(35, 500, 0, '');
		staminaTxt.setFormat(AssetPaths.font('terminal.ttf'), 20, FlxColor.WHITE, LEFT);
		staminaTxt.antialiasing = Init.globalAnti;
		add(staminaTxt);

		ppTxt = new FlxText(35, 520, 0, '');
		ppTxt.setFormat(AssetPaths.font('terminal.ttf'), 20, FlxColor.WHITE, LEFT);
		ppTxt.antialiasing = Init.globalAnti;
		add(ppTxt);

		defensesTxt = new FlxText(35, 540, 0, '');
		defensesTxt.setFormat(AssetPaths.font('terminal.ttf'), 20, FlxColor.WHITE, LEFT);
		defensesTxt.antialiasing = Init.globalAnti;
		defensesTxt.color = MainMenuState.bgcolorshit;
		add(defensesTxt);

		playerProtrait = new ProtraitsIcon(Player.characterProtrait, true);
		playerProtrait.y = 480;
		playerProtrait.x = 190;
		playerProtrait.antialiasing = Init.globalAnti;
		add(playerProtrait);

		apTxt = new FlxText(250, 500, 0, '');
		apTxt.setFormat(AssetPaths.font('terminal.ttf'), 26, FlxColor.WHITE, LEFT);
		apTxt.antialiasing = Init.globalAnti;
		apTxt.color = MainMenuState.bgcolorshit;
		add(apTxt);

		lerpAC = Player.ac;

		generateUIButtons();
	}

	var fightButton:FlxButton;
	var passButton:FlxButton;
	var invButton:FlxButton;
	var actButton:FlxButton;

	public function generateUIButtons():Void
	{
		fightButton = new FlxButton(660, 460, "Attack", function()
		{
			Actions.attackList();
		});
		invButton = new FlxButton(660, 490, "Inventory", function()
		{
			Actions.playerInventory();
		});
		actButton = new FlxButton(660, 520, "Action", function()
		{
			Actions.actionsList();
		});
		passButton = new FlxButton(660, 550, "Pass", function()
		{
			Actions.passTurn();
		});

		fightButton.label.color = FlxColor.BLACK;
		actButton.label.color = FlxColor.BLACK;
		invButton.label.color = FlxColor.BLACK;
		passButton.label.color = FlxColor.BLACK;

		add(fightButton);
		add(invButton);
		add(actButton);
		add(passButton);
	}

	override public function update(elapsed:Float)
	{
		updateText();

		fightButton.color = 0xFFD63C3C;
		passButton.color = 0xFFD63C3C;

		actButton.color = 0xFFD63C3C;
		invButton.color = 0xFFD63C3C;

		if (Actions.inCombat)
		{
			if (Actions.playerTurn)
			{
				fightButton.color = MainMenuState.bgcolorshit;
				passButton.color = MainMenuState.bgcolorshit;
				actButton.color = MainMenuState.bgcolorshit;
				invButton.color = MainMenuState.bgcolorshit;
			}
		}
		else
		{
			Actions.actionPoints = Player.maxAP;
			actButton.color = MainMenuState.bgcolorshit;
			invButton.color = MainMenuState.bgcolorshit;
			PlayState.stamina += 0.1;
			PlayState.pp += 0.005;
		}

		//	lerpAC = Math.floor(FlxMath.lerp(lerpAC, Player.ac, boundTo(elapsed * 5, 0, 1)));

		if (Player.ac > lerpAC)
			lerpAC += 0.5;
		if (Player.ac < lerpAC)
			lerpAC -= 0.5;

		super.update(elapsed);
	}

	public static var stmPercent:Float = 1;

	var ppPercent:Float = 1;

	public function updateText()
	{
		stmPercent = Std.int((PlayState.stamina / Player.maxStamina) * 100);
		ppPercent = Std.int((PlayState.pp / Player.maxPP) * 100);

		healthTxt.text = 'HP: ${Std.int(PlayState.health)}/${Player.maxHealth}';
		staminaTxt.text = 'STM: ${Std.int(PlayState.stamina)}/${Player.maxStamina}';
		ppTxt.text = 'PP: ${Std.int(PlayState.pp)}/${Player.maxPP}';
		defensesTxt.text = 'AC: ${Std.int(lerpAC)} // Defense: ${Player.defense}';
		// healthTxt.text += ' (${Player.hpPercent}%)';

		healthTxt.color = MainMenuState.bgcolorshit;
		staminaTxt.color = MainMenuState.bgcolorshit;
		ppTxt.color = MainMenuState.bgcolorshit;

		apTxt.text = '${Actions.actionPoints}/${Player.maxAP} AP';

		staminaTxt.alpha = 0.4;
		ppTxt.alpha = 0.4;
		defensesTxt.alpha = 0.4;
		apTxt.alpha = 0.2;

		if (Actions.inCombat)
		{
			staminaTxt.alpha = 1;
			ppTxt.alpha = 1;
			defensesTxt.alpha = 1;
			apTxt.alpha = 1;
		}

		if (stmPercent <= 50)
			staminaTxt.color = 0xFFFF1E26;

		if (ppPercent <= 50)
			ppTxt.color = 0xFFFF6C71;

		if (Player.hpPercent <= 25)
		{
			healthTxt.color = 0xFFFF1E26; // Careful, now...
			protraitUpdate(2, 0.1);
			if (PlayState.health <= 4)
				protraitUpdate(13, 0.1);
		}

		if (ogAP != Actions.actionPoints)
		{
			FlxTween.cancelTweensOf(apTxt);
			apTxt.scale.set(1.075, 1.075);
			FlxTween.tween(apTxt, {"scale.x": 1, "scale.y": 1}, 0.25, {ease: FlxEase.cubeOut});

			ogAP = Actions.actionPoints;
		}
	}

	public function protraitUpdate(?iconToShow:Int = 0, ?iconLength:Float = 0)
	{
		playerProtrait.animation.curAnim.curFrame = iconToShow;

		if (iconLength > 0)
			new FlxTimer().start(iconLength, function(fuckfuck:FlxTimer)
			{
				playerProtrait.animation.curAnim.curFrame = 0;
			});
	}

	function boundTo(value:Float, min:Float, max:Float):Float
	{
		var newValue:Float = value;
		if (newValue < min)
			newValue = min;
		else if (newValue > max)
			newValue = max;
		return newValue;
	}
}
