%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% File:
% PrecLoss2Lzam.m
%
% Description:
% Estimates the average reverse-recovery power losses of the freewheeling
% diodes for one phase of a conventional two-level three-phase voltage
% source inverter.
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

function [Prec1,Prec2]=PrecLoss2Lzam(npp,f,Erec,iload,Vcmd1,Vcmd2)

%-------------------------------------------------------------------------
% Input parameters
%-------------------------------------------------------------------------
% npp    --> Total number of simulation points
% f      --> Fundamental frequency
% Erec   --> Reverse-recovery energy
% iload  --> Load current
% Vcmd1  --> Gate command signal of switch S1
% Vcmd2  --> Gate command signal of switch S2

%-------------------------------------------------------------------------
% Output parameters
%-------------------------------------------------------------------------
% Prec1  --> Average reverse-recovery power loss of diode D1
% Prec2  --> Average reverse-recovery power loss of diode D2

%-------------------------------------------------------------------------%
% Vector initialization                                                   %
%-------------------------------------------------------------------------%
Prec1d=zeros(1,npp-1); Prec2d=zeros(1,npp-1);

%-------------------------------------------------------------------------
% Reverse-recovery event detection and energy accumulation
%-------------------------------------------------------------------------
for cont=1:npp-1
    %Diode D1
    if Vcmd1(1,cont)>=1 & Vcmd1(1,cont+1)<=0 & iload(1,cont)<0 
        Prec1d(1,cont)=Erec(1,cont);
    else
        Prec1d(1,cont)=0;
    end
    
    %Diode D2
    if Vcmd2(1,cont)>=1 & Vcmd2(1,cont+1)<=0 & iload(1,cont)<0
        Prec2d(1,cont)=Erec(1,cont);
    else
        Prec2d(1,cont)=0;
    end
end

%-------------------------------------------------------------------------%
% Average reverse-recovery power loss calculation                         %
%-------------------------------------------------------------------------%
Prec1=(sum(Prec1d))/(1/f);
Prec2=(sum(Prec2d))/(1/f);















