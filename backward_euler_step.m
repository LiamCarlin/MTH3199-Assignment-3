%This function computes the value of X at the next time step
%using the Backward Euler approximation
%INPUTS:
%rate_func_in: the function used to compute dXdt. rate_func_in will
% have the form: dXdt = rate_func_in(t,X) (t is before X)
%t: the value of time at the current step
%XA: the value of X(t)
%h: the time increment for a single step i.e. delta_t = t_{n+1} - t_{n}
%OUTPUTS:
%XB: the approximate value for X(t+h) (the next step)
% formula depends on the integration method used
%num_evals: A count of the number of times that you called
% rate_func_in when computing the next step
%This function computes the value of X at the next time step
%using the Backward Euler approximation
function [XB,num_evals] = backward_euler_step(rate_func_in,t,XA,h)
    XA = XA(:); 

    solver_params = struct();
    solver_params.ftol = 1e-12; 

    % kept the backward Euler equation w/o count stuff
    G = @(X) XA + h.*rate_func_in(t+h,X) - X;

    [XB,exit_flag,num_evals] = multi_newton_solver(G,XA,solver_params);

    % make sure that it worked
    if exit_flag ~= 1
        error('backward euler newton solver did not converge');
    end
end
% u can just use the newton solver count beucase it is always called and it
% has its own count