function T = TempCalc(gamma, M, T0)
    T = T0/(1+((gamma-1)/2)*(M^2));
end