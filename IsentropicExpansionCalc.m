function Me = IsentropicExpansionCalc(gamma,dstar,de)
    ML = 1;             %Lower Bound for M
    MU = 100;           %Upper Bound for M
    
    Ardes = (de/dstar)^2;   %Calculating the Desired Area Ratio
    
    %Constructing a solution matrix where the first column will consist of Mach
    %numbers and the second will consist of their corresponding area ratios.
    %The first row will be the lower limit, the last will be the upper limit,
    %and the middle will be our guess.
    Sol = zeros(3,2);
    Sol(1,1) = ML;
    Sol(3,1) = MU;
    Sol(1,2) = ARCalc(gamma, Sol(1,1));
    Sol(3,2) = ARCalc(gamma, Sol(3,1));
    
    %The loop will guess a M right in the middle of the upper and lower bounds.
    % Then it will calculate the AR.  If the AR is greater than the desired AR,
    % the guessed M will be the new upper bound and vise versa.  This will
    % continue until the error between the calculated AR and the desired Ar is
    % less than 0.000001.
    while abs(Sol(2,2)-Ardes) > 0.000001
        Sol(2,1) = (Sol(3,1)+Sol(1,1))/2;
        Sol(2,2) = ARCalc(gamma, Sol(2,1));
        if (Sol(2,2)-Ardes) == abs(Sol(2,2)-Ardes)
            Sol(3,:) = Sol(2,:);
        else
            Sol(1,:) = Sol(2,:);
        end
    end
    Me = Sol(2,1);
end

function Ar = ARCalc(gamma, M)
    Ar = ((gamma+1)/2)^(-(gamma+1)/(2*(gamma-1)))*((1+((gamma-1)/2)*(M^2))^((gamma+1)/(2*(gamma-1))))/M;
end