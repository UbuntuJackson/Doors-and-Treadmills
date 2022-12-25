::Object_ <- class{
    pos = Vec2d(0,0);
    constructor(_pos){
        pos = _pos;
    }
    function update(){}
    function draw(){}
    function _typeof(){}
}

::Player <- class extends Object_{
    symbol = "";
    sprite = null;
    doorCount = 2;
    doorOne = null;
    doorTwo = null;
    constructor(_pos, _symbol, _sprite){
        base.constructor(_pos);
        symbol = _symbol;
        sprite = _sprite;
        doorOne = Door(Vec2d(0,0))
        doorTwo = Door(Vec2d(0,0))
        doorOne.link = doorTwo
        doorTwo.link = doorOne
        Turns.push(symbol);
    }
    function update(){

        if(symbol == Turn && !Win) {
            local movementVec = Vec2d(0, 0)
            if(keyPress(k_down)){
                movementVec.y = 1
                TurnCount++
            }
            else if(keyPress(k_up)){
                movementVec.y = -1
                TurnCount++
            }
            else if(keyPress(k_right)){
                movementVec.x = 1
                TurnCount++
            }
            else if (keyPress(k_left)){
                movementVec.x = -1
                TurnCount++
            }
            else{}

            pos += movementVec

            pos.y = posMod(pos.y, BoardSquaresH)
            pos.x = posMod(pos.x, BoardSquaresW)

            if(keyPress(k_a)){


                if(doorCount == 2){
                    Actors.push(doorOne)
                    doorOne.pos.x = pos.x
                    doorOne.pos.y = pos.y
                    doorCount--
                }

                else if(doorCount == 1){
                    Actors.push(doorTwo)
                    doorTwo.pos.x = pos.x
                    doorTwo.pos.y = pos.y
                    doorCount--
                }
            }
            if(keyPress(k_s)) Actors.push(Deathplane(pos))
            if(keyPress(k_d)) Actors.push(Treadmill(pos))

            foreach (i in Actors) {
                if(i != this && pos.x == i.pos.x && pos.y == i.pos.y){
                    switch(typeof i){
                        case "Player":
                            removeActor(Actors, i)
                            break
                        case "Treadmill":


                            while(onTreadmill(this) && (movementVec.x != 0 || movementVec.y != 0)){

                                pos += movementVec
                                pos.y = posMod(pos.y, BoardSquaresH)
                                pos.x = posMod(pos.x, BoardSquaresW)
                            }
                            foreach(j in Actors){
                                if(j != this && pos.x == j.pos.x && pos.y == j.pos.y){
                                    switch( typeof j){
                                        case "Door":
                                            if(doorCount == 0 && (movementVec.x != 0 || movementVec.y != 0)){
                                                print("a")
                                                pos.x = j.link.pos.x
                                                pos.y = j.link.pos.y
                                                pos.y = posMod(pos.y, BoardSquaresH)
                                                pos.x = posMod(pos.x, BoardSquaresW)
                                                movementVec.x = 0;
                                                movementVec.y = 0;

                                            }
                                            break
                                        case "DeathPlane":
                                            if((movementVec.x != 0 || movementVec.y != 0)){
                                                removeActor(Actors, this)
                                            }
                                            break
                                        case "Player":
                                            removeActor(Actors, j)
                                            break
                                    }
                                }
                            }
                            break
                        case "Door":

                            if(doorCount == 0 && (movementVec.x != 0 || movementVec.y != 0)){
                                print("a")
                                pos.x = i.link.pos.x
                                pos.y = i.link.pos.y
                                pos.y = posMod(pos.y, BoardSquaresH)
                                pos.x = posMod(pos.x, BoardSquaresW)
                                movementVec.x = 0;
                                movementVec.y = 0;

                            }
                            break
                        case "Deathplane":
                            if((movementVec.x != 0 || movementVec.y != 0)){
                                removeActor(Actors, this)
                            }
                            break
                        default:

                            break

                    }
                }
            }

        }



    }
    function draw(){
        drawSprite(sprite, 0, pos.x * SquareW + BoardStart.x, pos.y * SquareH + BoardStart.y)

    }
    function _typeof(){return "Player"}
}

::Door <- class extends Object_{
    link = null;
    constructor(_pos, _link = null){
        base.constructor(_pos);
        link = _link
    }
    function draw(){
        drawSprite(sprDoor, 0, pos.x * SquareW + BoardStart.x, pos.y * SquareH + BoardStart.y)

    }
    function _typeof(){return "Door"}
}
::Treadmill <- class extends Object_{
    constructor(_pos){
        base.constructor(_pos);
    }
    function draw(){
        drawSprite(sprTreadmill, 0, pos.x * SquareW + BoardStart.x, pos.y * SquareH + BoardStart.y)

    }
    function _typeof(){return "Treadmill"}
}

::Deathplane <- class extends Object_{
    constructor(_pos){
        base.constructor(_pos);
    }
    function draw(){
        drawSprite(sprDeathplane, 0, pos.x * SquareW + BoardStart.x, pos.y * SquareH + BoardStart.y)

    }
    function _typeof(){return "Deathplane"}
}

::onTreadmill <- function(_player){
    foreach (i in Actors) {
        if(typeof i == "Treadmill" && _player.pos.x == i.pos.x && _player.pos.y == i.pos.y){

            return true;
        }
    }

    return false;
}