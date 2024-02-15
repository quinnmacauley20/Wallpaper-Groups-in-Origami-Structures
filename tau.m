% The tau function solves the a + r*(cos(alpha) + i*sin(alpha)) = 
% b + s*(cos(beta) + i*sin(beta)) equation for a list of possible 
% alpha and betas and a given a and b by separating the real and 
% complex parts and solving them using linear algebra.
    
% parameters: vector of angle measures and a and b as seed points
    
% output: a vector that contains the unique set of projections

function [unique_tau] = tau(angles, a, b)     
    
    n = length(angles);     % number of angles inputted
    
    % empty storage vector for max number of outputs initialization
    output = zeros(nchoosek(n, 2), 2);

    v = 0;      % counter variable initialization
    
    for k = 1:n
        
        alpha = angles(k);      % first angle used

        for j = k+1:n

            v = v + 1;      % updates count
            
            beta = angles(j);       % second angle used
            
            % inputs the angles into a system matrix
            system_mat = [cos(alpha) -cos(beta); sin(alpha) -sin(beta)];
            
            % inputs seed points
            seed_pt_vctr = [real(b) - real(a); imag(b) - imag(a)];
            
            % solution to system
            solution_vctr = system_mat\seed_pt_vctr;
            
            % tau calculation using the solution vector
            tau_calc = [cos(alpha) 0; sin(alpha) 0] * ...
            solution_vctr + [real(a); imag(a)];
            
            % adds tau calculation to storage vector
            output(v, :) = tau_calc';

        end
    end 
    
    % unique set of taus (repeats are common in this calculation)
    unique_output = unique(output, 'rows');
    
    % rearranges data as complex numbers as a column vector for output
    unique_tau = unique_output(:, 1) + unique_output(:, 2)*1i;

end
