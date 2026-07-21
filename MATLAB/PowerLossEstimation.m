%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% File: 
% PowerLossEstimation.m
%
% Description:
% Main script responsible for configuring the simulation,
% executing the two-level three-phase inverter model,
% estimating semiconductor power losses,
% and generating the figure presented in the associated publication.
%
% Code Author:
% Diorge Alex Bao Zambra
%
% Related publication:
% Abdalla, L. M.; Conrado, P. H.; Rauber, A. R.; Colpo, L. R.;
% Bruschi, F.; Zambra, D. A. B.
% "Modeling and Analysis of a Liquid-Cooled Heat Sink for Inverters Used
% in Hybrid Electric Vehicles"
% Accepted for publication in IEEE Latin America Transactions.
%
%
% Institution:
% Instituto Hercílio Randon (IHR)
% Federal University of Rio Grande do Sul (UFRGS)
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

close all
clear all
clc

%-------------------------------------------------------------------------%
% Definition of the total number of simulation points                     %
%-------------------------------------------------------------------------%
mf=37;                        % Frequency modulation ratio
npp=1;                        % Number of fundamental periods
mp=150*2;                     % Number of points per sample
np=mf*npp;                    % Total number of samples
cp=np*mp;                     % Total number of simulation points

%-------------------------------------------------------------------------%
% Initialization of vectors                                                %
%-------------------------------------------------------------------------%
vrefa=zeros(1,cp); vrefb=zeros(1,cp); vrefc=zeros(1,cp); Vtri=zeros(1,cp); 
Vcmd1=zeros(1,cp); Vcmd2=zeros(1,cp); Vcmd3=zeros(1,cp); Vcmd4=zeros(1,cp);
Vcmd5=zeros(1,cp); Vcmd6=zeros(1,cp); van=zeros(1,cp); vbn=zeros(1,cp);
vcn=zeros(1,cp); vab=zeros(1,cp); vbc=zeros(1,cp); vca=zeros(1,cp);
iload=zeros(1,cp); iloadabs=zeros(1,cp); t=zeros(1,cp); Vce=zeros(1,cp);
Vf=zeros(1,cp); Eon=zeros(1,cp); Eoff=zeros(1,cp); Erec=zeros(1,cp);

%-------------------------------------------------------------------------%
% Simulation Parameters                                                     %
%-------------------------------------------------------------------------%
f=270;                               % Fundamental frequency
Vdc=1;                               % Normalized DC-link voltage
t=0:(0.00370370/(cp-1)):0.00370370;  % Simulation time
Vp=Vdc;                              % Peak voltage
Vpp=Vp*2;                            % Peak-to-peak voltage
FP=0.7265;                           % Power factor
fi=acos(FP);                         % Phase angle (rad)
ma=1;                                % Amplitude modulation index
teta=2*pi*f*t;                       % Current angle 
Ip= 237.5;                           % Peak current
iload=ma*Ip*sin(teta-fi);            % Load current
iloadabs=abs(iload);                 % Absolute value of the load current

%-------------------------------------------------------------------------%
% Semiconductor Electrical Characteristics                                 %
%-------------------------------------------------------------------------%
% FF225R12ME4_B11  (1200V/225A) 
%Vce x Ic (V)
Vce=(-0.00002.*iloadabs.*iloadabs)+(0.012.*iloadabs)+0.4698;
%Eon x Ic (J)
Eon=(0.0000004.*iloadabs.^3-0.0002.*iloadabs.^2+0.0726.*iloadabs+1.365).*0.001;
%Eoff x Ic (J)
Eoff=(-0.00004.*iloadabs.^2+0.128.*iloadabs+2.497).*0.001;
%Vf x Ic (V)
Vf=-0.00001.*iloadabs.^2+0.0075.*iloadabs+0.5424;
%Erec x Ic (J)
Erec=(0.0000003.*iloadabs.^3-0.0004.*iloadabs.^2+0.1555.*iloadabs+5.0536).*0.001;

%-------------------------------------------------------------------------%
% Inverter Simulation                                                     %
%-------------------------------------------------------------------------%
% Reference signals
vrefa=Vp*ma*sin(2*pi*f*t);
vrefb=Vp*ma*sin((2*pi*f*t)-(2*pi/3));
vrefc=Vp*ma*sin((2*pi*f*t)+(2*pi/3));
% Triangular carrier waveform
Vtri=triangzam(cp,f,mf,2,0,-1)+0.01;
% Gate command signals
[Vcmd1,Vcmd2] = VcmdInv2Lzam(cp,vrefa,Vtri);
[Vcmd3,Vcmd4] = VcmdInv2Lzam(cp,vrefb,Vtri);
[Vcmd5,Vcmd6] = VcmdInv2Lzam(cp,vrefc,Vtri);
% Phase voltages
van=(Vcmd1*Vdc);
vbn=(Vcmd3*Vdc);
vcn=(Vcmd5*Vdc);
% Line-to-line voltages
vab=van-vbn;
vbc=vbn-vcn;
vca=vcn-van;

%-------------------------------------------------------------------------%
% Power Loss Estimation Phase A                                           %
%-------------------------------------------------------------------------%
% Conduction losses
[Pc1sw,Pc2sw,Pc1d,Pc2d]=CondLoss2Lzam(cp,Vce,Vf,iload,van);
Pcondsw=Pc1sw+Pc2sw;
Pcondd=Pc1d+Pc2d;
Pcondt=Pcondsw+Pcondd;
% Turn-on losses
[Pon1,Pon2]=PonLoss2Lzam(cp,f,Eon,iload,Vcmd1,Vcmd2);
Pont=Pon1+Pon2;
% Turn-off losses
[Poff1,Poff2]=PoffLoss2Lzam(cp,f,Eoff,iload,Vcmd1,Vcmd2);
Pofft=Poff1+Poff2;
% Reverse recovery losses
[Prec1d,Prec2d]=PrecLoss2Lzam(cp,f,Erec,iload,Vcmd1,Vcmd2);
Prect=Prec1d+Prec2d;
PtotM1=(Pcondt+Pont+Pofft+Prect);
Pigbt1=Pc1sw+Pon1+Poff1;
Pdiode1=Pc1d+Prec1d;
PtotM1*3;
PerdasM= [Pcondsw Pcondd Pont Pofft Prect];
Perdas1=[Pc1sw Pon1 Poff1 Pc1d Prec1d];

%-------------------------------------------------------------------------%
% Figure                                                                  %
%-------------------------------------------------------------------------%
close all
%Tl 
set(gca,'color','none')
set(gcf,'renderer','Painters')

set(gca,'color','none')
figure (1)
    x0=5;
    y0=5;
    width=8;
    height=7;
    pos = 'best';
    font = 8;
    set(gcf,'Units','centimeters','position',[x0,y0,width,height])
    set(gcf,'PaperPositionMode','auto')
    set(gca, 'FontSize', 6)
    set(0,'DefaultAxesFontSize', 6)
    set(0, 'defaultAxesTickLabelInterpreter','latex');
    set(0, 'defaultLegendInterpreter','latex');
    set(gca, 'FontName', 'Times New Roman');

ylim([0 150])
categorias = {'Conduction IGBT', 'Turn-on', 'Turn-off', 'Conduction Diode', 'Reverse-recovery'};
bar(categorias, Perdas1, 'FontSize', 8)
ylabel('Power Losses (W)')

