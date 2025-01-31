### Смарт-контракт для краудфандинга 
Смарт контракт повзволяет создавать краудфандинговые кампании.
Возможности взаимодействия с контрактом:
- создать кампанию с навзанием, ID, описанием и целью по собираемым средствам (ETH)
- внести деньги в кампанию (любой пользователь)
- закрыть кампанию, переведя ее в состояние неактивной. Тогда нельзя будет присылать ETH в кампанию. Доступно только создателю кампании
- просмотреть информацию о кампании с определенным ID

Инструкция по установке зависимостей:

- Установить Node.js версии >= 18
- npm install --save-dev hardhat
- npm install --save-dev @nomicfoundation/hardhat-toolbox
- Установить python 3
- pip install flask
- добавить в метамаск пользовательскую сеть: имя-hardhat, url-127.0.0.1:8545,id-31337,валюта-ETH

Запуск:

- npx hardhat node(терминал 1)
- npx hardhat ignition deploy ignition/modules/Crowdfunding.js --network localhost(терминал 2)
- проверить, что CONTRACT_ADDRESS из файла index.html совпадает с адресом в терминале 2
- python3 app.py (терминал 3)
- открыть в браузере http://127.0.0.1:5000/
- добавить в метамаск любой аккаунт из локальной сети hardhat (перечислены в терминале 1)
- кликнуть connect Wallet

