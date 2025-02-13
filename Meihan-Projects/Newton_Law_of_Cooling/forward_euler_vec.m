function [t,Y] = forward_euler_vec(f,tspan,ic,nsteps)
% f is a function of t,y
t0 = tspan(1);
tf = tspan(end);
h = (tf-t0)/nsteps;
t = zeros(nsteps+1,1);
Y = zeros(nsteps+1,length(ic)); % row refers to time, column refers to y versus y'
% just like ode45
t(1) = t0;
Y(1,:) = ic'; % set the first row of Y to be the initial conditions
for i = 1:(nsteps)
t(i+1) = t(i) + h;
Y(i+1,:) = Y(i,:) + h*f(t(i),Y(i,:))'; % pay attention to transpose -
% we need to be consistent with how we assign rows/columns numerical
% values
end

