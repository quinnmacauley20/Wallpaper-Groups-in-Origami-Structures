% The projection function solves the a + r*(cos(alpha) + i*sin(alpha)) 
% = b + s*(cos(beta) + i*sin(beta)) equation like the tau function,
% however, in this case, a = alpha = 0. So, the function is solving
% the equation r = b + s*(cos(beta) + i*sin(beta)) for a list of 
% possible betas and b's by separating the real and complex 
% parts and solving them using linear algebra.

% parameters: vector of angle measures and a vector of points
    
% output: a vector that contains the unique set of projections

function [real_projections] = projection(points, angles)

    lnth_points = length(points);       % number of points inputted
    
    % removes 0 as a possible angle
    angles_wo_zero = angles(angles ~= 0);
    
    % number of angles (not including 0) inputted
    lnth_angles = length(angles_wo_zero);  

    % empty storage vector for max number of outputs initialization    
    output = zeros(lnth_points*lnth_angles, 1);

    v = 0;      % counter variable initialization
    
    for k = 1:lnth_points
        
        p = points(k);      % point used for calculation
        
        for j = 1:lnth_angles

            v = v + 1;      % updates count
            
            beta = angles_wo_zero(j);  % angle used for calculation
                
            % inputs the complex values into the system matrix
            system_matrix = [1 -cos(beta); 0 -sin(beta)];
            
            seed_pt_vctr = [real(p); imag(p)];  % inputs seed points
                        
            % solution to system
            solution_vctr = system_matrix\seed_pt_vctr;

            % adds projection calculation to storage vector
            output(v) = solution_vctr(1);
            
        end
    end
    
    % outputted unique set of projections
    real_projections = unique(output);      

end
