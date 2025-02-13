function [ ] = cooling_model(k,n,tsim,Tsys,Tenv, flag)
  % k     Cooling constant [1/min]
  % n        Number of time steps 
  % tsim  Time interval for simulation  [minutes]
  % Tsys    Initial temperature of system [degC]
  % Tenv  Temperature of surrounding environment  [degc]
  
  % flag == 1     % Plot Analytic solution only for T vs t
  % flag == 2     % Plot of ode45 for T vs t
  % flag == 3    % Plot of forward euler for T vs t
  %flagC == 4   % Plot of backward euler for T vs t
  
  
 
  t = linspace(0,tsim,n);      % time
  dt = t(2) - t(1);            % time increment
  T = zeros(1,n);              % system temperature as a function of time
  K = dt * k;                  % Constant
  T(1) = Tsys;                 % Initial temperature of system

% CALCULATIONS ===========================================================

% Numerical computation

  f_ode = @(t, T) -k * (T - Tenv);

  %sole using ode45
  [t_ode23, T_ode23] = ode23(f_ode,[0,tsim],Tsys);
  [t_ode45, T_ode45] = ode45(f_ode, [0 tsim], Tsys);
  [t_forward_euler, T_forward_euler] = forward_euler_vec(f_ode, [0 tsim], Tsys, n);
  [t_backward_euler, T_backward_euler] = backward_euler(f_ode, [0 tsim], Tsys, n);
    
   
   
 % Analytical computation
   TA = Tenv + (Tsys - Tenv) .* exp(-k.*t);
 
 % Command Window Output  ===============================================
 disp('   ');
 disp('   ');
 fprintf('Cooling constant               k  = %2.3e   [1/min]  \n',k);
 disp('   ');
 fprintf('Number of time steps           n  = %4.0f  \n',n);
 disp('   ');
 fprintf('Time interval for simulation   tsys  = %4.0f   [min]  \n',tsim);
 disp('   ');
 fprintf('Environmental temperature      Tenv  = %4.2f   [degC]  \n',Tenv);
 disp('   ');
 fprintf('Initial temperature of system  T0  = %4.2f   [degC]  \n',Tsys);

 
  
% GRAPHICS ==============================================================

% Plot based on flag
    switch flag
        case 1
            % Plot Analytic soln for T vs t
            figure;
            plot(t, TA, 'b-', 'LineWidth', 2);
            xlabel('Time [min]');
            ylabel('Temperature [degC]');
            title('Analytic soln');
            legend('analytic solution');
            grid on;
        case 2
            % Plot of numerical  solutions for T vs t
            figure;
            plot(t_ode23, T_ode23, 'b-', 'LineWidth', 2);
            xlabel('Time [min]');
            ylabel('Temperature [degC]');
            title('Numerical soln ode23');
            grid on;
        case 3
            % Plot of numerical  solutions for T vs t
            figure;
            plot(t_ode45, T_ode45, 'b-', 'LineWidth', 2);
            xlabel('Time [min]');
            ylabel('Temperature [degC]');
            title('Numerical soln ode45');
            grid on;
        case 4
              % Plot of numerical  solutions for T vs t
            figure;
            plot(t_forward_euler, T_forward_euler, 'b-', 'LineWidth', 2);
            xlabel('Time [min]');
            ylabel('Temperature [degC]');
            title('Numerical soln forward euler');
            grid on;
        case 5
              % Plot of numerical  solutions for T vs t
            figure;
            plot(t_backward_euler, T_backward_euler, 'b-', 'LineWidth', 2);
            xlabel('Time [min]');
            ylabel('Temperature [degC]');
            title('Numerical soln backward euler');
            grid on;
        case 6
            % plot for all numerical methods
            figure;
            plot(t_ode23,T_ode23,'y:', 'LineWidth', 2); 
            hold on 
            plot(t_ode45, T_ode45, 'b-', 'LineWidth', 2);
            hold on
            plot(t_forward_euler, T_forward_euler, 'r', 'LineWidth', 2);
            hold on
            plot(t_backward_euler, T_backward_euler, 'g--', 'LineWidth', 2);
            xlabel('Time [min]');
            ylabel('Temperature [degC]');
            legend('ode 23','ode45','forward euler','backward euler');
            title('Numerical soln of ode23,ode45,forward euler,and backward euler');         
            grid on;
            
        otherwise
            disp('Invalid flag value. Please use flag value of 1 or 2.');
    end