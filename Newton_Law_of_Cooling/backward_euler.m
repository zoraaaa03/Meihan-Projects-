function [t, y] = backward_euler(f, tspan, ic, nsteps)
    % Extract t0 and tf from tspan
    t0 = tspan(1);
    tf = tspan(2);
    
    % Calculate uniform step size h
    h = (tf - t0) / nsteps;
    
    % Create placeholder vectors for t and y
    t = zeros(nsteps + 1, 1);
    y = zeros(nsteps + 1, length(ic));
    
    % Set initial values
    t(1) = t0;
    y(1, :) = ic;
    
    % Perform Backward Euler iterations
    for i = 1:nsteps
        t(i+1) = t(i) + h;
        
        % Define the implicit equation to solve for y(i+1)
        % Using fzero to solve the implicit equation
        y(i+1, :) = fzero(@(y_new) y_new - y(i, :) - h * f(t(i+1), y_new), y(i, :));
    end
end
%% 
