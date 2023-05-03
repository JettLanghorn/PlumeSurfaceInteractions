clc; clear;

Ps = 101000;     %Static Pressure in reservoir (Pa)
gamma = 1.4;        %Specific Heat Ratio
dstar = 0.125;      %Throat diameter (in)
de = 0.843;         %Plume Diameter (in)
mm = 28.02;         %Molar Mass of the gas in g/mol
T0 = 293;           %Reservior Temperature in K
angstrom = 3.667;
kBE = 99.8;


M = IsentropicExpansionCalc(gamma,dstar,de);
PLoss = NormalShockPLoss(gamma,M);
Pexp = Ps*PLoss;

%Calculating the expected force on the plate (N)
Fexp = Pexp*(pi/4)*(de^2)*(0.0254);

vel = ParticleVelocity(gamma,M,mm,T0);
T = TempCalc(gamma, M, T0);
%Visc = LeonardJones(angstrom, kBE, mm, T);
