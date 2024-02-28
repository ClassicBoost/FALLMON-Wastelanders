package fallmon.gameObjects.userInterface;

class DebugHUD extends FlxTypedGroup<FlxBasic>
{
	var debugTxt:FlxText;

	// eep
	public function new()
	{
		super();

		debugTxt = new FlxText(5, 16, 0, 'hey vsauce michael here', 8);
		add(debugTxt);
	}

	override public function update(elapsed:Float)
	{
		debugTxt.text = '${Main.gameVersion}\n';

		debugTxt.text += '\nhealth: ${PlayState.health}\nmaxHealth: ${Player.maxHealth}\n';
		debugTxt.text += '\nstamina: ${PlayState.stamina}\nmaxStamina: ${Player.maxStamina}\n';
		debugTxt.text += '\npp: ${PlayState.pp}\nmaxPP: ${Player.maxPP}\n';
		debugTxt.text += '\nradiation: ${PlayState.radiation}\n';
		debugTxt.text += '\nstr: ${Player.strR}';
		debugTxt.text += '\nper: ${Player.perR}';
		debugTxt.text += '\nend: ${Player.endR}';
		debugTxt.text += '\ncha: ${Player.chaR}';
		debugTxt.text += '\nint: ${Player.intR}';
		debugTxt.text += '\nagl: ${Player.aglR}';
		debugTxt.text += '\nluk: ${Player.lukR}\n';
		debugTxt.text += '\nmoveLimit: ${Player.moveLimit}';
		debugTxt.text += '\nac: ${Player.ac} | defaultAC: ${Player.defaultAC}';
		debugTxt.text += '\ndefense: ${Player.defense} | defaultDefense: ${Player.defaultDefense}';

		debugTxt.text += '\n';
	}
}
