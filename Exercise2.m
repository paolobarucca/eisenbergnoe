%BIG DATA FINANCE - EXERCISE 2

nbanks = 3; 
interbankLiabilitiesMatrix = [0 4  0; ...
                              0  0 3;... 
                              2 0  0];

externalAssets =      [20; 20; 10];
externalLiabilities = [17; 18; 8];
uniformShock = 0.1;

%new% 
shock = uniformShock*externalAssets;
externalAssetsShocked  =  externalAssets - shock;

[equityLoss equity equityZero paymentVector error] = eisenbergnoe(interbankLiabilitiesMatrix,externalAssetsShocked,externalLiabilities);

bdfplot(nbanks, equityZero, equityZero + shock, equity)