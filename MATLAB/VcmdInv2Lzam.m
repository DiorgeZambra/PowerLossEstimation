%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% File:
% VcmdInv2Lzam.m
%
% Description:
% Generates the gate command signals for one phase-leg of a conventional
% two-level three-phase voltage source inverter using carrier-based PWM.
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

function [Vcmd1,Vcmd2] = VcmdInv2Lzam(npp,vref,port)

%-------------------------------------------------------------------------%
% Input parameters                                                        %
%-------------------------------------------------------------------------%
% npp   --> Total number of simulation points
% vref  --> Reference voltage signal
% port  --> Triangular carrier signal

%-------------------------------------------------------------------------%
% Output parameters                                                       %
%-------------------------------------------------------------------------%
% Vcmd1 --> Gate command signal of upper switch S1
% Vcmd2 --> Gate command signal of lower switch S2


%-------------------------------------------------------------------------%
% Vector initialization                                                   %
%-------------------------------------------------------------------------%
Vcmd1=zeros(1,npp); Vcmd2=zeros(1,npp);

%-------------------------------------------------------------------------
% PWM comparison and gate signal generation
%-------------------------------------------------------------------------
for cont=1:npp
    if vref(1,cont)>=port(1,cont)
        Vcmd1(1,cont)=1;
        Vcmd2(1,cont)=0;
    end
    if vref(1,cont)<port(1,cont)
        Vcmd1(1,cont)=0;
        Vcmd2(1,cont)=1;
    end
end