setResolution(800, 800)

donut("utils.nut");
donut("assets.nut");
donut("_game.nut");
donut("_objects.nut");

Actors.push(Player(Vec2d(0, 0), 'x', sprP1)) //Red
Actors.push(Player(Vec2d(1, 1), 'o', sprP2)) //Blue


while(!getQuit() && !Quit){
    Turn = Turns[TurnCount%Turns.len()]
    local playerCount = 0
    foreach(i in Actors){

        if(typeof i == "Player"){
            playerCount++

        }
    }
    if(playerCount == 1){
        foreach(i in Actors){
            if(typeof i == "Player"){
                Winner = i.symbol
                Win = true

            }
        }
    }

    for(local y = 0; y < BoardSquaresH; y++){
        for(local x = 0; x < BoardSquaresW; x++){
            drawSprite(sprBoard, 0, BoardStart.x + x * SquareW, BoardStart.y + y * SquareH)
        }
    }

    foreach(i in Actors){
        i.update();
    }
    foreach(i in Actors){
        if(typeof i != "Player")i.draw();
    }
    foreach(i in Actors){
        if(typeof i == "Player")i.draw();
    }



    drawText(font, screenW()-10, 0, Turn.tochar().tostring())
    if(Win == true){
        drawText(font, 0, 0, Winner.tochar().tostring() + " " + "wins!")
    }
    update()

}