function [equityLoss equity equityZero paymentVector error] = eisenbergnoe(interbankLiabilitiesMatrix,externalAssets,externalLiabilities)

% PB for BDF2017
%[2] Eisenberg, Larry, and Thomas H. Noe.  "Systemic risk in financial systems." Management Science 47, no. 2 (2001): 236-249.
%interbankLiabilitiesMatrix => L 
%A => A
%externalAssets => Ae
%externalLiabilities => Le
%exogenousRecoveryRate => R

L = interbankLiabilitiesMatrix;
A = L';
Ae = externalAssets;
Le = externalLiabilities;


epsilon = 10^(-5);
max_counts = 10^5;

nbanks = length(L);


l = sum(L,2);

equityZero = Ae - Le + sum(A,2) - l;

equity = equityZero;

error = 1;
counts = 1;

while (error > epsilon)&&(counts < max_counts)
    
    oldEquity = equity;
    recoveryVector = ones([nbanks 1]).*((equity>=0) + (max(1 + equity./l,0) ).*(equity<0));
    equity = Ae - Le + A*(recoveryVector) - l; 
     
    error = norm(equity - oldEquity)/norm(equity);
    counts = counts +1;
end

recoveryVector = ones([nbanks 1]).*((equity>=0) + (max(1 + equity./l,0) ).*(equity<0));

equity = Ae - Le + A*(recoveryVector) - l;

paymentVector = max(0,min( Ae - Le + A*recoveryVector, l)); 

equityLoss = equity - equityZero;