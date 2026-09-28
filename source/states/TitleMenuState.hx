package states;

import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.util.FlxColor;
import utils.Constants;
import utils.SoundManager;
import utils.DiscordRPCUtil;
import utils.AssetManager;

class TitleMenuState extends FlxState {
    private var sky:FlxSprite;
    private var clouds:FlxSprite;
    private var floorAndStickman:FlxSprite;
    private var logo:FlxSprite;
    private var pressEnterBtn:FlxSprite;

    private var isTransitioning:Bool = false;

    override public function create():Void {
        super.create();
        DiscordRPCUtil.changePresence(
            "Waiting for da game to start", 
            "In the Title Menu", 
            "stickman_defaultL", 
            "Stickman Rescue", 
            "stickman_default", 
            "Stickman"
        );

        if (FlxG.sound.music == null || !FlxG.sound.music.playing) {
            SoundManager.playMenuMusic();
        }

        sky = AssetManager.loadGraphic(0, 0, "menus/title/sky");
        add(sky);

        clouds = AssetManager.loadGraphic(0, 0, "menus/title/clouds");
        add(clouds);

        floorAndStickman = AssetManager.loadGraphic(0, 0, "menus/title/floorandstickman");
        add(floorAndStickman);

        logo = AssetManager.loadGraphic(0, 0, "menus/title/logo");
        logo.screenCenter(X);
        logo.y = 50;
        add(logo);

        var pngPath:String = AssetManager.image("menus/title/pressenter");
        var xmlPath:String = StringTools.replace(pngPath, ".png", ".xml");

        pressEnterBtn = new FlxSprite();
        pressEnterBtn.frames = FlxAtlasFrames.fromSparrow(pngPath, xmlPath);
        pressEnterBtn.animation.addByPrefix("idle", "press enter0", 24, true);
        pressEnterBtn.animation.addByPrefix("pressed", "enter pressed", 24, false);
        
        pressEnterBtn.animation.play("idle");
        pressEnterBtn.screenCenter(X);
        pressEnterBtn.y = Constants.GAME_HEIGHT - pressEnterBtn.height - 40;
        add(pressEnterBtn);
        FlxG.cameras.fade(FlxColor.BLACK, 0.5, true);
    }

    override public function update(elapsed:Float):Void {
        super.update(elapsed);

        var pressed:Bool = false;

        if (!isTransitioning) {
            #if mobile
            if (FlxG.touches.justStarted().length > 0) {
                pressed = true;
            }
            #end

            if (FlxG.keys.justPressed.ANY) {
                pressed = true;
            }

            if (pressed) {
                startTransition();
            }
        }
    }

    private function startTransition():Void {
        isTransitioning = true;

        SoundManager.playConfirm();
        pressEnterBtn.animation.play("enter pressed");
        FlxG.cameras.fade(FlxColor.BLACK, 0.8, false, function() {
            FlxG.switchState(new MainMenuState());
        });
    }
}
