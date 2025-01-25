// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Crowdfunding {
    // Структура для хранения информации о цели
    struct Campaign {
        string name;        // Название цели
        string description; // Описание цели
        address payable owner; // Создатель цели
        uint256 target;     // Целевая сумма
        uint256 funds;      // Собранная сумма
        bool active;        // Статус кампании
    }

    // Массив для хранения всех кампаний
    Campaign[] public campaigns;

    // Маппинг для отслеживания вкладов каждого участника
    mapping(uint256 => mapping(address => uint256)) public contributions;

    // События
    event CampaignCreated(uint256 campaignId, string name, uint256 target);
    event DonationReceived(uint256 campaignId, address donor, uint256 amount);
    event FundsWithdrawn(uint256 campaignId, uint256 amount);

    // Создание новой цели для сбора
    function createCampaign(
        string memory name,
        string memory description,
        uint256 target
    ) public {
        require(target > 0, "Target amount must be greater than zero");

        Campaign memory newCampaign = Campaign({
            name: name,
            description: description,
            owner: payable(msg.sender),
            target: target,
            funds: 0,
            active: true
        });

        campaigns.push(newCampaign);

        emit CampaignCreated(campaigns.length - 1, name, target);
    }

    // Внести средства в указанную кампанию
    function donate(uint256 campaignId) public payable {
        require(campaignId < campaigns.length, "Campaign does not exist");
        Campaign storage campaign = campaigns[campaignId];
        require(campaign.active, "Campaign is not active");
        require(msg.value > 0, "Donation amount must be greater than zero");

        // Обновление собранных средств
        campaign.funds += msg.value;

        // Сохранение вклада для данного пользователя
        contributions[campaignId][msg.sender] += msg.value;

        emit DonationReceived(campaignId, msg.sender, msg.value);
    }

    // Вывод собранных средств владельцем кампании
    function withdrawFunds(uint256 campaignId) public {
        require(campaignId < campaigns.length, "Campaign does not exist");
        Campaign storage campaign = campaigns[campaignId];
        require(msg.sender == campaign.owner, "Only the owner can withdraw funds");
        require(campaign.funds > 0, "No funds to withdraw");

        uint256 amount = campaign.funds;

        // Обнуление собранных средств
        campaign.funds = 0;

        // Отправка средств владельцу
        campaign.owner.transfer(amount);

        emit FundsWithdrawn(campaignId, amount);
    }

    // Получить информацию о кампании
    function getCampaign(uint256 campaignId)
        public
        view
        returns (
            string memory name,
            string memory description,
            address owner,
            uint256 target,
            uint256 funds,
            bool active
        )
    {
        require(campaignId < campaigns.length, "Campaign does not exist");
        Campaign memory campaign = campaigns[campaignId];
        return (campaign.name, campaign.description, campaign.owner, campaign.target, campaign.funds, campaign.active);
    }

    // Деактивировать кампанию
    function deactivateCampaign(uint256 campaignId) public {
        require(campaignId < campaigns.length, "Campaign does not exist");
        Campaign storage campaign = campaigns[campaignId];
        require(msg.sender == campaign.owner, "Only the owner can deactivate the campaign");

        campaign.active = false;
    }
}
