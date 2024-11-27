# Use Node.js as the base image
FROM node:18-slim

# Set the working directory inside the container
WORKDIR /usr/src/app

# Install global dependencies
RUN npm install -g hardhat

# Copy backend and frontend source code
COPY backend ./backend
COPY frontend ./frontend

# Install backend dependencies and compile contracts
WORKDIR /usr/src/app/backend
RUN npm install && npx hardhat compile

# Install frontend dependencies
WORKDIR /usr/src/app/frontend
RUN npm install

# Prepare export directory
WORKDIR /usr/src/app
RUN mkdir -p /export && cp -r backend frontend /export

# Default command for running the container
CMD ["bash", "-c", "cp -r /usr/src/app/backend /usr/src/app/frontend /export"]

# sudo npx hardhat compile
# sudo npx hardhat node
# sudo npx hardhat run scripts/deploy.js --network localhost
# npm start

# Build docker images
# docker build -t solidity-project-template .

# Export docker image
# docker load -i solidity-project-template.tar
# Validate docker image
# docker images
# install the docker image tar
# docker save -o solidity-project-template.tar solidity-project-template

# execution on mac
# docker run --rm -v "$(pwd):/export" solidity-project-template

# execution on windows
# docker run --rm -v "%cd%:/export" solidity-project-template

# execution on powershell
# docker run --rm -v "%cd%:/export" solidity-project-template