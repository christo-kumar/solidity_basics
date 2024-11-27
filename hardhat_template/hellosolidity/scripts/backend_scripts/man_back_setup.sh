#1. open folder hellosolidity inside hardhat_template folder

#2. cd into backend
cd backend

#3. make sure node is installed, validate the by checking version
npm -v

#4. install hardhat if not installed
npm install --save-dev hardhat

#5. do npm install
npm install

#6. compile smartcontracts
sudo npx hardhat compile
sudo npx hardhat node
#create new terminal window
sudo npx hardhat run scripts/deploy.js --network localhost

# Now configure the metamask wallet and import accounts
