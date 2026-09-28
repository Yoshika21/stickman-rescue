package;

import flixel.FlxG;
import flixel.FlxGame;
import openfl.display.Sprite;
import states.TitleMenuState;
import utils.DiscordRPCUtil;

class Main extends Sprite {
    public function new() {
        super();

        // Inicializa o Flixel com resolução de 1280x720, iniciando no TitleMenuState a 60 FPS
        addChild(new FlxGame(1280, 720, TitleMenuState, 60, 60, true));

        // Inicializa e atualiza o Discord RPC apenas em plataformas desktop (Windows, etc.)
        #if DISCORD_ALLOWED
        DiscordRPCUtil.init();

        FlxG.signals.postUpdate.add(function() {
            DiscordRPCUtil.update();
        });
        #end
    }
}
