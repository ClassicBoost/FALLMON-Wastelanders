package fallmon.gameObjects.userInterface;

import fallmon.gameObjects.gameplay.*;

class ExplorationHUD extends FlxTypedGroup<FlxBasic>
{
	var healthTxt:FlxText;
	var staminaTxt:FlxText;
	var ppTxt:FlxText;
	var defensesTxt:FlxText;

	public var lerpAC:Float = 0;

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

		lerpAC = Player.ac;

		generateUIButtons();
	}

	var fightButton:FlxButton;
	var passButton:FlxButton;

	public function generateUIButtons():Void
	{
		fightButton = new FlxButton(660, 460, "Attack", function()
		{
			Actions.attackList();
		});
		var invButton:FlxButton = new FlxButton(660, 490, "Inventory", function()
		{
			Actions.playerInventory();
		});
		var actButton:FlxButton = new FlxButton(660, 520, "Action", function()
		{
			Actions.actionsList();
		});
		passButton = new FlxButton(660, 550, "Pass", function()
		{
			Actions.passTurn();
		});

		actButton.color = MainMenuState.bgcolorshit;
		invButton.color = MainMenuState.bgcolorshit;

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

		if (Actions.inCombat)
		{
			fightButton.color = MainMenuState.bgcolorshit;
			passButton.color = MainMenuState.bgcolorshit;
		}

		//	lerpAC = Math.floor(FlxMath.lerp(lerpAC, Player.ac, boundTo(elapsed * 5, 0, 1)));

		if (Player.ac > lerpAC)
			lerpAC += 0.5;
		if (Player.ac < lerpAC)
			lerpAC -= 0.5;

		super.update(elapsed);
	}

	var hpPercent:Float = 1;

	public static var stmPercent:Float = 1;

	var ppPercent:Float = 1;

	public function updateText()
	{
		hpPercent = Std.int((PlayState.health / Player.maxHealth) * 100);
		stmPercent = Std.int((PlayState.stamina / Player.maxStamina) * 100);
		ppPercent = Std.int((PlayState.pp / Player.maxPP) * 100);

		healthTxt.text = 'HP: ${Std.int(PlayState.health)}/${Player.maxHealth}';
		staminaTxt.text = 'STM: ${Std.int(PlayState.stamina)}/${Player.maxStamina}';
		ppTxt.text = 'PP: ${Std.int(PlayState.pp)}/${Player.maxPP}';
		defensesTxt.text = 'AC: ${Std.int(lerpAC)} // Defense: ${Player.defense}';
		// healthTxt.text += ' ($hpPercent%)';

		healthTxt.color = MainMenuState.bgcolorshit;
		staminaTxt.color = MainMenuState.bgcolorshit;
		ppTxt.color = MainMenuState.bgcolorshit;

		staminaTxt.alpha = 0.4;
		ppTxt.alpha = 0.4;
		defensesTxt.alpha = 0.4;

		if (Actions.inCombat)
		{
			staminaTxt.alpha = 1;
			ppTxt.alpha = 1;
			defensesTxt.alpha = 1;
		}

		if (hpPercent <= 20)
			healthTxt.color = 0xFFFF1E26; // Careful now...

		if (stmPercent <= 50)
			staminaTxt.color = 0xFFFF1E26;

		if (ppPercent <= 50)
			ppTxt.color = 0xFFFF6C71;
	}

	override function add(Object:FlxBasic):FlxBasic
	{
		if (Init.globalAnti && Std.isOfType(Object, FlxSprite))
			cast(Object, FlxSprite).antialiasing = false;
		return super.add(Object);
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
