%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% File:
% triangzam.m
%
% Description:
% Generates a triangular carrier waveform for sinusoidal pulse width
% modulation (SPWM).
%
% The function allows the generation of a triangular waveform with 
% adjustable carrier frequency ratio, amplitude, phase shift, and offset.
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

function [ytrip] = triangzam(npp,f,mf,Vpp,defas,ini)

%-------------------------------------------------------------------------%
% Input parameters                                                        %
%-------------------------------------------------------------------------%
% npp   --> Total number of simulation points
% f     --> Fundamental frequency
% mf    --> Carrier frequency ratio
% Vpp   --> Peak-to-peak value of the triangular waveform
% defas --> Phase shift angle
% ini   --> DC offset
%
%-------------------------------------------------------------------------%
% Output parameters                                                       %
%-------------------------------------------------------------------------%
% ytrip --> Triangular carrier waveform

%-------------------------------------------------------------------------%
% Vector initialization                                                   %
%-------------------------------------------------------------------------%
ytrip=zeros(1,npp);

%-------------------------------------------------------------------------%
% Triangular waveform parameters                                          %
%-------------------------------------------------------------------------%
Ttri=1/(f*mf);              % Triangular carrier period
ms=Vpp/(Ttri/2);            % Triangular waveform slope
xtri=0:(1/f/(npp-1)):1/f;   % Time vector
cot=2;                      % Initial position index

%-------------------------------------------------------------------------%
% Initial condition calculation considering phase shift                   %
%-------------------------------------------------------------------------%
if defas==0
    defasy=ini;
end
if defas>0 & defas<180
    defasy=ini+(ms*(xtri(fix((((npp)/(mf*2))*defas)/180))));
end
if defas==180
    defas2=0;
    defasy=ini;
end
if defas>180
    defas2=defas-180;
    defasy=ini-(ms*(xtri(fix((((npp)/(mf*2))*defas2)/180))));
end


ytrip(1)=defasy;
prim=1;
%-------------------------------------------------------------------------%
% Triangular waveform generation for phase shifts from 0 to 180 degrees   %
%-------------------------------------------------------------------------%
if defas>=0 & defas<180
while (mf*2)+1> prim
  if prim==1
      for cont=2:((npp)/(mf*2))-fix((((npp)/(mf*2))*defas)/180)
            ytrip(1,cot)=ytrip(1,cot-1)+ ms*(xtri(1,cot)-xtri(1,cot-1));
            cot=cot+1;
      end
      prim=prim+1;  
  end  
  if prim/2~=fix(prim/2)
      for cont=1:(npp)/(mf*2)
            ytrip(1,cot)=ytrip(1,cot-1)+ ms*(xtri(1,cot)-xtri(1,cot-1));
            cot=cot+1;
      end
      prim=prim+1;  
  end       
   ytrip(1,cot)=ytrip(1,cot-1);
  if prim/2==fix(prim/2) & prim<((mf*2)+1)
      for cont=1:(npp)/(mf*2)
            ytrip(1,cot)=ytrip(1,cot-1)-ms*(xtri(1,cot)-xtri(1,cot-1));
            cot=cot+1;
      end
      prim=prim+1;
  end
  if prim==((mf*2)+1)
      for cont=2:fix((((npp)/(mf*2))*defas)/180)
            ytrip(1,cot)=ytrip(1,cot-1)+ ms*(xtri(1,cot)-xtri(1,cot-1));
            cot=cot+1;
      end 
      prim=prim+1;
  end
end  
end

%-------------------------------------------------------------------------%
% Triangular waveform generation for phase shifts from 180 to 360 degrees %
%-------------------------------------------------------------------------%
if defas>=180
while (mf*2)+1> prim
  if prim==1
      for cont=2:((npp)/(mf*2))-fix((((npp)/(mf*2))*defas2)/180)
            ytrip(1,cot)=ytrip(1,cot-1)- ms*(xtri(1,cot)-xtri(1,cot-1));
            cot=cot+1;
      end
      prim=prim+1;  
  end  
  if prim/2~=fix(prim/2)
      for cont=1:(npp)/(mf*2)
            ytrip(1,cot)=ytrip(1,cot-1)- ms*(xtri(1,cot)-xtri(1,cot-1));
            cot=cot+1;
      end
      prim=prim+1;  
  end       
   ytrip(1,cot)=ytrip(1,cot-1);
  if prim/2==fix(prim/2) & prim<((mf*2)+1)
      for cont=1:(npp)/(mf*2)
            ytrip(1,cot)=ytrip(1,cot-1)+ms*(xtri(1,cot)-xtri(1,cot-1));
            cot=cot+1;
      end
      prim=prim+1;
  end
  if prim==((mf*2)+1)
      for cont=2:fix((((npp)/(mf*2))*defas2)/180)
            ytrip(1,cot)=ytrip(1,cot-1)- ms*(xtri(1,cot)-xtri(1,cot-1));
            cot=cot+1;
      end 
      prim=prim+1;
  end
end  
end




