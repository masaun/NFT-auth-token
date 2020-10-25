# NFT based Auth Token

***
## 【Introduction of NFT based Auth Token】
- This is the smart contract that NFT is used for the ACL management.

<br>

- NFT Auth Token works as a ACL Token.
  - If an user who has a NFT Auth Token, that user can access contents which is permitted. 
    (Admin has tokenID=1 of NFT Auth Token, User has tokenID that is greater than 2 of NFT Auth Token. Depends on tokenID, accessable contents level are different)
  - Login by being verified (checked) whether user has a NFT Auth Token or not.

<br>

## 【Remaining task (Future implementation)】
- Login
  - When user register, user upload a their profile picture onto IPFS. After that, user get IPFS hash of the uploaded image. That IPFS hash is used as one of condition of login.
  - Also I want to add SSI (Ethr-DID-registry of uPort) verification system for login.

<br>

- Add a pool for staking and earning interest for users (who buy a ticket which NFT Auth Token is embed).
  - I assume that this situation is like a user buy ticket for subscription contents, fun, etc...
  - Utilize mUSD of mStable for depositing into the Pool (earning interst in the Pool / redeeming from Pool, as well)

<br>


## 【Teck Stack】
- Solidity (solc) v0.6.12
- Truffle v5.1.49
- web3.js v1.2.1
- Node.js v11.15.0


&nbsp;

***

## 【Setup】
1. Npm install
```
$ npm install
```

<br>


2. Migrate
```
$ npm run migrate:kovan
```

&nbsp;


## 【Script】(on Kovan testnet)
1. Create a new NFT Auth Token
```
$ npm run script:NftAuthTokenManager
```

2. Mint a new Auth Token ID for user who is called. After that, system check verification whether user who is called has NFT Auth Token (Token ID) or not.
```
$ npm run script:NftAuthToken
```

3. (Future implementaion)
```
$ npm run script:PoolWithNftAuthToken
```


&nbsp;


## 【Test】
- Testing for all contract (※ `Kovan test network` ) <= This test is in progress
```
$ npm run test:kovan
```


<br>

***

## 【References】
- [NFT]
  - Openzepplin document for ERC721



- [mStable]:
  -
  -


- [Ethr-DID-Registry]
  - 


<br>


- [Untitled: NFT Hackathon]:
  - Website
    
  
  - Information
    https://metaforce.substack.com/p/introducing-untitled-nft-hackathon
    https://twitter.com/NFT_hack 
    https://medium.com/ethplanet/ethplanet-hackathon-building-the-next-digital-world-2d0246027d78
