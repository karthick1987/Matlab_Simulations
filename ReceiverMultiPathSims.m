L=10000;
cycles=50;
f=L/cycles;
i = 1:1:L;
Fs = sin(2*pi*i/f);
Fe = exp(-i/f);
Ft = Fe.*Fs;

delayVec = [100,400,5000];
AmpVec = [0.9,0.7,0.3];
[Fmp,Fsum] = createMultipath(Ft, delayVec,AmpVec);

uFmp = mean(Fmp,2)
uFsum = mean(Fsum,2)

cor = acf2(Fsum);

subplot(2,2,1);
plot(i,Fs,i,Fe);

subplot(2,2,2);
plot(i,Ft);

subplot(2,2,3);
hold on;
plot(i,Fmp(1,:),'Color',[0.8500,0.3250,0.0980]);
plot(i,Fmp(2,:),'Color', [0.4940 0.1840 0.5560]);
plot(i,Fmp(3,:),'g');
plot(i,Fsum,'Color', [0 0 0]);

subplot(2,2,4);
plot(i,cor);

function [Fmp,FmpSum] = createMultipath(Ft,delayVec,AmpVec)

Sd = size(delayVec);
Sa = size(AmpVec);

    if [Sd ~= Sa]
        Fmp = 0;
        return;
    end

[l,numEnt] = size(Ft);

Fmp = zeros(Sd(2),numEnt);

    for i = 1:Sd(2)
        delay = delayVec(i);
        Fmp(i,delay+1:end) = AmpVec(i)*Ft(1:end-delay);
    end

    FmpSum = sum(Fmp,1);
end