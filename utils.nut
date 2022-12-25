::Vec2d <- class{
    x = 0;
    y = 0;

    constructor(_x,_y){
        x = _x;
        y = _y;

    }
    function _add(other){
        return Vec2d(x + other.x, y + other.y);
    }
    function _sub(other){
        return Vec2d(x - other.x, y - other.y);
    }
    function _mul(other){
        return Vec2d(x * other.x, y * other.y);
    }
    function _div(other){
        return Vec2d(x / other.x, y / other.y);
    }
    function norm(){
        local mag = sqrt(pow(x, 2) + pow(y, 2));
        local unitVec = Vec2d(x/mag, y / mag)
        return unitVec;
    }
}

::Timer <- class
{
    timer = 0
    times_up = false
    constructor(_timer)
    {
        timer = _timer
    }
    function wait()
    {
        if(timer > -1) timer--
        if(timer <= 0) return false
        else
        {
            times_up = true
            return true
        }
    }
}

::posMod <- function (n,m){
    if (n>=0) {
      return n%m;
    }
    else {
      return m-abs(n)%m;
    }
}

::removeActor <- function(_list, _instance){
    foreach(a,i in _list){
        if(i == _instance){
            _list.remove(a)
        }
    }
}