package states;

import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import utils.SoundManager;
import utils.DiscordRPCUtil;
import utils.AssetManager;

class MainMenuState extends FlxState {
    private var alphaBg:FlxSprite;

    override public function create():Void {
        super.create();

        // 1. Atualização da presença no Discord RPC
        DiscordRPCUtil.changePresence(
            "In the Main Menu", 
            "Alpha Version", 
            "stickman_defaultL", 
            "Stickman Rescue", 
            "stickman_default", 
            "Stickman"
        );

        // 2. Garante que a música do menu continua tocando em loop
        if (FlxG.sound.music == null || !FlxG.sound.music.playing) {
            SoundManager.playMenuMusic();
        }

        // 3. Carrega a imagem do menu (assets/images/menus/mainm/alpha ver.png)
        alphaBg = AssetManager.loadGraphic(0, 0, "menus/mainm/alpha ver");
        add(alphaBg);

        // Efeito de fade-in ao entrar na tela vindo do TitleMenuState
        FlxG.cameras.fade(FlxColor.BLACK, 0.5, true);
    }

    override public function update(elapsed:Float):Void {
        super.update(elapsed);
    }
}
