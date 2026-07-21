%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% File:
% CondLoss2Lzam.m
%
% Description:
% Estimates the average conduction power losses of the IGBTs and freewheeling
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

function [Pc1sw,Pc2sw,Pc1d,Pc2d]=CondLoss2Lzam(npp,Vce,Vf,iload,Va)

%-------------------------------------------------------------------------%
% Input parameters                                                        %
%-------------------------------------------------------------------------%
% npp    --> Total number of simulation points
% Vce    --> Collector-emitter saturation voltage
% Vf     --> Diode forward voltage drop
% iload  --> Load current
% Va     --> Phase output voltage

%-------------------------------------------------------------------------%
% Output parameters                                                       %
%-------------------------------------------------------------------------%
% Pc1sw  --> Average conduction power loss of IGBT S1
% Pc2sw  --> Average conduction power loss of IGBT S2
% Pc1d   --> Average conduction power loss of diode D1
% Pc2d   --> Average conduction power loss of diode D2

%-------------------------------------------------------------------------%
% Vector initialization                                                   %
%-------------------------------------------------------------------------%
Psw1=zeros(1,npp); Pd1=zeros(1,npp); Psw2=zeros(1,npp);  Pd2=zeros(1,npp);
iloadabs=zeros(1,npp); iloadabs=abs(iload);

%-------------------------------------------------------------------------%
% Conduction state evaluation and instantaneous power loss calculation    %
%-------------------------------------------------------------------------%
for cont=1:npp
%IGBT S1
    if Va(1,cont)>0 & iload(1,cont)>=0
        Psw1(1,cont)=Vce(1,cont)*iloadabs(1,cont);
    else
        Psw1(1,cont)=0;
    end
%Diode D1    
    if Va(1,cont)>0 & iload(1,cont)<0
        Pd1(1,cont)=Vf(1,cont)*iloadabs(1,cont); 
    else
        Pd1(1,cont)=0;
    end

%IGBT S2   
    if Va(1,cont)==0 & iload(1,cont)<0
        Psw2(1,cont)=Vce(1,cont)*iloadabs(1,cont);
    else
        Psw2(1,cont)=0;
    end
%Diode D2    
    if Va(1,cont)==0 & iload(1,cont)>=0
        Pd2(1,cont)=Vf(1,cont)*iloadabs(1,cont); 
    else
        Pd2(1,cont)=0;
    end    
end

%-------------------------------------------------------------------------%
% Average conduction power loss calculation                               %
%-------------------------------------------------------------------------%
%IGBT S1 and diode D1
Pc1sw=(sum(Psw1))/npp;
Pc1d=(sum(Pd1))/npp;
%IGBT S2 and diode D2
Pc2sw=(sum(Psw2))/npp;
Pc2d=(sum(Pd2))/npp;