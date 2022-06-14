package android.flixel;

import flixel.util.FlxDestroyUtil;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.graphics.FlxGraphic;
import flixel.group.FlxSpriteGroup;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import android.flixel.FlxButton;
import flixel.util.FlxColor;
import flixel.FlxSprite;

// Mofifications by saw (m.a. jigsaw)
class FlxHitbox extends FlxSpriteGroup 
{
	public var hitbox:FlxSpriteGroup;

	public var buttonLeft:FlxButton;
	public var buttonDown:FlxButton;
	public var buttonUp:FlxButton;
	public var buttonRight:FlxButton;

	public function new()
	{
		super();

		hitbox = new FlxSpriteGroup();

		buttonLeft = new FlxButton(0, 0);
		buttonDown = new FlxButton(0, 0);
		buttonUp = new FlxButton(0, 0);
		buttonRight = new FlxButton(0, 0);

		hitbox.add(add(buttonLeft = createHitbox(0, 0, 'left', FlxColor.PURPLE)));
		hitbox.add(add(buttonDown = createHitbox(320, 0, 'down', FlxColor.CYAN)));
		hitbox.add(add(buttonUp = createHitbox(640, 0, 'up', FlxColor.LIME)));
		hitbox.add(add(buttonRight = createHitbox(960, 0, 'right', FlxColor.RED)));

		hitbox.add(add(createHitboxHint(0, 0, 'left_hint', FlxColor.PURPLE)));
		hitbox.add(add(createHitboxHint(320, 0, 'down_hint', FlxColor.CYAN)));
		hitbox.add(add(createHitboxHint(640, 0, 'up_hint', FlxColor.LIME)));
		hitbox.add(add(createHitboxHint(960, 0, 'right_hint', FlxColor.RED)));
	}

	public function createHitbox(x:Float = 0, y:Float = 0, frames:String, ?color:FlxColor):FlxButton
	{
		var button:FlxButton = new FlxButton(x, y);
		button.loadGraphic(FlxGraphic.fromFrame(getFrames().getByName(frames)));
		button.alpha = 0.00001;
		button.antialiasing = ClientPrefs.globalAntialiasing;
		if (color != null && ClientPrefs.fnfColours)
			button.color = color;
		button.onDown.callback = function() {FlxTween.num(0.00001, 0.75, 0.075, {ease:FlxEase.circInOut}, function(alpha:Float) {button.alpha = alpha;});}
		button.onUp.callback = function() {FlxTween.num(0.75, 0.00001, 0.1, {ease:FlxEase.circInOut}, function(alpha:Float) {button.alpha = alpha;});}
		button.onOut.callback = function() {FlxTween.num(button.alpha, 0.00001, 0.2, {ease:FlxEase.circInOut}, function(alpha:Float) {button.alpha = alpha;});}
		#if FLX_DEBUG
		button.ignoreDrawDebug = true;
		#end
		return button;
	}

	public function createHitboxHint(x:Float = 0, y:Float = 0, frames:String, ?color:FlxColor):FlxSprite
	{
		var hint:FlxSprite = new FlxSprite(x, y);
		hint.loadGraphic(FlxGraphic.fromFrame(getFrames().getByName(frames)));
		hint.alpha = 0.75;
		if (color != null && ClientPrefs.fnfColours)
			hint.color = color;
		return hint;
	}

	public function getFrames():FlxAtlasFrames
	{
		return Paths.getSparrowAtlas('android/hitbox');
	}

	override public function destroy():Void
	{
		super.destroy();

		hitbox = FlxDestroyUtil.destroy(hitbox);
		hitbox = null;

		buttonLeft = null;
		buttonDown = null;
		buttonUp = null;
		buttonRight = null;
	}
}
