package ext;

import java.awt.Color;
import java.awt.Graphics;
import java.util.List;
import c4.model.Board.Place;
import c4.base.BoardPanel;
import c4.base.C4Dialog;
import c4.base.ColorPlayer;

import java.awt.event.MouseEvent;
import java.awt.event.MouseMotionAdapter;

public privileged aspect EndGame{

    //ColorPlayer player_color = new ColorPlayer("Black",Color.BLACK);

    pointcut game_over(C4Dialog c4_dialog):
            this(c4_dialog) && (call(void C4Dialog.makeMove(int))
                    || call(int Board.dropInSlot(int, Player)));
    void around(C4Dialog c4_dialog):game_over(c4_dialog){

        //PLAYER WON GAME
        if(c4_dialog.board.isWonBy(c4_dialog.player)){
            c4_dialog.showMessage("Game is over, winner is :"+ c4_dialog.player.name() );
            AddSound.playAudio("click.wav");
        }

        //GAME IS A DRAW
        else {
            if(c4_dialog.board.isFull()){
                c4_dialog.showMessage("Tie Game!");
                AddSound.playAudio("click.wav");
            }
        }
    }

}