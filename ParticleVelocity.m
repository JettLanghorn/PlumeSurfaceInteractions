function Vel = ParticleVelocity(gamma, M, mm, T0)
    R = 8.3144598/(mm*1000);
    Vel = sqrt(T0*gamma*R/(1+((gamma-1)/2)*(M^2)))*M;
end