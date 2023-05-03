function Visc = LeonardJones(angstrom, kBE, mm, T)
    Tstar = kBE*T;
    Omega = 1.16145*(Tstar)^-0.14874+0.52487*exp(-0.77320*Tstar)+2.16178*exp(-2.43787*Tstar);
    Visc = (5/(16*(pi^0.5)))*(((mm*1000/(6.02214*10^23))*(1.380649*10^(-23))*T)^0.5)/(((angstrom/(10^10))^2)*Omega);
end