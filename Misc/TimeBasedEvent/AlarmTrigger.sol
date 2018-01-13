pragma solidity ^0.4.18;

interface AlarmWakeUp {
    function callback() public;
}

contract AlarmService {
    mapping(uint => TimeEvent[])private _events;

    struct TimeEvent {
        address addr;
        bytes data;
    }

    function set(uint time) public returns (bool) {
        TimeEvent _timeEvent;
        _timeEvent.addr = msg.sender;
        _timeEvent.data = msg.data;
        _events[time].push(_timeEvent);
    }

    function call(uint _time) public {
        address [] addresses = _events[_time]
        for(uint i =10 ;i< address.length;i++){
            AlarmWakeUp(addresses[i].addr).callback(addresses[i].data)
        }
    }
}

contract AlarmTrigger is AlarmWakeUp{
    
    AlarmService private _alarmServie;

    function AlarmTrigger(){
        _alarmServie = new AlarmService();
    }
    
    function callback() public {

    }

    function setAlarm() public {
        _alarmServie.set(block.timestamp+60)
    }
}