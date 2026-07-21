%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% File:
% PonLoss2Lzam.m
%
% Description:
% Estimates the average turn-on switching power losses of the IGBTs for one
% phase of a conventional two-level three-phase voltage source inverter.
%
% Code Author:
% Diorge Alex Bao Zambra
%
% Affiliations:
% Instituto Hercílio Randon (IHR)
% Federal University of Rio Grande do Sul (UFRGS)
%
% Associated Publication:
% Abdalla, L. M.; Conrado, P. H.; Rauber, A. R.; Colpo, L. R.;
% Bruschi, F.; Zambra, D. A. B.
% "Modeling and Analysis of a Liquid-Cooled Heat Sink for Inverters Used
% in Hybrid Electric Vehicles"
% Accepted for publication in IEEE Latin America Transactions.
%
% MATLAB Version:
% R2025b
%
% License:
% MIT License
%
% Date:
% December 2025
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [Pon1,Pon2]=PonLoss2Lzam(npp,f,Eon,iload,Vcmd1,Vcmd2)

%-------------------------------------------------------------------------%
% Input parameters                                                        %
%-------------------------------------------------------------------------%
% npp    --> Total number of simulation points
% f      --> Fundamental frequency
% Eon    --> Turn-on switching energy
% iload  --> Load current
% Vcmd1  --> Gate command signal of switch S1
% Vcmd2  --> Gate command signal of switch S2

%-------------------------------------------------------------------------%
% Output parameters                                                       %
%-------------------------------------------------------------------------%
% Pon1   --> Average turn-on switching power loss of IGBT S1
% Pon2   --> Average turn-on switching power loss of IGBT S2

%-------------------------------------------------------------------------%
% Vector initialization                                                   %
%-------------------------------------------------------------------------%
Pon1sw=zeros(1,npp-1); Pon2sw=zeros(1,npp-1);

%-------------------------------------------------------------------------%
% Turn-on switching event detection and energy accumulation               %
%-------------------------------------------------------------------------%
for cont=1:npp-1
%IGBT S1
    if iload(1,cont)>=0 & Vcmd1(1,cont)<=0 & Vcmd1(1,cont+1)>=1
        Pon1sw(1,cont)=Eon(1,cont);
    else
        Pon1sw(1,cont)=0;
    end
    
%IGBT S2      
    if iload(1,cont)<0 & Vcmd2(1,cont)<=0 & Vcmd2(1,cont+1)>=1
        Pon2sw(1,cont)=Eon(1,cont);
       else
        Pon2sw(1,cont)=0;
    end
end

%-------------------------------------------------------------------------%
% Average turn-on power loss calculation                                  %
%-------------------------------------------------------------------------%
Pon1=(sum(Pon1sw))/(1/f); %IGBT S1
Pon2=(sum(Pon2sw))/(1/f); %IGBT S2















