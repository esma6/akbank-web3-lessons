// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;
import "./IERC20.sol"; 

interface IERC20 {
    function transfer(address, uint) external returns (bool);

    function transferFrom(
        address,
        address,
        uint
    ) external returns (bool);
}

contract CrowdFund {
    event Launch(
        uint id,
        address indexed creator,
        uint goal,
        uint32 startAt,
        uint32 endAt
    );
    event Cancel(uint id); // kampanyayi iptal etmek icin
    event Pledge(uint indexed id, address indexed caller, uint amount); //kampanyaya token gondermek icin
    event Unpledge(uint indexed id, address indexed caller, uint amount); //kampanyaya gonderilen tokeni degistirmek icin
    event Claim(uint id); //kampanya kurucusu kampanya başarılı olursa jetonları trasnfer edebilir
    event Refund(uint id, address indexed caller, uint amount); //kampanya amacina ulasmaza kullanicilar tokenlarini geri talep edebilir.

    //kampanyada tutmak istedigimiz bilgileri olusturuyoruz
    struct Campaign {
        address creator;
        uint goal;
        uint pledged;
        uint32 startAt;
        uint32 endAt;
        bool claimed;
    }

    IERC20 public immutable token;

    uint public count;
    mapping(uint => Campaign) public campaigns;
    mapping(uint => mapping(address => uint)) public pledgedAmount;

    constructor(address _token) {
        token = IERC20(_token);
    }

    function launch(
        uint _goal,
        uint32 _startAt,
        uint32 _endAt
    ) external {
        require(_startAt >= block.timestamp, "start at < now");
        require(_endAt >= _startAt, "end at < start at");
        require(_endAt <= block.timestamp + 90 days, "end at > max duration");

        count += 1;
        campaigns[count] = Campaign({
            creator: msg.sender,
            goal: _goal,
            pledged: 0,
            startAt: _startAt,
            endAt: _endAt,
            claimed: false
        });

        emit Launch(count, msg.sender, _goal, _startAt, _endAt);
    }

    function cancel(uint _id) external {
        Campaign memory campaign = campaigns[_id];
        require(campaign.creator == msg.sender, "not creator");
        require(block.timestamp < campaign.startAt, "started");

        delete campaigns[_id];
        emit Cancel(_id);
    }

    function pledge(uint _id, uint _amount) external {
        Campaign storage campaign = campaigns[_id];
        require(block.timestamp >= campaign.startAt, "not started"); //baslamamis bi kampanyaya token gonderilemez
        require(block.timestamp <= campaign.endAt, "ended");//bitmis bi kampanyaya token gonderilemez

        campaign.pledged += _amount;
        pledgedAmount[_id][msg.sender] += _amount; //kampanyaya gonderilen toplam tokeni tutuyoruz
        token.transferFrom(msg.sender, address(this), _amount);

        emit Pledge(_id, msg.sender, _amount);
    }

    function unpledge(uint _id, uint _amount) external {
        Campaign storage campaign = campaigns[_id];
        require(block.timestamp <= campaign.endAt, "ended"); //bitmis bi kampanyadan token geri alinamaz

        campaign.pledged -= _amount;
        pledgedAmount[_id][msg.sender] -= _amount;
        token.transfer(msg.sender, _amount);

        emit Unpledge(_id, msg.sender, _amount);
    }

    function claim(uint _id) external {
        Campaign storage campaign = campaigns[_id];
        require(campaign.creator == msg.sender, "not creator"); //kampanya kurucusu degilseniz jetonlar cekilemez
        require(block.timestamp > campaign.endAt, "not ended"); //kampanya bitmeden jetonlar cekilemez
        require(campaign.pledged >= campaign.goal, "pledged < goal");// kampanya amacına ulasmamissa jetonlar cekilemez
        require(!campaign.claimed, "claimed");

        campaign.claimed = true;
        // pleged kampanya kurucusuna transfer edilir
        token.transfer(campaign.creator, campaign.pledged);
        
        //claim eventi cagrilir
        emit Claim(_id);
    }

    function refund(uint _id) external {
        Campaign memory campaign = campaigns[_id];
        require(block.timestamp > campaign.endAt, "not ended");
        require(campaign.pledged < campaign.goal, "pledged >= goal");

        uint bal = pledgedAmount[_id][msg.sender];
        pledgedAmount[_id][msg.sender] = 0;
        token.transfer(msg.sender, bal);

        emit Refund(_id, msg.sender, bal);
    }
}
