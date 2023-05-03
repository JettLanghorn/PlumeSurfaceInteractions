function PLoss = NormalShockPLoss(gamma, M)
    PLoss = (((gamma+1)*(M^2))/((gamma-1)*(M^2)+2))^(gamma/(gamma-1))*((gamma+1)/(2*gamma*(M^2)-(gamma-1)))^(1/(gamma-1));
end